//
//  YFCharView.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CYChartView.h"
#import "YFStaticsModel.h"

@interface YFCharView : UIView


@property(nonatomic, assign)BOOL isCanTapToSelect;

@property(nonatomic,assign)CGFloat xxGap;

@property(nonatomic,assign)CGFloat xxExtionGap;
@property(nonatomic,assign)CGFloat xxBackExtionGap;

@property(nonatomic,assign)CGFloat xxHeight;



@property(nonatomic, strong) CYChartView *charView;

@property(nonatomic, strong) NSMutableDictionary *dic;


@property(nonatomic, assign) NSInteger totalCount;
@property(nonatomic, assign) NSInteger maxValue;
@property(nonatomic, assign) NSInteger minValue;

@property(nonatomic, strong) UILabel *desLabel;
@property(nonatomic, strong) UILabel *valueLabel;

// 不可为空
@property(nonatomic, strong)UIColor *defaultColor;

// y轴单位，显示在 原点上方
@property(nonatomic, copy)NSString *ylabelUnit;

- (void)drawChartLayer;

@property(nonatomic, strong)YFStaticsModel *staticModel;

// 从 1 开始，默认 4
@property(nonatomic,assign)NSUInteger selelctIndex;
// 刚开始 选择后的偏移量
@property(nonatomic,assign)CGFloat beginSelelctOffsetIndex;


// 设置 偏移量
- (void)setXXOffsetToPromtView:(CGFloat)xx scrollView:(UIScrollView *)scrollView;
@end
