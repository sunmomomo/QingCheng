//
//  YFFolloSubUpCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

#import "YFStaticsModel.h"

@interface YFFolloSubUpCModel : YFBaseCModel

@property(nonatomic, strong)YFStaticsModel *staticsModel;

@property(nonatomic, strong)UIColor *defaultColor;

@property(nonatomic ,strong)NSArray *classsArray;

@property(nonatomic, strong)NSMutableDictionary *allConditionParam;

@property(nonatomic, copy)void(^refreshStaticBlock)();

@end
