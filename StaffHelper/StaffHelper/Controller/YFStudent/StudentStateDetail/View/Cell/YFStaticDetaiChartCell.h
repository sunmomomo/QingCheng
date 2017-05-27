//
//  YFStaticDetaiChartCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"
#import "YFCharView.h"


@interface YFStaticDetaiChartCell : YFBaseCell


@property(nonatomic, retain) YFCharView *chartView;

- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor;

-(void)setDefaultView;
- (void)setContentOffsetWithXX:(CGFloat)xx;

@end
