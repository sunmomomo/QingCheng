//
//  PermissionInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "PermissionInfo.h"

#define API @"/api/v2/coaches/%ld/permissions/"

#define StaffAPI @"/api/v2/coaches/%ld/staffs/permissions/"

@implementation PermissionInfo

+(instancetype)sharedInfo
{
    
    static PermissionInfo* info;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        info = [[PermissionInfo alloc]init];
        
    });
    
    return info;
    
}

-(void)requestWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.gymCallBack = result;
    
    self.gym = [gym copy];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (gym.gymId && gym.type.length) {
        
        [para setInteger:gym.gymId forKey:@"id"];
        
        [para setParameter:gym.type forKey:@"model"];
        
    }else{
        
        [para setInteger:gym.shopId forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.gym = [self createGymDataWithArray:responseDic[@"data"][@"permissions"]];
            
            AppGym.permissions = self.gym.permissions;
            
            if (self.gymCallBack) {
                
                self.gymCallBack(YES,nil);
                
                self.gymCallBack = nil;
                
            }
            
        }else{
            
            if (self.gymCallBack) {
                
                self.gymCallBack(NO,responseDic[@"msg"]);
                
                self.gymCallBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.gymCallBack) {
            
            self.gymCallBack(NO,error);
            
            self.gymCallBack = nil;
            
        }
        
    }];
    
}

-(void)requestStaffPermissionWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.gymCallBack = result;
    
    self.gym = [gym copy];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (gym.gymId && gym.type.length) {
        
        [para setInteger:gym.gymId forKey:@"id"];
        
        [para setParameter:gym.type forKey:@"model"];
        
    }else{
        
        [para setInteger:gym.shopId forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:StaffAPI,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.gym = [self createGymDataWithArray:responseDic[@"data"][@"permissions"]];
            
            AppGym.permissions = self.gym.permissions;
            
            if (self.gymCallBack) {
                
                self.gymCallBack(YES,nil);
                
                self.gymCallBack = nil;
                
            }
            
        }else{
            
            if (self.gymCallBack) {
                
                self.gymCallBack(NO,responseDic[@"msg"]);
                
                self.gymCallBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.gymCallBack) {
            
            self.gymCallBack(NO,error);
            
            self.gymCallBack = nil;
            
        }
        
    }];
    
}

-(void)createBrandPermissionsWithArray:(NSArray *)array
{
    
    NSMutableArray *gyms = [NSMutableArray array];
    
    for (NSDictionary *dict in array) {
        
        BOOL contains = NO;
        
        for (NSMutableArray *permissionArray in gyms) {
            
            if (permissionArray.count) {
                
                NSDictionary *permissionDict = [permissionArray firstObject];
                
                if ([permissionDict[@"shop_id"] integerValue] == [dict[@"shop_id"] integerValue]) {
                    
                    contains = YES;
                    
                    [permissionArray addObject:dict];
                    
                    break;
                    
                }
                
            }
            
        }
        
        if (!contains) {
            
            NSMutableArray *tempArray = [NSMutableArray array];
            
            [tempArray addObject:dict];
            
            [gyms addObject:tempArray];
            
        }
        
    }
    
    _gyms = [NSMutableArray array];
    
    [gyms enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *tempGym = [self createGymDataWithArray:obj];
        
        [_gyms addObject:tempGym];
        
    }];
    
    self.brandPermissions = [[Permissions alloc]init];
    
    for (Permission *permission in self.brandPermissions.permissions) {
        
        NSInteger readNum = 0;
        
        NSInteger addNum = 0;
        
        NSInteger editNum = 0;
        
        NSInteger deleteNum = 0;
        
        for (Gym *gym in _gyms) {
            
            for (Permission *tempPermission in gym.permissions.permissions) {
                
                if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                    
                    if(tempPermission.readState){
                     
                        readNum++;
                    
                    }
                    
                    if (tempPermission.addState) {
                        
                        addNum++;
                        
                    }
                    
                    if (tempPermission.editState) {
                        
                        editNum++;
                        
                    }
                    
                    if (tempPermission.deleteState) {
                        
                        deleteNum++;
                        
                    }
                    
                }
                
            }
            
        }
        
        if (readNum >= _gyms.count) {
            
            permission.readState =  PermissionStateAll;
            
        }else if (readNum == 0){
            
            permission.readState = PermissionStateNone;
            
        }else{
            
            permission.readState = PermissionStatePart;
            
        }
        
        if (addNum >= _gyms.count) {
            
            permission.addState =  PermissionStateAll;
            
        }else if (addNum == 0){
            
            permission.addState = PermissionStateNone;
            
        }else{
            
            permission.addState = PermissionStatePart;
            
        }
        
        if (editNum >= _gyms.count) {
            
            permission.editState =  PermissionStateAll;
            
        }else if (editNum == 0){
            
            permission.editState = PermissionStateNone;
            
        }else{
            
            permission.editState = PermissionStatePart;
            
        }
        
        if (deleteNum >= _gyms.count) {
            
            permission.deleteState =  PermissionStateAll;
            
        }else if (deleteNum == 0){
            
            permission.deleteState = PermissionStateNone;
            
        }else{
            
            permission.deleteState = PermissionStatePart;
            
        }
        
    }
    
}



