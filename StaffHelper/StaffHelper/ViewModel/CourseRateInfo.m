//
//  CourseRateInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseRateInfo.h"

#define API @"/api/v2/staffs/%ld/courses/shops/score/"

@implementation CourseRateInfo

-(void)requestWithCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:course.courseId forKey:@"course_id"];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            course.rate.coachRate = [responseDic[@"data"][@"scores"][@"course"][@"teacher_score"] floatValue] ;
            
            course.rate.courseRate = [responseDic[@"data"][@"scores"][@"course"][@"course_score"] floatValue] ;
            
            course.rate.serviceRate = [responseDic[@"data"][@"scores"][@"course"][@"service_score"] floatValue] ;
            
            self.gyms = [NSMutableArray array];
            
            [responseDic[@"data"][@"scores"][@"shops"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
               
                Gym *gym = [[Gym alloc]init];
                
                gym.name = obj[@"name"];
                
                gym.shopId = [obj[@"id"] integerValue];
                
                gym.imgUrl = [NSURL URLWithString:obj[@"logo"]];
                
                gym.rate.coachRate = [obj[@"teacher_score"] floatValue];
                
                gym.rate.courseRate = [obj[@"course_score"] floatValue];
                
                gym.rate.serviceRate = [obj[@"service_score"] floatValue];
                
                NSMutableArray *rates = [NSMutableArray array];
                
                [obj[@"impressions"] enumerateObjectsUsingBlock:^(NSDictionary *impression, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [rates addObject:impression[@"comment"]];
                    
                }];
                
                gym.rate.rates = [rates copy];
                
                [self.gyms addObject:gym];
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end
