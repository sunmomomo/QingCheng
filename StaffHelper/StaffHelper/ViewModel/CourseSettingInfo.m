//
//  CourseSettingInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CourseSettingInfo.h"

#define API @"/api/staffs/%ld/shops/configs/"

@implementation CourseNotificationSetting
@end

@implementation CourseSetting
@end

@implementation CourseSettingInfo

-(void)requestCourseSettingWithCourseType:(CourseType)courseType result:(void (^)(BOOL, NSString *))result
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
        
        [para setParameter:@"team_minutes_can_order,team_minutes_can_cancel" forKey:@"keys"];
        
    }else{
        
        [para setParameter:@"private_minutes_can_order,private_minutes_can_cancel" forKey:@"keys"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.courseSetting = [[CourseSetting alloc]init];
            
            self.courseSetting.courseType = courseType;
            
            if (courseType == CourseTypeGroup) {
                
                for (NSDictionary *dict in responseDic[@"data"][@"configs"]) {
                    
                    if ([dict[@"key"] isEqualToString:@"team_minutes_can_order"]) {
                        
                        self.courseSetting.orderId = [dict[@"id"] integerValue];
                        
                        self.courseSetting.orderPretime = [dict[@"value"] integerValue];
                        
                        self.courseSetting.orderAstrict = self.courseSetting.orderPretime;
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_minutes_can_cancel"]){
                        
                        self.courseSetting.cancelId = [dict[@"id"]integerValue];
                        
                        self.courseSetting.cancelPretime = [dict[@"value"] integerValue];
                        
                        self.courseSetting.cancelAstrict = self.courseSetting.cancelPretime;
                        
                    }
                    
                }
                
            }else{
                
                for (NSDictionary *dict in responseDic[@"data"][@"configs"]) {
                    
                    if ([dict[@"key"] isEqualToString:@"private_minutes_can_order"]) {
                        
                        self.courseSetting.orderId = [dict[@"id"] integerValue];
                        
                        self.courseSetting.orderPretime = [dict[@"value"] integerValue];
                        
                        self.courseSetting.orderAstrict = self.courseSetting.orderPretime;
                        
                    }else if ([dict[@"key"]isEqualToString:@"private_minutes_can_cancel"]){
                        
                        self.courseSetting.cancelId = [dict[@"id"]integerValue];
                        
                        self.courseSetting.cancelPretime = [dict[@"value"] integerValue];
                        
                        self.courseSetting.cancelAstrict = self.courseSetting.cancelPretime;
                        
                    }
                    
                }
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)requestNotificationSettingWithCourseType:(CourseType)courseType result:(void (^)(BOOL, NSString *))result
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
        
        [para setParameter:@"team_before_remind_user,team_before_remind_user_minutes,team_course_remind_teacher,team_course_remind_teacher_minutes,team_sms_teacher_after_user_order_save,team_sms_user_after_teacher_order_save,team_sms_user_after_user_order_cancel" forKey:@"keys"];
        
    }else{
        
        [para setParameter:@"private_before_remind_user,private_before_remind_user_minutes,private_sms_teacher_after_user_order_save,private_sms_user_after_teacher_order_save,private_sms_user_after_user_order_cancel" forKey:@"keys"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.notificationSetting = [[CourseNotificationSetting alloc]init];
            
            self.notificationSetting.courseType = courseType;
            
            if (courseType == CourseTypeGroup) {
                
                for (NSDictionary *dict in responseDic[@"data"][@"configs"]) {
                    
                    if ([dict[@"key"] isEqualToString:@"team_before_remind_user"]) {
                        
                        self.notificationSetting.userRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.userRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_before_remind_user_minutes"]){
                        
                        self.notificationSetting.userRemainTime = [dict[@"value"] integerValue];
                        
                        self.notificationSetting.userRemainTimeId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_course_remind_teacher"]){
                        
                        self.notificationSetting.coachRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.coachRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_course_remind_teacher_minutes"]){
                        
                        self.notificationSetting.coachRemainTime = [dict[@"value"] integerValue];
                        
                        self.notificationSetting.coachRemainTimeId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_sms_teacher_after_user_order_save"]){
                        
                        self.notificationSetting.orderRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.orderRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_sms_user_after_teacher_order_save"]){
                        
                        self.notificationSetting.coachOrderRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.coachOrderRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"team_sms_user_after_user_order_cancel"]){
                        
                        self.notificationSetting.cancelRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.cancelRemainId = [dict[@"id"] integerValue];
                        
                    }
                    
                }
                
            }else{
                
                for (NSDictionary *dict in responseDic[@"data"][@"configs"]) {
                    
                    if ([dict[@"key"] isEqualToString:@"private_before_remind_user"]) {
                        
                        self.notificationSetting.userRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.userRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"private_before_remind_user_minutes"]){
                        
                        self.notificationSetting.userRemainTime = [dict[@"value"] integerValue];
                        
                        self.notificationSetting.userRemainTimeId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"private_sms_teacher_after_user_order_save"]){
                        
                        self.notificationSetting.orderRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.orderRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"private_sms_user_after_teacher_order_save"]){
                        
                        self.notificationSetting.coachOrderRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.coachOrderRemainId = [dict[@"id"] integerValue];
                        
                    }else if ([dict[@"key"]isEqualToString:@"private_sms_user_after_user_order_cancel"]){
                        
                        self.notificationSetting.cancelRemain = [dict[@"value"] boolValue];
                        
                        self.notificationSetting.cancelRemainId = [dict[@"id"] integerValue];
                        
                    }
                    
                }
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)updateCourseSetting:(CourseSetting *)setting result:(void (^)(BOOL, NSString *))result
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
    
    NSMutableArray *para1 = [NSMutableArray array];
    
    if (setting.orderAstrict) {
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.orderId],@"value":[NSNumber numberWithInteger:setting.orderPretime]}];
        
    }else{
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.orderId],@"value":[NSNumber numberWithInteger:0]}];
        
    }
    
    if (setting.cancelAstrict) {
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.cancelId],@"value":[NSNumber numberWithInteger:setting.cancelPretime]}];
        
    }else{
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.cancelId],@"value":[NSNumber numberWithInteger:0]}];
        
    }
    
    [para setParameter:para1 forKey:@"configs"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

-(void)updateNotificationSetting:(CourseNotificationSetting *)setting result:(void (^)(BOOL, NSString *))result
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
    
    NSMutableArray *para1 = [NSMutableArray array];
    
    [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.userRemainId],@"value":[NSNumber numberWithBool:setting.userRemain]}];
    
    [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.userRemainTimeId],@"value":[NSNumber numberWithInteger:setting.userRemainTime]}];
    
    [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.orderRemainId],@"value":[NSNumber numberWithBool:setting.orderRemain]}];
    
    [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.coachOrderRemainId],@"value":[NSNumber numberWithBool:setting.coachOrderRemain]}];
    
    [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.cancelRemainId],@"value":[NSNumber numberWithBool:setting.cancelRemain]}];
    
    if (setting.courseType == CourseTypeGroup) {
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.coachRemainId],@"value":[NSNumber numberWithBool:setting.coachRemain]}];
        
        [para1 addObject:@{@"id":[NSNumber numberWithInteger:setting.coachRemainTimeId],@"value":[NSNumber numberWithInteger:setting.coachRemainTime]}];
        
    }
    
    [para setParameter:para1 forKey:@"configs"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
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

@end