-(Gym*)createGymDataWithArray:(NSArray*)array
{
    
    Gym *gym = [[Gym alloc]init];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (!gym.shopId) {
            
            gym.shopId = [obj[@"shop_id"] integerValue];
            
        }
        
        if ([obj[@"key"] isEqualToString:@"studio_list"]) {
            
            gym.permissions.studioPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"studio_list_can_write"]) {
            
            gym.permissions.studioPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"studio_list_can_change"]) {
            
            gym.permissions.studioPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"studio_list_can_delete"]) {
            
            gym.permissions.studioPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"permissionsetting"]) {
            
            gym.permissions.permissionPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"permissionsetting_can_write"]) {
            
            gym.permissions.permissionPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"permissionsetting_can_change"]) {
            
            gym.permissions.permissionPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"permissionsetting_can_delete"]) {
            
            gym.permissions.permissionPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"messagesetting"]) {
            
            gym.permissions.messagePermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"messagesetting_can_change"]) {
            
            gym.permissions.messagePermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_staff"]) {
            
            gym.permissions.staffPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_staff_can_write"]) {
            
            gym.permissions.staffPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_staff_can_change"]) {
            
            gym.permissions.staffPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_staff_can_delete"]) {
            
            gym.permissions.staffPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"coachsetting"]) {
            
            gym.permissions.coachPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"coachsetting_can_write"]) {
            
            gym.permissions.coachPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"coachsetting_can_change"]) {
            
            gym.permissions.coachPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"coachsetting_can_delete"]) {
            
            gym.permissions.coachPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_members"]) {
            
            gym.permissions.userPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_members_can_write"]) {
            
            gym.permissions.userPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_members_can_change"]) {
            
            gym.permissions.userPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_members_can_delete"]) {
            
            gym.permissions.userPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_manage_members"]) {
            
            gym.permissions.personalUserPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_manage_members_can_write"]) {
            
            gym.permissions.personalUserPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_manage_members_can_change"]) {
            
            gym.permissions.personalUserPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_manage_members_can_delete"]) {
            
            gym.permissions.personalUserPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_costs"]) {
            
            gym.permissions.cardPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_costs_can_write"]) {
            
            gym.permissions.cardPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"manage_costs_can_change"]) {
            
            gym.permissions.cardPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_card_list"]) {
            
            gym.permissions.personalCardPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_card_list_can_write"]) {
            
            gym.permissions.personalCardPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_card_list_can_change"]) {
            
            gym.permissions.personalCardPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"cardsetting"]) {
            
            gym.permissions.cardKindPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"cardsetting_can_write"]) {
            
            gym.permissions.cardKindPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"cardsetting_can_change"]) {
            
            gym.permissions.cardKindPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"cardsetting_can_delete"]) {
            
            gym.permissions.cardKindPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"giftcard"]) {
            
            gym.permissions.giftCardPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"giftcard_can_write"]) {
            
            gym.permissions.giftCardPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"giftcard_can_change"]) {
            
            gym.permissions.giftCardPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamarrange_calendar"]) {
            
            gym.permissions.groupArrangePermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamarrange_calendar_can_write"]) {
            
            gym.permissions.groupArrangePermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamarrange_calendar_can_change"]) {
            
            gym.permissions.groupArrangePermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamarrange_calendar_can_delete"]) {
            
            gym.permissions.groupArrangePermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamsetting"]) {
            
            gym.permissions.groupPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamsetting_can_write"]) {
            
            gym.permissions.groupPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamsetting_can_change"]) {
            
            gym.permissions.groupPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"teamsetting_can_delete"]) {
            
            gym.permissions.groupPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"priarrange_calendar"]) {
            
            gym.permissions.privateArrangePermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"priarrange_calendar_can_write"]) {
            
            gym.permissions.privateArrangePermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"priarrange_calendar_can_change"]) {
            
            gym.permissions.privateArrangePermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"priarrange_calendar_can_delete"]) {
            
            gym.permissions.privateArrangePermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"group_order_can_write"]) {
            
            gym.permissions.groupOrderPermission.addState = [obj[@"value"]boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"group_order_can_write"]) {
            
            gym.permissions.groupOrderPermission.addState = [obj[@"value"]boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"private_order_can_write"]) {
            
            gym.permissions.privateOrderPermission.addState = [obj[@"value"]boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"prisetting"]) {
            
            gym.permissions.privatePermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"prisetting_can_write"]) {
            
            gym.permissions.privatePermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"prisetting_can_change"]) {
            
            gym.permissions.privatePermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"prisetting_can_delete"]) {
            
            gym.permissions.privatePermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"orders_day"]) {
            
            gym.permissions.courseOrderPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"orders_day_can_write"]) {
            
            gym.permissions.courseOrderPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"orders_day_can_change"]) {
            
            gym.permissions.courseOrderPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"orders_day_can_delete"]) {
            
            gym.permissions.courseOrderPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_orders_list"]) {
            
            gym.permissions.personalCourseOrderPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_orders_list_can_write"]) {
            
            gym.permissions.personalCourseOrderPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_orders_list_can_change"]) {
            
            gym.permissions.personalCourseOrderPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_orders_list_can_delete"]) {
            
            gym.permissions.personalCourseOrderPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_help"]) {
            
            gym.permissions.checkinPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_help_can_write"]) {
            
            gym.permissions.checkinPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"locker_setting"]) {
            
            gym.permissions.lockerPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"locker_setting_can_write"]) {
            
            gym.permissions.lockerPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"locker_setting_can_change"]) {
            
            gym.permissions.lockerPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"locker_setting_can_delete"]) {
            
            gym.permissions.lockerPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_list"]) {
            
            gym.permissions.checkinListPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_list_can_change"]) {
            
            gym.permissions.checkinListPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_checkin_list"]) {
            
            gym.permissions.personalCheckinListPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_checkin_list_can_change"]) {
            
            gym.permissions.personalCheckinListPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_setting"]) {
            
            gym.permissions.checkinSettingPermssion.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_setting_can_change"]) {
            
            gym.permissions.checkinSettingPermssion.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"activity_setting"]) {
            
            gym.permissions.activitySettingPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"activity_setting_can_write"]) {
            
            gym.permissions.activitySettingPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"activity_setting_can_change"]) {
            
            gym.permissions.activitySettingPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_list"]) {
            
            gym.permissions.productPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_list_can_write"]) {
            
            gym.permissions.productPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_inventory"]) {
            
            gym.permissions.productInventoryPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_inventory_can_write"]) {
            
            gym.permissions.productInventoryPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_inventory_can_change"]) {
            
            gym.permissions.productInventoryPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_reports"]) {
            
            gym.permissions.productReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"commodity_reports_can_delete"]) {
            
            gym.permissions.productReportPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"class_report"]) {
            
            gym.permissions.orderReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_class_report"]) {
            
            gym.permissions.personalOrderReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"sales_report"]) {
            
            gym.permissions.sellReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"personal_sales_report"]) {
            
            gym.permissions.personalSellReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"cost_report"]) {
            
            gym.permissions.courseReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"card_report"]) {
            
            gym.permissions.cardReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"measuresetting"]) {
            
            gym.permissions.measureSettingPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"measuresetting_can_write"]) {
            
            gym.permissions.measureSettingPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"measuresetting_can_change"]) {
            
            gym.permissions.measureSettingPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"measuresetting_can_delete"]) {
            
            gym.permissions.measureSettingPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"planssetting"]) {
            
            gym.permissions.coursePlansSettingPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"planssetting_can_write"]) {
            
            gym.permissions.coursePlansSettingPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"planssetting_can_change"]) {
            
            gym.permissions.coursePlansSettingPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"planssetting_can_delete"]) {
            
            gym.permissions.coursePlansSettingPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"wechatsetting"]) {
            
            gym.permissions.wechatSettingPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"comments_report"]) {
            
            gym.permissions.commentsReport.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"notice"]) {
            
            gym.permissions.noticePermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"notice_can_write"]) {
            
            gym.permissions.noticePermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"notice_can_change"]) {
            
            gym.permissions.noticePermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"pay_bills"]) {
            
            gym.permissions.billPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"pay_bills_can_write"]) {
            
            gym.permissions.billPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"pay_setting"]) {
            
            gym.permissions.paySettingPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"pay_setting_can_write"]) {
            
            gym.permissions.paySettingPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"pay_setting_can_delete"]) {
            
            gym.permissions.paySettingPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"mobile_advertisement_setting"]) {
            
            gym.permissions.advertisementPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"mobile_advertisement_setting_can_write"]) {
            
            gym.permissions.advertisementPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"mobile_advertisement_setting_change"]) {
            
            gym.permissions.advertisementPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"mobile_advertisement_setting_can_delete"]) {
            
            gym.permissions.advertisementPermission.deleteState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"koubei"]) {
            
            gym.permissions.koubeiPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"koubei_can_write"]) {
            
            gym.permissions.koubeiPermission.addState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"koubei_can_change"]) {
            
            gym.permissions.koubeiPermission.editState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
        if ([obj[@"key"] isEqualToString:@"checkin_report"]) {
            
            gym.permissions.checkinReportPermission.readState = [obj[@"value"] boolValue]?PermissionStateAll:PermissionStateNone;
            
        }
        
    }];
    
    return gym;
    
}

