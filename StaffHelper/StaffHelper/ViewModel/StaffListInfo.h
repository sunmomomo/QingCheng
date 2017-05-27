//
//  StaffListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Staff.h"

@interface StaffListInfo : NSObject

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)NSArray *staffs;

-(void)requestWithGym:(Gym*)gym andSearchStr:(NSString *)searchStr;

-(void)update;

-(void)createStaff:(Staff*)staff withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)editStaff:(Staff*)staff withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteStaff:(Staff*)staff withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)changeAdmin:(Staff *)staff andCode:(NSString *)code result:(void(^)(BOOL success,NSString *error))result;

@end
