//
//  YFStudentFilterBirthdayModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFStudentFilterTimeCell.h"


@interface YFStudentFilterBirthdayModel : YFBaseCModel<QCKeyboardViewDelegate>

@property(nonatomic, copy)NSString *startTime;
@property(nonatomic, copy)NSString *endTime;

@end
