//
//  YFCompetitionModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFCompetitionModel : YFBaseCModel

@property(nonatomic, copy)NSNumber *c_id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *start;
@property(nonatomic, copy)NSString *end;

/**
 * 负数 表示 未开始, >= 0 表示已开始
 */
@property(nonatomic, assign)NSInteger beginDays;

@end
