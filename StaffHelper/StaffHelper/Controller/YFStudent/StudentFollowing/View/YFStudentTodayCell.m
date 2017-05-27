//
//  YFStudentTodayCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTodayCell.h"
#import "YFAppConfig.h"

@implementation YFStudentTodayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
                
    }
    return self;
}


- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        CGFloat labelWidth = XFrom6YF(35);
    
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((MSW - labelWidth) / 2.0, 17, labelWidth, 44)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = RGB_YF(200, 200, 200);
        _nameLabel.font = FontSizeFY(XFrom6YF(13.0));
        
        
        CGFloat lineViewWidth = XFrom6YF(14.0);
        CGFloat lineViewxx1 = _nameLabel.left - lineViewWidth - XFrom6YF(10);
        CGFloat lineViewxx2 = _nameLabel.right + XFrom6YF(10);
        
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
    
    CGFloat labelBeginx = XFrom6YF(35.0);
    CGFloat labelGap = XFrom6YF(66.0f);
    
    
    CGFloat labelWidth = XFrom6YF(58.0f);
    CGFloat labely = XFrom6YF(68.0f);
    CGFloat labelheith1 = XFrom6YF(23.0f);
    CGFloat labelheith2 = XFrom6YF(35.0f);

    CGFloat stateViewHeight = XFrom6YF(2.5);
    CGFloat stateViewWidth = XFrom6YF(24.0);

    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(labelBeginx + (labelWidth + labelGap) * index, labely, labelWidth, labelheith1)];
    label.font = FontSizeFY(XFrom6YF(20.0));
    label.textColor = [UIColor blackColor];
    label.textAlignment = NSTextAlignmentCenter;
    
    
    UILabel *label2 = [[UILabel alloc] initWithFrame:CGRectMake(labelBeginx + (labelWidth + labelGap) * index, label.bottom, labelWidth, labelheith2)];
    label2.font = FontSizeFY(XFrom6YF(14.0));
    label2.textColor = RGB_YF(141, 141, 141);
    label2.textAlignment = NSTextAlignmentCenter;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(label.left + (labelWidth - stateViewWidth) / 2.0 , label2.bottom, stateViewWidth, stateViewHeight)];
    
    [self.contentView addSubview:label];
    [self.contentView addSubview:label2];
    [self.contentView addSubview:view];
    
    if (index == 0)
    {
        self.neRegisLabel = label;
        label2.text = @"新增注册";
        view.backgroundColor = RGB_YF(99, 181, 240);
    }else if (index == 1)
    {
        self.todayFollowLabel = label;
        label2.text = @"今日跟进";
        view.backgroundColor = RGB_YF(249, 142, 34);
    }else
    {
        self.neMemLabel = label;
        label2.text = @"新增会员";
        view.backgroundColor = RGB_YF(0, 173, 53);
    }
    
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = CGRectMake(label2.left, label.top, label2.width, view.bottom - label.top);
    
    button.backgroundColor = [UIColor clearColor];
    button.tag = index + 1;
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:button];
}

- (void)buttonAction:(UIButton *)button
{
    if (self.buttonActionBlock) {
        self.buttonActionBlock(button.tag);
    }
}


@end
