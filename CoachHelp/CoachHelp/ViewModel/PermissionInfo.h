//
//  PermissionInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Permissions.h"

@interface PermissionInfo : NSObject

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)Permissions *permissions;

@property(nonatomic,strong)Permissions *brandPermissions;

@property(nonatomic,strong)void(^brandCallBack)(BOOL success,NSString *error);

@property(nonatomic,strong)void(^gymCallBack)(BOOL success,NSString *error);

+(instancetype)sharedInfo;

-(void)requestWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestStaffPermissionWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)getPermissionWithGyms:(NSArray *)gyms;

-(NSArray *)getHaveAddPermissionGymsWithGyms:(NSArray *)gyms andPermission:(Permission *)permission;

-(NSArray *)getPermissionNotIgnoredWithGyms:(NSArray *)gyms;

-(PermissionState)getPermissionStateWithGyms:(NSArray *)gyms andPermission:(Permission*)permission andType:(PermissionType)type;

-(NSInteger)getPermissionCountWithGyms:(NSArray *)gyms andPermission:(Permission*)permission andType:(PermissionType)type;

-(NSArray *)getHaveAddPermissionGymsWithPermission:(Permission*)permission;

-(NSArray *)getDeletePermissionWithGyms:(NSArray *)gyms andPermission:(Permission*)permission;

@end
