//
//  YFStudentOutChartCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutChartCell.h"

@interface YFStudentOutChartCell()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UILabel *xFirstLabel;
@property(nonatomic, strong)UILabel *xSecondLabel;

@end

@implementation YFStudentOutChartCell
{
    NSUInteger _count;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 0, MSW - 50, YFStudentOutChartCellHeight - 20)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
        _scrollView.delegate = self;
        // 设置内容大小
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];

    }
    return self;
}

- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor
{
    
    defaultColor = RGB_YF(140, 181, 186);
    for (UILabel *label in self.chartView.charView.yLabelsArray) {
        [label removeFromSuperview];
    }
    self.xFirstLabel = nil;
    self.xSecondLabel = nil;

    for (UILabel *label in self.chartView.charView.xLabelsArray) {
        [label removeFromSuperview];
    }
    
    
    [_chartView removeFromSuperview];
    [_chartView.desLabel removeFromSuperview];
    [_chartView.valueLabel removeFromSuperview];
    _chartView = nil;
    
    
    YFCharView  *chartView;
    
    if (count == 7) {
        // 创建绘图组件
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, (long)(self.scrollView.width * 1.9), YFStudentOutChartCellHeight - 20)];

        //        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(20, 20, 30, 38);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(80, 80, 100, 130);
        
    }else
    {
        // 创建绘图组件
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, (long)(self.scrollView.width * 0.9) + self.scrollView.width * (30.0 / 7.0), YFStudentOutChartCellHeight - 20)];
        //        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(50, 50, 61, 71);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(75, 75, 91, 110);
    }
    chartView.ylabelUnit = @"人次";
    [_chartView.desLabel removeFromSuperview];
    [_chartView.valueLabel removeFromSuperview];
    chartView.xxHeight = 140.0;
    
    chartView.isCanTapToSelect = NO;
    chartView.selelctIndex = count;
    chartView.xxExtionGap = (MSW - 90.0) / 2.0;
    chartView.xxGap = 0.0;
    
    chartView.defaultColor = defaultColor;
    _chartView = chartView;
    [self.scrollView setContentSize:CGSizeMake(chartView.frame.size.width , chartView.frame.size.height)];
    [self.scrollView addSubview:chartView];
    
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    DebugLogYF(@"%f",scrollView.contentOffset.x);
    [self.chartView setXXOffsetToPromtView:scrollView.contentOffset.x scrollView:scrollView];
}


-(void)setDefaultView
{
    for (UILabel *label in self.chartView.charView.yLabelsArray) {
        [label changeOrigin:CGPointMake(20, self.chartView.top + label.mj_y)];
        [self.contentView addSubview:label];
    }
    
    for (UILabel *label in self.chartView.charView.xLabelsArray) {
        [self.contentView addSubview:label];
        if (!self.xFirstLabel) {
            self.xFirstLabel = label;
            label.frame = CGRectMake(self.scrollView.left, self.scrollView.bottom - label.height * 0.5 , label.width, label.height);
        }else
        {
            self.xSecondLabel = label;
            label.frame = CGRectMake(self.scrollView.right - label.width - 10, self.scrollView.bottom - label.height * 0.5, label.width, label.height);
        }
    }
}

- (void)setContentOffsetWithXX:(CGFloat)xx
{
    self.scrollView.delegate = nil;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.scrollView.width, 0)];
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.delegate = self;
    });
}

@end
