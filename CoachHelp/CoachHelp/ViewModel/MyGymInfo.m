//
//  MyGymInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyGymInfo.h"

#define API @"/api/v1/coaches/%ld/services/"

@implementation MyGymInfo

-(void)requestData
{
    
    if (!CoachId) {
        
        if (self.request) {
            self.request(NO);
        }
        
    }else
    {
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createDataWithArray:responseDic[@"data"][@"services"]];
                
            }else
            {
                
                if (self.request) {
                    self.request(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.request) {
                self.request(NO);
            }
            
        }];
        
    }
    
    
}

-(void)createDataWithArray:(NSArray *)array
{
    
    self.gyms = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *gym = [[Gym alloc]init];
        
        gym.name = obj[@"name"];
        
        gym.gymId = [obj[@"id"] integerValue];
        
        gym.url = [NSURL URLWithString:obj[@"url"]];
        
        gym.userCount = [obj[@"users_count"]integerValue];
        
        gym.courseCount = [obj[@"courses_count"]integerValue];
                
        gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
        
        gym.type = obj[@"model"];
        
        gym.brandName = obj[@"brand_name"];
        
        [self.gyms addObject:gym];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

@end
