//
//  AgentInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AgentInfo.h"

#define API @"/api/v2/coaches/%ld/method/shops/"

@implementation AgentInfo

-(void)requestReult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    switch (self.type) {
        case AgentTypeGroup:
            
            [para setParameter:@"group_order_can_write" forKey:@"key"];
            
            break;
            
        case AgentTypePrivate:
            
            [para setParameter:@"private_order_can_write" forKey:@"key"];
            
            break;
            
        default:
            break;
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
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
        
        gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
        
        gym.brandName = obj[@"brand_name"];
        
        gym.havePermission = [obj[@"has_permission"]boolValue];
        
        if (self.type == AgentTypeGroup) {
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/fitness/redirect/coach/group/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId];
            
            gym.url = [NSURL URLWithString:urlStr];
            
        }else{
            
            NSString *urlStr = [NSString stringWithFormat:@"%@/fitness/redirect/coach/private/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId];
            
            gym.url = [NSURL URLWithString:urlStr];
            
        }
        
        [self.gyms addObject:gym];
        
    }];
    
}

@end
