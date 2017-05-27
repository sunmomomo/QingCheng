//
//  YFFolloSubUpCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFFolloSubUpCell.h"


#define YFChartViewHeight Width320(135)

#import "GTFYButton.h"

@interface YFFolloSubUpCell ()<UIScrollViewDelegate>

@property(nonatomic, strong)UILabel *xFirstLabel;
@property(nonatomic, strong)UILabel *xSecondLabel;




@end

@implementation YFFolloSubUpCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.stateImageView];
        [self.contentView addSubview:self.nameLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, self.nameLabel.bottom - OnePX, MSW, OnePX)];
        lineView.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:lineView];
        
        _scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(50, self.nameLabel.bottom, MSW - 50, YFChartViewHeight)];
        _scrollView.backgroundColor = [UIColor whiteColor];
        _scrollView.bounces = NO;
        // 设置内容大小
        _scrollView.delegate = self;
        _scrollView.showsHorizontalScrollIndicator = NO;
        [self.contentView addSubview:_scrollView];

        [_scrollView addSubview:self.chartView];
        
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(Width320(158), Width320(12), 1, Width320(16))];
        lineView1.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:lineView1];

    }
    return self;
}


-(UIImageView *)stateImageView
{
    if (_stateImageView == nil)
    {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(XFrom5To6YF(10), XFrom5To6YF(20) - XFrom5To6YF(14.0) / 2.0, XFrom5To6YF(16.0), XFrom5To6YF(14.0))];
        _stateImageView.image = [UIImage imageNamed:@"dataCyltic"];
        
    }
    return _stateImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateImageView.right + 10, 0, XFrom5To6YF(80), 47)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(XFrom5To6YF(13));
    }
    return _nameLabel;
}


- (void)creatCharViewWithDateCount:(NSUInteger )count defaultColor:(UIColor *)defaultColor
{
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
    
    CGFloat scale;
    
    if (count <= 7) {
        
        scale = count / 7.0;
        
        CGFloat width = (long)((self.scrollView.width * 1.9) * scale);
        
        if (width < self.scrollView.width)
        {
            width = self.scrollView.width;
        }
        
        // 创建绘图组件
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, width, YFChartViewHeight - 20)];
        
        //        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(20, 20, 30, 38);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(80, 80, 100, 130) ;
        
    }else
    {
        scale = count / 30.0;

        CGFloat width = (long)(self.scrollView.width * 0.9) + self.scrollView.width * (count / 7.0);

        // 创建绘图组件
        chartView = [[YFCharView alloc] initWithFrame:CGRectMake(0, 20, width, YFChartViewHeight - 20)];
        //        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(50, 50, 61, 71);
        chartView.xxBackExtionGap = IPhone4_5_6_6PYF(75, 75, 91, 110) * count / 30.0;
    }
    chartView.xxHeight = chartView.height - 7;
    chartView.ylabelUnit = @"人";
    if (count < 6) {
        chartView.isCanTapToSelect = YES;
        _scrollView.scrollEnabled = NO;
    }else
    {
        chartView.isCanTapToSelect = NO;
        _scrollView.scrollEnabled = YES;
    }
    chartView.selelctIndex = count;
    chartView.xxExtionGap = (MSW - 90.0) / 2.0;
    chartView.xxGap = 0.0;
    
    chartView.defaultColor = defaultColor;
    _chartView = chartView;
    [self.scrollView setContentSize:CGSizeMake(chartView.frame.size.width , chartView.frame.size.height)];
    [self.scrollView addSubview:chartView];
    
    chartView.desLabel.hidden = YES;
    chartView.valueLabel.hidden = YES;
}



- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //    DebugLogYF(@"%f",scrollView.contentOffset.x);
    [self.chartView setXXOffsetToPromtView:scrollView.contentOffset.x scrollView:scrollView];
}


-(void)setDefaultView
{
    for (UILabel *label in self.chartView.charView.yLabelsArray) {
        [label changeOrigin:CGPointMake(20, self.scrollView.top + label.mj_y + 20)];
        [self.contentView addSubview:label];
    }
    
    for (UILabel *label in self.chartView.charView.xLabelsArray) {
        [self.contentView addSubview:label];
        if (!self.xFirstLabel) {
            self.xFirstLabel = label;
            label.frame = CGRectMake(self.scrollView.left, self.scrollView.bottom - 10, label.width, label.height);
        }else
        {
            self.xSecondLabel = label;
            label.frame = CGRectMake(self.scrollView.right - label.width - 10, self.scrollView.bottom - 10, label.width, label.height);
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
