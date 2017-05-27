//
//  YFBackOfLeaveCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFBackOfLeaveCModel : YFBaseCModel

@property(nonatomic, copy)NSString *todayString;

@property(nonatomic, copy)NSString *originValidDateString;

@property(nonatomic, copy)NSString *backOfLeaveDateString;

@property(nonatomic, copy)NSString *leaveDays;

@property(nonatomic,assign)BOOL checkValid;

@end
