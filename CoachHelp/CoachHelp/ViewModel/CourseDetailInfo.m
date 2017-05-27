//
//  CourseDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseDetailInfo.h"

#define API @"/api/v2/coaches/%ld/courses/%ld/"

#define CoverAPI @"/api/v2/coaches/%ld/courses/photos/"

#define ScanAPI @"/api/scans/%@/"

@interface CourseDetailInfo ()

@end

@implementation CourseDetailInfo

-(void)requestWithCourse:(Course *)course result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.course = course;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId,(long)course.courseId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createWithDict:responseDic[@"data"][@"course"]];
            
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

-(void)createWithDict:(NSDictionary *)dict
{
    
    self.course.rate.courseRate = [dict[@"course_score"] floatValue];
    
    self.course.imgUrl = [NSURL URLWithString:dict[@"photo"]];
    
    self.course.rate.serviceRate = [dict[@"service_score"] floatValue];
    
    self.course.courseId = [dict[@"id"] integerValue];
    
    self.course.type = [dict[@"is_private"] boolValue]?CourseTypePrivate:CourseTypeGroup;
    
    self.course.capacity = [dict[@"capacity"]integerValue];
    
    self.course.name = dict[@"name"];
    
    self.course.minNumber = [dict[@"min_users"] integerValue];
    
    self.course.rate.coachRate = [dict[@"teacher_score"] floatValue];
    
    self.course.during = [dict[@"length"] integerValue]/60;
    
    self.course.covers = [NSMutableArray array];
    
    self.course.courseNum = [dict[@"schedule_count"] integerValue];
    
    self.course.customCover = ![dict[@"random_show_photos"] boolValue];
    
    if ([dict[@"edit_url"] length]) {
        
        self.course.summaryURL = [NSURL URLWithString:dict[@"edit_url"]];
        
    }
    
    [dict[@"photos"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSURL *url = [NSURL URLWithString:obj];
        
        [self.course.covers addObject:url];
        
    }];
    
    self.course.gyms = [NSMutableArray array];
    
    [dict[@"shops"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *tempGym = [[Gym alloc]init];
        
        tempGym.address = obj[@"address"];
        
        tempGym.shopId = [obj[@"id"] integerValue];
        
        tempGym.name = obj[@"name"];
        
        [self.course.gyms addObject:tempGym];
        
    }];
    
    self.course.coaches = [NSMutableArray array];
    
    [dict[@"teachers"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Coach *coach = [[Coach alloc]init];
        
        coach.rateScore = [obj[@"score"] floatValue];
        
        coach.name = obj[@"username"];
        
        coach.coachId = [obj[@"id"] integerValue];
        
        if (obj[@"avatar"]) {
            
            coach.iconUrl = [NSURL URLWithString:obj[@"avatar"]];
            
        }
        
        [self.course.coaches addObject:coach];
        
    }];
    
    if ([[dict[@"plan"] allKeys] count]) {
        
        self.course.meassure.name = dict[@"plan"][@"name"];
        
        self.course.meassure.meassureId = [dict[@"plan"][@"id"] integerValue];
        
    }
    
    NSMutableArray *rates = [NSMutableArray array];
    
    [dict[@"impressions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (rates.count<5) {
            
            [rates addObject:obj[@"comment"]];
            
        }
        
    }];
    
    self.course.rate.rates = [rates copy];
    
    if ([dict[@"description"] length]) {
        
        self.course.htmlData = dict[@"description"];
        
    }
    
}

@end
