//
//  YFStaticsSubModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseModel.h"

@interface YFStaticsSubModel : YFBaseModel

@property(nonatomic ,copy)NSString *date;

@property(nonatomic ,copy)NSString *monthDay;

// 纯数字
@property(nonatomic ,copy)NSString *countValue;
// 可能会显示 单位
@property(nonatomic ,copy)NSString *count;

@end
