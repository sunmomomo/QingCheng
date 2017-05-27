//
//  YFStuFollowingOpCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/26.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStuFollowingOpCell.h"


@implementation YFStuFollowingOpCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        
        [self.contentView addSubview:self.chartView];
       
    }
    return self;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        CGFloat labelWidth = XFrom6YF(75);
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((MSW - labelWidth) / 2.0, XFrom6YF(16), labelWidth, Width320(18))];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = RGB_YF(200, 200, 200);
        _nameLabel.font = FontSizeFY(XFrom5YF(13.0));
        
        
        CGFloat lineViewWidth = XFrom6YF(9);
        CGFloat lineViewxx1 = _nameLabel.left - lineViewWidth ;
        CGFloat lineViewxx2 = _nameLabel.right;
        
        UIView *lineView1 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx1,_nameLabel.center.y, lineViewWidth, 1.0)];
        lineView1.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:lineView1];
        
        UIView *lineView2 = [[UIView alloc] initWithFrame:CGRectMake(lineViewxx2, _nameLabel.center.y, lineViewWidth, 1.0)];
        lineView2.backgroundColor = YFLineViewColor;
        [self.contentView addSubview:lineView2];
        
        
        [self setLabelViewWithIndex:0];
        [self setLabelViewWithIndex:1];
        [self setLabelViewWithIndex:2];
        
    }
    return _nameLabel;
}


- (void)setLabelViewWithIndex:(NSUInteger )index
{
    
    CGFloat labelBeginx = XFrom6YF(25.0);
    CGFloat labelGap = XFrom6YF(59.0f);
    
    
    CGFloat labelWidth = XFrom6YF(65.0f);
    CGFloat labely = Width320(16) + self.nameLabel.bottom;
    CGFloat labelheith1 = Width320(28);
    CGFloat labelheith2 = Width320(17);
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelBeginx + (labelWidth + labelGap) * index, labely, labelWidth, labelheith1)];
    label.font = FontSizeFY(Width320(20.0));
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(labelBeginx + (labelWidth + labelGap) * index, label.bottom, labelWidth, labelheith2)];
    label2.font = FontSizeFY(Width320(12));
    label2.textColor = RGB_YF(141, 141, 141);
    label2.textAlignment = NSTextAlignmentCenter;
    
    [self.contentView addSubview:label];
    [self.contentView addSubview:label2];
    
    if (index == 0)
    {
        self.todayCountLabel = label;
        label2.text = @"今日";
    }else if (index == 1)
    {
        self.sevenCountLabel = label;
        label2.text = @"最近7天";
    }else
    {
        self.thirtyCountLabel = label;
        label2.text = @"最近30天";
    }
    
}

- (void)buttonAction:(UIButton *)button
{
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button.tag);
    }
}

- (YFCharView *)chartView
{
    if (!_chartView)
    {
        YFCharView  *chartView = [[YFCharView alloc] initWithFrame:CGRectMake(Width320(12), self.todayCountLabel.bottom+Width320(36), MSW-Width320(12), Width320(114))];
        
        chartView.xxHeight = Height320(113);
        
        chartView.desLabel.hidden = YES;
        chartView.valueLabel.hidden = YES;
//        chartView.defaultColor = model.defaultColor;
        
        chartView.xxGap = 40;
        
        chartView.ylabelUnit = @"人";
        
//        _chartView.staticModel = model.chartStaticModel;
//        [_chartView drawChartLayer];

        _chartView = chartView;
    }
    return _chartView;
}

@end
