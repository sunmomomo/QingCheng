//
//  CourseArrangeInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseArrangeInfo.h"

#define GroupAPI @"/api/staffs/%ld/group/courses/"

#define PrivateAPI @"/api/staffs/%ld/private/coaches/"

@implementation CourseArrangeInfo

-(void)requestDataWithCourseType:(CourseType)courseType result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    if (courseType == CourseTypeGroup) {
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:GroupAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                NSArray *array = responseDic[@"data"][@"courses"];
                
                NSMutableArray *groups = [NSMutableArray array];
                
                self.groupURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Course *course = [[Course alloc]init];
                    
                    course.courseId = [obj[@"id"] integerValue];
                    
                    course.name = obj[@"name"];
                    
                    course.start = obj[@"from_date"];
                    
                    course.end = obj[@"to_date"];
                    
                    course.count = [obj[@"count"] integerValue];
                    
                    course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                    
                    course.during = [obj[@"length"] integerValue]/60;
                    
                    course.type = CourseTypeGroup;
                    
                    [groups addObject:course];
                    
                }];
                
                self.groups = [groups copy];
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                    
                }
                
            }else
            {
                
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
        
    }else{
        
        [para setParameter:@"1" forKey:@"course__is_private"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PrivateAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                NSArray *array = responseDic[@"data"][@"coaches"];
                
                NSMutableArray *privates = [NSMutableArray array];
                
                self.privateURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Coach *coach = [[Coach alloc]init];
                    
                    coach.name = obj[@"username"];
                    
                    coach.coachId = [obj[@"id"] integerValue];
                    
                    if ([obj[@"from_date"] length]) {
                        
                        coach.start = obj[@"from_date"];
                        
                    }
                    
                    if ([obj[@"to_date"] length]) {
                        
                        coach.end = obj[@"to_date"];
                        
                    }
                    
                    coach.count = [obj[@"courses_count"] integerValue];
                    
                    coach.iconUrl = [NSURL URLWithString:obj[@"avatar"]];
                    
                    [privates addObject:coach];
                    
                }];
                
                self.privates = [privates copy];
                
                if (self.callBack) {
                    
                    self.callBack(YES,nil);
                    
                    self.callBack = nil;
                    
                }
                
            }else
            {
                
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
    
}

-(void)requestDataWithGym:(Gym *)gym
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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:GroupAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"courses"];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            self.groupURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Course *course = [[Course alloc]init];
                
                course.courseId = [obj[@"id"] integerValue];
                
                course.name = obj[@"name"];
                
                course.start = obj[@"from_date"];
                
                course.end = obj[@"to_date"];
                
                course.count = [obj[@"count"] integerValue];
                
                course.imgUrl = [NSURL URLWithString:obj[@"photo"]];
                
                course.during = [obj[@"length"] integerValue]/60;
                
                course.type = CourseTypeGroup;
                
                [groups addObject:course];
                
            }];
            
            self.groups = [groups copy];
            
            if (self.groupFinish) {
                
                self.groupFinish(YES);
                
                self.groupFinish = nil;
                
            }
            
        }else
        {
            
            if (self.groupFinish) {
                
                self.groupFinish(YES);
                
                self.groupFinish = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.groupFinish) {
            
            self.groupFinish(NO);
            
            self.groupFinish = nil;
            
        }
        
    }];
    
    [para setParameter:@"1" forKey:@"course__is_private"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:PrivateAPI,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"coaches"];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            self.privateURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Coach *coach = [[Coach alloc]init];
                
                coach.name = obj[@"username"];
                
                coach.coachId = [obj[@"id"] integerValue];
                
                if ([obj[@"from_date"] length]) {
                    
                    coach.start = obj[@"from_date"];
                    
                }
                
                if ([obj[@"to_date"] length]) {
                    
                    coach.end = obj[@"to_date"];
                    
                }
                
                coach.count = [obj[@"courses_count"] integerValue];
                
                coach.iconUrl = [NSURL URLWithString:obj[@"avatar"]];
                
                [privates addObject:coach];
                
            }];
            
            self.privates = [privates copy];
            
            if (self.privateFinish) {
                
                self.privateFinish(YES);
                
                self.privateFinish = nil;
                
            }
            
        }else
        {
            
            if (self.privateFinish) {
                
                self.privateFinish(YES);
                
                self.privateFinish = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.privateFinish) {
            
            self.privateFinish(NO);
            
            self.privateFinish = nil;
            
        }
        
    }];
    
}

@end
