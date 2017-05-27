//
//  YFStaticDetaiChartCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStaticDetaiChartCell.h"
#import "YFAppConfig.h"

#define YFChartHeight 232

@interface YFStaticDetaiChartCell ()<UIScrollViewDelegate>

@property(nonatomic, strong)UIScrollView *scrollView;
@property(nonatomic, strong)UILabel *xFirstLabel;
@property(nonatomic, strong)UILabel *xSecondLabel;

@end

@implementation YFStaticDetaiChartCell
{
    NSUInteger _count;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, 0, MSW - 50, YFChartHeight)];
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





- (YFCharView *)chartView
{
    if (!_chartView)
    {
    }
    return _chartView;
}


- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor
{
    //    if (count == _count)
    //    {
    //
    //    }else
    //    {
    //        return;
    //    }
    
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
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, (long)(self.scrollView.width * 1.9), YFChartHeight - 20)];
        
        chartView.desLabel.text = @"最近7天新增注册共计";
        
//        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(20, 20, 30, 38);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(80, 80, 100, 130);

    }else
    {
        // 创建绘图组件
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, (long)(self.scrollView.width * 0.9) + self.scrollView.width * (30.0 / 7.0), YFChartHeight - 20)];
//        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(50, 50, 61, 71);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(75, 75, 91, 110);

        chartView.desLabel.text = @"最近30天新增注册共计";
    }
    chartView.isCanTapToSelect = NO;
    chartView.selelctIndex = count;
    chartView.xxExtionGap = (MSW - 90.0) / 2.0;
    chartView.xxGap = 0.0;
    
    chartView.defaultColor = defaultColor;
    _chartView = chartView;
    [self.scrollView setContentSize:CGSizeMake(chartView.frame.size.width , chartView.frame.size.height)];
    [self.scrollView addSubview:chartView];
    
    
    self.chartView.desLabel.frame = CGRectMake(self.chartView.desLabel.mj_x, self.chartView.desLabel.mj_y + 20, self.chartView.desLabel.width, self.chartView.desLabel.height);
    
    self.chartView.desLabel.frame = CGRectOffset(self.chartView.desLabel.frame, 0, -10);
    self.chartView.valueLabel.frame = CGRectOffset(self.chartView.valueLabel.frame, 0, 10);
    
    [self addSubview:self.chartView.desLabel];
    [self addSubview:self.chartView.valueLabel];
    
//    weakTypesYF
//    [self.chartView.charView setSetEndXLabelTextBlock:^(NSString *endXlabelStr) {
//        weakS.xSecondLabel.text = endXlabelStr;
//    }];
//    
//    [self.chartView.charView setSetBeginXLabelTextBlock:^(NSString *beginXlabelStr) {
//        weakS.xFirstLabel.text = beginXlabelStr;
//    }];
    
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
            label.frame = CGRectMake(self.scrollView.left, self.scrollView.bottom - label.height * 1.5, label.width, label.height);
        }else
        {
            self.xSecondLabel = label;
            label.frame = CGRectMake(self.scrollView.right - label.width - 10, self.scrollView.bottom - label.height * 1.5, label.width, label.height);
        }
    }
}

- (void)setContentOffsetWithXX:(CGFloat)xx
{
    self.scrollView.delegate = nil;
    
    [self.scrollView setContentOffset:CGPointMake(self.scrollView.contentSize.width - self.scrollView.width, 0)];

    
//    if (self.scrollView.contentSize.width > MSW * 3) {
//        [self.scrollView setContentOffset:CGPointMake(xx- IPhone4_5_6_6PYF(41, 41, 53, 54), 0)];
//    }else
//    {
//        [self.scrollView setContentOffset:CGPointMake(xx- IPhone4_5_6_6PYF(25, 25,29, 32), 0)];
//    }
    
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.scrollView.delegate = self;
    });
}


@end
