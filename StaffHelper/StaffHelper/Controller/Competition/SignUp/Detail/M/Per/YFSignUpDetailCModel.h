//
//  YFSignUpDetailCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListCModel.h"

#import "YFSignUpAttendanceModel.h"

#import "YFSignUpAttendanceEmptyCModel.h"


@interface YFSignUpDetailCModel : YFSignUpListCModel

/**
 
 */
@property(nonatomic, strong)YFSignUpAttendanceModel *attendance;

@property(nonatomic, strong)YFSignUpAttendanceEmptyCModel *attendanceNotBegin;

@property(nonatomic, copy)NSString *start;

/**
 * 负数 表示 未开始, >= 0 表示已开始
 */
@property(nonatomic, assign)NSInteger beginDays;


+ (instancetype)creatDetailModel;

@end
