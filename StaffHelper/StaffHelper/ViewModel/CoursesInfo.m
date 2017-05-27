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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.groupCourses = [NSMutableArray array];
        
        self.privateCourses = [NSMutableArray array];
        
    }
    return self;
}


-(void)requestWithGym:(Gym *)gym
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

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

-(void)createDataWithDict:(NSDictionary *)dict
{
    
    self.users = [NSMutableArray array];
    
    NSArray *courseArray = dict[@"courses"];
    
    NSArray *userArray = dict[@"users"];
    
    [courseArray enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Course *course = [[Course alloc]init];
        
        course.courseId = [obj[@"id"] integerValue];
        
        course.name = obj[@"name"];
        
        [self.groupCourses addObject:course];
        
    }];
    
    [userArray enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Student *student = [[Student alloc]init];
        
        student.stuId = [obj[@"id"] integerValue];
        
        student.name = obj[@"username"];
        
        student.phone = obj[@"phone"];
        
        student.sex = [obj[@"gender"] integerValue]?SexTypeWoman:SexTypeMan;
        
        student.avatar = [NSURL URLWithString:obj[@"avatar"]];
        
        student.head = obj[@"head"];
        
        [self.users addObject:student];
        
    }];
    
    if (self.request) {
        self.request(YES);
    }
    
}

@end
