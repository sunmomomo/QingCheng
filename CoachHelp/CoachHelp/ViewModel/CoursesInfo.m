//
//  CoursesInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/15.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CoursesInfo.h"

#define API @"/api/v1/services/detail/"

@implementation CoursesInfo

-(instancetype)initWithGym:(Gym *)gym
{
    
    if (self = [super init]) {
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:API param:para.data  success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createDataWithDict:responseDic[@"data"][@"service"]];
                
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
    
    return self;
    
}

-(void)createDataWithDict:(NSDictionary *)dict
{
    
    self.courses = [NSMutableArray array];
    
    self.users = [NSMutableArray array];
    
    NSArray *courseArray = dict[@"courses"];
    
    NSArray *userArray = dict[@"users"];
    
    [courseArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Course *course = [[Course alloc]init];
        
        course.courseId = [obj[@"id"] integerValue];
        
        course.name = obj[@"name"];
        
        [self.courses addObject:course];
        
    }];
    
    [userArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Student *student = [[Student alloc]init];
        
        student.stuId = [obj[@"id"] integerValue];
        
        student.name = obj[@"username"];
        
        student.phone = obj[@"phone"];
        
        student.gender = [obj[@"gender"] integerValue]?@"女":@"男";
        
        student.photo = [NSURL URLWithString:obj[@"avatar"]];
        
        student.head = obj[@"head"];
        
        [self.users addObject:student];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

@end
