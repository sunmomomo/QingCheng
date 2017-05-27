//
//  Permissions.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Permissions.h"

@implementation Permissions

- (instancetype)init
{
    self = [super init];
    
    if (self) {
        
        self.permissions = [NSMutableArray array];

        self.cardPermission = [Permission cardPermission];
        
        [self.permissions addObject:self.cardPermission];
        
        self.personalCardPermission = [Permission personalCardPermission];
        
        [self.permissions addObject:self.personalCardPermission];

        self.giftCardPermission = [Permission giftCardPermission];
        
        [self.permissions addObject:self.giftCardPermission];

        self.userPermission = [Permission userPermission];
        
        [self.permissions addObject:self.userPermission];

        self.personalUserPermission = [Permission personalUserPermission];
        
        [self.permissions addObject:self.personalUserPermission];
        
        self.studioPermission = [Permission studioPermission];
        
        [self.permissions addObject:self.studioPermission];
        
        self.staffPermission = [Permission staffPermission];
        
        [self.permissions addObject:self.staffPermission];
        
        self.coachPermission = [Permission coachPermission];
        
        [self.permissions addObject:self.coachPermission];
        
        self.cardKindPermission = [Permission cardKindPermission];
        
        [self.permissions addObject:self.cardKindPermission];
        
        self.groupArrangePermission = [Permission groupArrangePermission];
        
        [self.permissions addObject:self.groupArrangePermission];
        
        self.groupOrderPermission = [Permission groupOrderPermission];
        
        [self.permissions addObject:self.groupOrderPermission];
        
        self.groupPermission = [Permission groupPermission];
        
        [self.permissions addObject:self.groupPermission];
        
        self.privatePermission = [Permission privatePermission];
        
        [self.permissions addObject:self.privatePermission];
        
        self.privateOrderPermission = [Permission privateOrderPermission];
        
        [self.permissions addObject:self.privateOrderPermission];
        
        self.privateArrangePermission = [Permission privateArrangePermission];
        
        [self.permissions addObject:self.privateArrangePermission];
        
        self.courseOrderPermission = [Permission courseOrderPermission];
        
        [self.permissions addObject:self.courseOrderPermission];
        
        self.personalCourseOrderPermission = [Permission personalCourseOrderPermission];
        
        [self.permissions addObject:self.personalCourseOrderPermission];
        
        self.checkinPermission = [Permission checkinPermission];
        
        [self.permissions addObject:self.checkinPermission];
        
        self.checkinListPermission = [Permission checkinListPermission];
        
        [self.permissions addObject:self.checkinListPermission];
        
        self.personalCheckinListPermission = [Permission personalCheckinListPermission];
        
        [self.permissions addObject:self.personalCheckinListPermission];
        
        self.checkinSettingPermssion = [Permission checkinSettingPermssion];
        
        [self.permissions addObject:self.checkinSettingPermssion];
        
        self.activitySettingPermission = [Permission activitySettingPermission];
        
        [self.permissions addObject:self.activitySettingPermission];
        
        self.productPermission = [Permission productPermission];
        
        [self.permissions addObject:self.productPermission];
        
        self.productInventoryPermission = [Permission productInventoryPermission];
        
        [self.permissions addObject:self.productInventoryPermission];
        
        self.productReportPermission = [Permission productReportPermission];
        
        [self.permissions addObject:self.productReportPermission];
        
        self.lockerPermission = [Permission lockerPermission];
        
        [self.permissions addObject:self.lockerPermission];
        
        self.courseReportPermission = [Permission courseReportPermission];
        
        [self.permissions addObject:self.courseReportPermission];
        
        self.cardReportPermission = [Permission cardReportPermission];
        
        [self.permissions addObject:self.cardReportPermission];
        
        self.sellReportPermission = [Permission sellReportPermission];
        
        [self.permissions addObject:self.sellReportPermission];
        
        self.orderReportPermission = [Permission orderReportPermission];
        
        [self.permissions addObject:self.orderReportPermission];
        
        self.personalOrderReportPermission = [Permission personalOrderReportPermission];
        
        [self.permissions addObject:self.personalOrderReportPermission];
        
        self.personalSellReportPermission = [Permission personalSellReportPermission];
        
        [self.permissions addObject:self.personalSellReportPermission];
        
        self.commentsReport = [Permission commentsReport];
        
        [self.permissions addObject:self.commentsReport];
        
        self.permissionPermission = [Permission permissionPermission];
        
        [self.permissions addObject:self.permissionPermission];
        
        self.messagePermission = [Permission messagePermission];
        
        [self.permissions addObject:self.messagePermission];
        
        self.measureSettingPermission = [Permission measureSettingPermission];
        
        [self.permissions addObject:self.measureSettingPermission];
        
        self.coursePlansSettingPermission = [Permission coursePlansSettingPermission];
        
        [self.permissions addObject:self.coursePlansSettingPermission];
        
        self.wechatSettingPermission = [Permission wechatSettingPermission];
        
        [self.permissions addObject:self.wechatSettingPermission];
        
        self.noticePermission = [Permission noticePermission];
        
        [self.permissions addObject:self.noticePermission];
        
        self.billPermission = [Permission billPermission];
        
        [self.permissions addObject:self.billPermission];
        
        self.paySettingPermission = [Permission paySettingPermission];
        
        [self.permissions addObject:self.paySettingPermission];
        
        self.advertisementPermission = [Permission advertisementPermission];
        
        [self.permissions addObject:self.advertisementPermission];
        
        self.koubeiPermission = [Permission koubeiPermission];
        
        [self.permissions addObject:self.koubeiPermission];
        
        self.checkinReportPermission = [Permission checkinReportPermission];
        
        [self.permissions addObject:self.checkinReportPermission];
        
    }
    
    return self;
    
}

@end
