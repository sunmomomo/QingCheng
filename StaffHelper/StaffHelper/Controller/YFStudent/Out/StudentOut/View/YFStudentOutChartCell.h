//
//  YFStudentOutChartCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "CYChartView.h"
#import "YFCharView.h"

#define YFStudentOutChartCellHeight 198


@interface YFStudentOutChartCell : YFBaseCell

@property(nonatomic, retain) YFCharView *chartView;

- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor;

-(void)setDefaultView;
- (void)setContentOffsetWithXX:(CGFloat)xx;

@end
