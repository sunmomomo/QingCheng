//
//  Permission.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PermissionStateAll = 1,
    PermissionStatePart = 2,
    PermissionStateNone = 0,
} PermissionState;

typedef enum : NSUInteger {
    PermissionTypeRead,
    PermissionTypeEdit,
    PermissionTypeDelete,
    PermissionTypeAdd,
} PermissionType;

@interface Permission : NSObject

@property(nonatomic,copy)NSString *readKey;

@property(nonatomic,assign)PermissionState readState;

@property(nonatomic,assign)PermissionState addState;

@property(nonatomic,assign)PermissionState editState;

@property(nonatomic,assign)PermissionState deleteState;

+(instancetype)cardPermission;

+(instancetype)personalCardPermission;

+(instancetype)giftCardPermission;

+(instancetype)userPermission;

+(instancetype)personalUserPermission;

+(instancetype)studioPermission;

+(instancetype)staffPermission;

+(instancetype)coachPermission;

+(instancetype)cardKindPermission;

+(instancetype)groupArrangePermission;

+(instancetype)groupPermission;

+(instancetype)groupOrderPermission;

+(instancetype)privatePermission;

+(instancetype)privateOrderPermission;

+(instancetype)privateArrangePermission;

+(instancetype)courseOrderPermission;

+(instancetype)personalCourseOrderPermission;

+(instancetype)checkinPermission;

+(instancetype)checkinListPermission;

+(instancetype)personalCheckinListPermission;

+(instancetype)checkinSettingPermssion;

+(instancetype)activitySettingPermission;

+(instancetype)productPermission;

+(instancetype)productInventoryPermission;

+(instancetype)productReportPermission;

+(instancetype)lockerPermission;

+(instancetype)courseReportPermission;

+(instancetype)cardReportPermission;

+(instancetype)sellReportPermission;

+(instancetype)orderReportPermission;

+(instancetype)personalOrderReportPermission;

+(instancetype)personalSellReportPermission;

+(instancetype)commentsReport;

+(instancetype)permissionPermission;

+(instancetype)messagePermission;

+(instancetype)measureSettingPermission;

+(instancetype)coursePlansSettingPermission;

+(instancetype)wechatSettingPermission;

+(instancetype)noticePermission;

+(instancetype)billPermission;

+(instancetype)paySettingPermission;

+(instancetype)advertisementPermission;

+(instancetype)koubeiPermission;

+(instancetype)checkinReportPermission;

@end
