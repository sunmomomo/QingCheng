//
//  YFSignUpAttendanceModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFSignUpAttendanceDetailModel.h"

@interface YFSignUpAttendanceModel : YFBaseCModel

@property(nonatomic, strong)YFSignUpAttendanceDetailModel *days;
@property(nonatomic, strong)YFSignUpAttendanceDetailModel *private_course;
@property(nonatomic, strong)YFSignUpAttendanceDetailModel *group_course;
@property(nonatomic, strong)YFSignUpAttendanceDetailModel *checkin;

@property(nonatomic, copy)NSString *titleDesName;
@end
