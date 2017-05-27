//
//  CourseSettingInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseSetting : NSObject

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,assign)NSInteger orderPretime;

@property(nonatomic,assign)BOOL orderAstrict;

@property(nonatomic,assign)NSInteger cancelPretime;

@property(nonatomic,assign)BOOL cancelAstrict;

@property(nonatomic,assign)BOOL canQueue;

@property(nonatomic,assign)NSInteger orderId;

@property(nonatomic,assign)NSInteger cancelId;

@end

@interface CourseNotificationSetting : NSObject

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,assign)NSInteger userRemainTime;

@property(nonatomic,assign)NSInteger userRemainTimeId;

@property(nonatomic,assign)BOOL userRemain;

@property(nonatomic,assign)NSInteger userRemainId;

@property(nonatomic,assign)NSInteger coachRemainTime;

@property(nonatomic,assign)NSInteger coachRemainTimeId;

@property(nonatomic,assign)BOOL coachRemain;

@property(nonatomic,assign)NSInteger coachRemainId;

@property(nonatomic,assign)BOOL orderRemain;

@property(nonatomic,assign)NSInteger orderRemainId;

@property(nonatomic,assign)BOOL coachOrderRemain;

@property(nonatomic,assign)NSInteger coachOrderRemainId;

@property(nonatomic,assign)BOOL cancelRemain;

@property(nonatomic,assign)NSInteger cancelRemainId;

@property(nonatomic,assign)BOOL queueRemain;

@property(nonatomic,assign)NSInteger queueRemainId;

@end

@interface CourseSettingInfo : NSObject

@property(nonatomic,strong)CourseSetting *courseSetting;

@property(nonatomic,strong)CourseNotificationSetting *notificationSetting;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestCourseSettingWithCourseType:(CourseType)courseType result:(void(^)(BOOL success,NSString *error))result;

-(void)requestNotificationSettingWithCourseType:(CourseType)courseType result:(void(^)(BOOL success,NSString *error))result;

-(void)updateCourseSetting:(CourseSetting*)setting result:(void(^)(BOOL success,NSString *error))result;

-(void)updateNotificationSetting:(CourseNotificationSetting*)setting result:(void(^)(BOOL success,NSString *error))result;

@end
