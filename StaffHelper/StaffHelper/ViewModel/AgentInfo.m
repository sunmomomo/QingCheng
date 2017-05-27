//
//  AgentInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AgentInfo.h"

#define API @"/api/staffs/%ld/actions/redirect/"

@implementation AgentInfo

-(void)requestWithDate:(NSDate *)date andStudent:(Student*)student
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[df stringFromDate:date] forKey:@"date"];
    
    [para setParameter:self.type == AgentTypeGroup?@"grouplesson":self.type == AgentTypePrivate?@"privatelesson":@"rest" forKey:@"action"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    if (student) {
        
        [para setParameter:[NSNumber numberWithInteger:student.stuId] forKey:@"user_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
            if (self.requestFinish) {
                
                self.requestFinish(YES);
                
            }
            
        }else
        {
            
            if (self.requestFinish) {
                
                self.requestFinish(NO);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            
            self.requestFinish(NO);
            
        }
        
    }];
    
}

-(void)createDataWithArray:(NSArray*)array
{
    
    self.gyms = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *gym = [[Gym alloc]init];
        
        gym.type = obj[@"model"];
        
        gym.name = obj[@"name"];
        
        gym.gymId = [obj[@"id"] integerValue];
        
        gym.shopId = [obj[@"shop_id"] integerValue];
        
        gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
        
        gym.url = [NSURL URLWithString:obj[@"url"]];
        
        gym.brand.name = obj[@"brand_name"];
        
        gym.brand.brandId = [obj[@"brand_id"] integerValue];
        
        [self.gyms addObject:gym];
        
    }];
    
}

@end
