//
//  Permissions.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Permission.h"

@interface Permissions : NSObject

@property(nonatomic,strong)Permission *cardPermission;

@property(nonatomic,strong)Permission *personalCardPermission;

@property(nonatomic,strong)Permission *giftCardPermission;

@property(nonatomic,strong)Permission *userPermission;

@property(nonatomic,strong)Permission *personalUserPermission;

@property(nonatomic,strong)Permission *studioPermission;

@property(nonatomic,strong)Permission *staffPermission;

@property(nonatomic,strong)Permission *coachPermission;

@property(nonatomic,strong)Permission *cardKindPermission;

@property(nonatomic,strong)Permission *groupArrangePermission;

@property(nonatomic,strong)Permission *groupPermission;

@property(nonatomic,strong)Permission *groupOrderPermission;

@property(nonatomic,strong)Permission *privatePermission;

@property(nonatomic,strong)Permission *privateOrderPermission;

@property(nonatomic,strong)Permission *privateArrangePermission;

@property(nonatomic,strong)Permission *courseOrderPermission;

@property(nonatomic,strong)Permission *personalCourseOrderPermission;

@property(nonatomic,strong)Permission *checkinPermission;

@property(nonatomic,strong)Permission *checkinListPermission;

@property(nonatomic,strong)Permission *personalCheckinListPermission;

@property(nonatomic,strong)Permission *checkinSettingPermssion;

@property(nonatomic,strong)Permission *activitySettingPermission;

@property(nonatomic,strong)Permission *productPermission;

@property(nonatomic,strong)Permission *productInventoryPermission;

@property(nonatomic,strong)Permission *productReportPermission;

@property(nonatomic,strong)Permission *lockerPermission;

@property(nonatomic,strong)Permission *courseReportPermission;

@property(nonatomic,strong)Permission *cardReportPermission;

@property(nonatomic,strong)Permission *sellReportPermission;

@property(nonatomic,strong)Permission *orderReportPermission;

@property(nonatomic,strong)Permission *personalOrderReportPermission;

@property(nonatomic,strong)Permission *personalSellReportPermission;

@property(nonatomic,strong)Permission *commentsReport;

@property(nonatomic,strong)Permission *permissionPermission;

@property(nonatomic,strong)Permission *messagePermission;

@property(nonatomic,strong)Permission *measureSettingPermission;

@property(nonatomic,strong)Permission *coursePlansSettingPermission;

@property(nonatomic,strong)Permission *wechatSettingPermission;

@property(nonatomic,strong)Permission *noticePermission;

@property(nonatomic,strong)Permission *billPermission;

@property(nonatomic,strong)Permission *paySettingPermission;

@property(nonatomic,strong)Permission *advertisementPermission;

@property(nonatomic,strong)Permission *koubeiPermission;

@property(nonatomic,strong)Permission *checkinReportPermission;

@property(nonatomic,strong)Permission *integralPermisson;

@property(nonatomic,strong)Permission *integralRankPermission;

@property(nonatomic,strong)Permission *groupLimitPermission;

@property(nonatomic,strong)Permission *groupMessagePermission;

@property(nonatomic,strong)Permission *privateLimitPermission;

@property(nonatomic,strong)Permission *privateMessagePermission;

@property(nonatomic,strong)Permission *staffPositionPermission;

@property(nonatomic,strong)Permission *coachPositionPermission;

@property(nonatomic,strong)Permission *spacePermission;

@property(nonatomic,strong)Permission *homepagePermission;

@property(nonatomic,strong)Permission *checkinLockerPermission;

@property(nonatomic,strong)Permission *checkinScreenPermission;

@property(nonatomic,strong)Permission *cardbalancePermission;

@property(nonatomic,strong)NSMutableArray *permissions;

@end
