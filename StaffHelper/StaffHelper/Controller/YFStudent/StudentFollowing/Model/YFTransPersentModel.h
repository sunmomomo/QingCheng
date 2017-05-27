//
//  YFTransPersentModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFTransPersentModel : YFBaseCModel

// 天数
@property(nonatomic, assign)NSUInteger dayCount;

@property(nonatomic ,assign)NSUInteger neRegisNum;
@property(nonatomic ,assign)NSUInteger neFollow;
@property(nonatomic ,assign)NSUInteger neMem;


@property(nonatomic ,copy)NSString *create_count;
@property(nonatomic ,copy)NSString *following_count;
@property(nonatomic ,copy)NSString *member_count;

// 会员转化
@property(nonatomic, copy)NSString *start;
@property(nonatomic, copy)NSString *end;

// 转化率 详情
@property(nonatomic, assign)BOOL isTwoLevel;

@end
