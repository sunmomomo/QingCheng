//
//  StaffUserInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/9.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Staff.h"

@interface StaffUserInfo : NSObject

@property(nonatomic,strong)Staff *staff;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)updateStaffResult:(void(^)(BOOL success,NSString *error))result;

@end
