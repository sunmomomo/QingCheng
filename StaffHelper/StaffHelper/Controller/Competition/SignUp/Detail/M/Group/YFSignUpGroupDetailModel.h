//
//  YFSignUpGroupDetailModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFSignUpAttendanceModel.h"

#import "YFSignUpAttendanceEmptyCModel.h"

#import "YFTBSectionsSignUpGroupModel.h"

#import "YFCompetitionModel.h"

@interface YFSignUpGroupDetailModel : YFBaseCModel


@property(nonatomic, copy)NSString *start;

/**
 * 负数 表示 未开始, >= 0 表示已开始
 */
@property(nonatomic, assign)NSInteger beginDays;

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, copy)NSNumber *su_id;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, strong)NSMutableArray *users;

@property(nonatomic, strong)NSMutableArray *users_attendance;

@property(nonatomic, strong)YFTBSectionsSignUpGroupModel *sectionTwoModel;


@property(nonatomic, strong)YFSignUpAttendanceModel *team_attendance;

@property(nonatomic, strong)YFSignUpAttendanceEmptyCModel *attendanceNotBegin;




+ (instancetype )creatTestArray;


@end
