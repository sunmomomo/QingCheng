//
//  YFStaticsModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseModel.h"

@interface YFStaticsModel : YFBaseModel

@property(nonatomic, copy)NSMutableDictionary *dateDicForModel;

@property(nonatomic ,assign)CGFloat maxValue;
@property(nonatomic ,assign)CGFloat minValue;


@property(nonatomic ,copy)NSString *count;

// 会员跟进 用到的 今日 最近7天 最近30天
@property(nonatomic ,copy)NSString *month_count;
@property(nonatomic ,copy)NSString *today_count;
@property(nonatomic ,copy)NSString *week_count;



@property(nonatomic ,strong)NSMutableArray *arrayModels;

- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray;

- (void)resultArray:(NSArray *)array;

@end