-(Permissions *)permissions
{
    
    if (AppGym) {
        
        return self.gym.permissions;
        
    }else{
        
        if (self.gyms.count) {
            
            return self.brandPermissions;
            
        }else{
            
            return self.gym.permissions;
            
        }
        
    }
    
}

-(NSArray *)getPermissionNotIgnoredWithGyms:(NSArray *)gyms
{
    
    if (self.gyms.count) {
        
        NSMutableArray *currentGyms = [NSMutableArray array];
        
        for (Gym *gym in gyms) {
            
            BOOL haveGym = NO;
            
            for (Gym *permissionGym in _gyms) {
                
                if (gym.shopId == permissionGym.shopId) {
                    
                    gym.permissions = permissionGym.permissions;
                    
                    haveGym = YES;
                    
                    break;
                    
                }
                
            }
            
            if (haveGym) {
                
                [currentGyms addObject:gym];
                
            }
            
        }
        
        return currentGyms;
        
    }else{
        
        NSMutableArray *currentGyms = [NSMutableArray array];
        
        for (Gym *gym in gyms) {
            
            BOOL haveGym = NO;
            
            if (gym.shopId == _gym.shopId) {
                
                gym.permissions = _gym.permissions;
                
                haveGym = YES;
                
                break;
                
            }
            
            if (haveGym) {
                
                [currentGyms addObject:gym];
                
            }
            
        }
        
        return currentGyms;
        
    }
    
}

