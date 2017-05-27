//
//  YFStudentFilterTimeModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFStudentFilterTimeCell.h"

@interface YFStudentFilterTimeModel : YFBaseCModel<QCKeyboardViewDelegate>

@property(nonatomic, copy)NSString *startTime;
@property(nonatomic, copy)NSString *endTime;

@property(nonatomic, assign)YFIsRegisterTimeType timeType;

- (void)unSelectAllButton;

- (void)selectTodayButton;

@end
