//
//  YFStaticDetaiChartModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"
#import "YFStaticsModel.h"

@interface YFStaticDetaiChartModel : YFBaseCModel

@property(nonatomic ,strong)YFStaticsModel *staModel;
@property(nonatomic, strong)UIColor *defaultColor;
@property(nonatomic, copy)NSString *desValueStr;


- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray;

@end