-(void)getPermissionWithGyms:(NSArray *)gyms
{
    
    if (self.gyms.count) {
        
        for (Gym *gym in gyms) {
            
            for (Gym *permissionGym in _gyms) {
                
                if (gym.shopId == permissionGym.shopId) {
                    
                    gym.permissions = permissionGym.permissions;
                    
                }
                
            }
            
        }
        
    }else{
        
        for (Gym *gym in gyms) {
            
            if (gym.shopId == _gym.shopId) {
                
                gym.permissions = _gym.permissions;
                
            }
            
        }
        
    }
    
}

-(PermissionState)getPermissionStateWithGyms:(NSArray *)gyms andPermission:(Permission*)permission andType:(PermissionType)type
{
    
    if (self.gyms.count) {
        
        NSInteger i = 0;
        
        for (Gym *gym in gyms) {
            
            for (Gym *tempGym in _gyms) {
                
                if (gym.shopId == tempGym.shopId) {
                    
                    for (Permission *tempPermission in tempGym.permissions.permissions) {
                        
                        if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                            
                            switch (type) {
                                case PermissionTypeRead:
                                    
                                    if (tempPermission.readState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeAdd:
                                    
                                    if (tempPermission.addState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeEdit:
                                    
                                    if (tempPermission.editState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeDelete:
                                    
                                    if (tempPermission.deleteState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        if (i == gyms.count) {
            
            return PermissionStateAll;
            
        }else if (i>0){
            
            return PermissionStatePart;
            
        }else{
            
            return PermissionStateNone;
            
        }
        
    }else{
        
        PermissionState state = 0;
        
        for (Gym *gym in gyms) {
            
            if (gym.shopId == _gym.shopId) {
                
                for (Permission *tempPermission in _gym.permissions.permissions) {
                    
                    if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                        
                        switch (type) {
                            case PermissionTypeRead:
                                
                                state = tempPermission.readState;
                                
                                break;
                                
                            case PermissionTypeAdd:
                                
                                state = tempPermission.addState;
                                
                                break;
                                
                            case PermissionTypeEdit:
                                
                                state = tempPermission.editState;
                                
                                break;
                                
                            case PermissionTypeDelete:
                                
                                state = tempPermission.deleteState;
                                
                                break;
                                
                            default:
                                
                                break;
                        }
                        
                        break;
                        
                    }
                    
                }
                
            }else{
                
                return 0;
                
            }
            
        }
        
        return state;
        
    }
    
}

-(NSInteger)getPermissionCountWithGyms:(NSArray *)gyms andPermission:(Permission*)permission andType:(PermissionType)type
{
    
    if (self.gyms.count) {
        
        NSInteger i = 0;
        
        for (Gym *gym in gyms) {
            
            for (Gym *tempGym in _gyms) {
                
                if (gym.shopId == tempGym.shopId) {
                    
                    for (Permission *tempPermission in tempGym.permissions.permissions) {
                        
                        if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                            
                            switch (type) {
                                case PermissionTypeRead:
                                    
                                    if (tempPermission.readState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeAdd:
                                    
                                    if (tempPermission.addState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeEdit:
                                    
                                    if (tempPermission.editState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                case PermissionTypeDelete:
                                    
                                    if (tempPermission.deleteState) {
                                        
                                        i++;
                                        
                                    }
                                    
                                    break;
                                    
                                default:
                                    break;
                            }
                            
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return gyms.count;
        
    }else{
        
        PermissionState state = 0;
        
        for (Gym *gym in gyms) {
            
            if (gym.shopId == _gym.shopId) {
                
                for (Permission *tempPermission in _gym.permissions.permissions) {
                    
                    if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                        
                        switch (type) {
                            case PermissionTypeRead:
                                
                                state = tempPermission.readState;
                                
                                break;
                                
                            case PermissionTypeAdd:
                                
                                state = tempPermission.addState;
                                
                                break;
                                
                            case PermissionTypeEdit:
                                
                                state = tempPermission.editState;
                                
                                break;
                                
                            case PermissionTypeDelete:
                                
                                state = tempPermission.deleteState;
                                
                                break;
                                
                            default:
                                
                                break;
                        }
                        
                        break;
                        
                    }
                    
                }
                
            }else{
                
                return 0;
                
            }
            
        }
        
        if (state == PermissionStateAll) {
            
            return 1;
            
        }else{
            
            return 0;
            
        }
        
    }
    
}

-(NSArray *)getHaveAddPermissionGymsWithPermission:(Permission *)permission
{
    
    if (AppGym) {
        
        return @[AppGym];
        
    }else{
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (_gyms.count) {
            
            for (Gym *gym in _gyms) {
                
                for (Permission *tempPermission in gym.permissions.permissions) {
                    
                    if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                        
                        if (tempPermission.addState) {
                            
                            [array addObject:gym];
                            
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }else{
            
            for (Permission *tempPermission in _gym.permissions.permissions) {
                
                if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                    
                    if (tempPermission.addState) {
                        
                        [array addObject:_gym];
                        
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
        return array;
        
    }
    
}

-(NSArray *)getHaveAddPermissionGymsWithGyms:(NSArray *)gyms andPermission:(Permission *)permission
{
    
    if (AppGym) {
        
        return @[AppGym];
        
    }else{
        
        NSMutableArray *array = [NSMutableArray array];
        
        NSArray *currentGyms = [self getPermissionNotIgnoredWithGyms:gyms];
        
        if (currentGyms.count) {
            
            for (Gym *gym in currentGyms) {
                
                for (Permission *tempPermission in gym.permissions.permissions) {
                    
                    if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                        
                        if (tempPermission.addState) {
                            
                            [array addObject:gym];
                            
                            break;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }else{
            
            for (Permission *tempPermission in _gym.permissions.permissions) {
                
                if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                    
                    if (tempPermission.addState) {
                        
                        [array addObject:_gym];
                        
                        break;
                        
                    }
                    
                }
                
            }
            
        }
        
        return array;
        
    }
    
}

-(NSArray *)getDeletePermissionWithGyms:(NSArray *)gyms andPermission:(Permission *)permission
{
    
    if (AppGym) {
        
        return @[AppGym];
        
    }else{
        
        NSMutableArray *array = [NSMutableArray array];
        
        if (self.gyms.count) {
            
            for (Gym *gym in gyms) {
                
                for (Gym *tempGym in _gyms) {
                    
                    if (tempGym.shopId == gym.shopId) {
                        
                        for (Permission *tempPermission in tempGym.permissions.permissions) {
                            
                            if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                                
                                if (tempPermission.deleteState) {
                                    
                                    [array addObject:tempGym];
                                    
                                    break;
                                    
                                }
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }else{
            
            for (Gym *gym in gyms) {
                
                if (_gym.shopId == gym.shopId) {
                    
                    for (Permission *tempPermission in _gym.permissions.permissions) {
                        
                        if ([tempPermission.readKey isEqualToString:permission.readKey]) {
                            
                            if (tempPermission.deleteState) {
                                
                                [array addObject:_gym];
                                
                                break;
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        return array;
        
    }
    
}

@end
