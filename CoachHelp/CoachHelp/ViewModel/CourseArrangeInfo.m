//
//  CourseArrangeInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseArrangeInfo.h"

#define API @"/api/v1/coaches/%ld/batches/"

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
        
        [para setParameter:[NSNumber numberWithBool:NO] forKey:@"is_private"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                NSArray *array = responseDic[@"data"][@"batches"];
                
                NSMutableArray *groups = [NSMutableArray array];
                
                self.groupURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
                
                NSDictionary *coachDict = responseDic[@"data"][@"coach"];
                
                Coach *coach = [[Coach alloc]init];
                
                coach.name = coachDict[@"username"];
                
                coach.coachId = [coachDict[@"id"] integerValue];
                
                coach.iconUrl = [NSURL URLWithString:coachDict[@"avatar"]];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                    
                    batch.coach = coach;
                    
                    Course *course = [[Course alloc]init];
                    
                    course.courseId = [obj[@"course"][@"id"] integerValue];
                    
                    course.name = obj[@"course"][@"name"];
                    
                    course.imgUrl = [NSURL URLWithString:obj[@"course"][@"photo"]];
                    
                    course.during = [obj[@"course"][@"length"] integerValue]/60;
                    
                    course.type = CourseTypeGroup;
                    
                    batch.batchId = [obj[@"id"] integerValue];
                    
                    batch.start = obj[@"from_date"];
                    
                    batch.end = obj[@"to_date"];
                    
                    batch.course = course;
                    
                    [groups addObject:batch];
                    
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
        
        [para setParameter:[NSNumber numberWithBool:YES] forKey:@"is_private"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                NSArray *array = responseDic[@"data"][@"batches"];
                
                NSMutableArray *privates = [NSMutableArray array];
                
                self.privateURL = [NSURL URLWithString:responseDic[@"data"][@"order_url"]];
                
                [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    CoursePlanBatch *batch = [[CoursePlanBatch alloc]init];
                    
                    Course *course = [[Course alloc]init];
                    
                    course.courseId = [obj[@"course"][@"id"] integerValue];
                    
                    course.name = obj[@"course"][@"name"];
                    
                    course.imgUrl = [NSURL URLWithString:obj[@"course"][@"photo"]];
                    
                    course.type = CourseTypePrivate;
                    
                    batch.batchId = [obj[@"id"] integerValue];
                    
                    batch.start = obj[@"from_date"];
                    
                    batch.end = obj[@"to_date"];
                    
                    batch.course = course;
                    
                    [privates addObject:batch];
                    
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

@end
