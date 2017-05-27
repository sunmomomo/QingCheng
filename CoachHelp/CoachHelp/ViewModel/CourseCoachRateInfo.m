//
//  CourseCoachRateInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseCoachRateInfo.h"

#define API @"/api/v1/coaches/%ld/courses/teachers/"

@implementation CourseCoachRateInfo

-(void)requestWithCourse:(Course *)course andGym:(Gym*)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setInteger:course.courseId forKey:@"course_id"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.coaches = [NSMutableArray array];
            
            NSDictionary *courseDict = responseDic[@"data"][@"course"];
            
            gym.rate.courseRate = [courseDict[@"course_score"] floatValue];
            
            gym.rate.serviceRate = [courseDict[@"service_score"] floatValue];
            
            gym.rate.coachRate = [courseDict[@"teacher_score"] floatValue];
            
            gym.shopId = [responseDic[@"data"][@"shop"][@"id"] integerValue];
            
            gym.imgUrl = [NSURL URLWithString:responseDic[@"data"][@"shop"][@"logo"]];
            
            gym.name = responseDic[@"data"][@"shop"][@"name"];
            
            [responseDic[@"data"][@"teachers"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Coach *coach = [[Coach alloc]init];
                
                NSMutableArray *impressions = [NSMutableArray array];
                
                [obj[@"impressions"] enumerateObjectsUsingBlock:^(id  _Nonnull impression, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    [impressions addObject:impression[@"comment"]];
                    
                }];
                
                coach.rate.impressions = [impressions copy];
                
                coach.rate.coachRate = [obj[@"teacher_score"] floatValue];
                
                coach.rate.serviceRate = [obj[@"service_score"] floatValue];
                
                coach.rate.courseRate = [obj[@"course_score"] floatValue];
                
                coach.name = obj[@"user"][@"username"];
                
                coach.iconUrl = [NSURL URLWithString:obj[@"user"][@"avatar"]];
                
                [self.coaches addObject:coach];
                
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
