//
//  YFUserAttendanceModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFUserAttendanceModel : YFBaseCModel

@property(nonatomic)NSNumber *u_id;
@property(nonatomic)NSString *username;
@property(nonatomic)NSString *phone;
@property(nonatomic)NSString *gender;
@property(nonatomic)NSURL *avatar;

@property(nonatomic)NSString *day_count;
@property(nonatomic)NSString *private_count;
@property(nonatomic)NSString *group_count;
@property(nonatomic)NSString *checkin_count;

@end
