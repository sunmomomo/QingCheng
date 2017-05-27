//
//  YFStuFollowingOpCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFStaticsModel.h"

@interface YFStuFollowingOpCModel : YFBaseCModel

//- 新增注册 - * - 新增跟进 - * - 新增会员 -
@property(nonatomic, copy)NSString *typeTitle;

@property(nonatomic, strong)UIColor *defaultColor;

@property(nonatomic, strong)YFStaticsModel *staticModel;

@property(nonatomic, copy)NSString *todayCountStr;
@property(nonatomic, copy)NSString *sevenCountStr;
@property(nonatomic, copy)NSString *thirtyCountStr;

@end
