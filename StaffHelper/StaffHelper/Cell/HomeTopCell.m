//
//  HomeTopCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "HomeTopCell.h"

@interface HomeTopCell ()

{
    
    UILabel *_numberLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
        
}

@end

@implementation HomeTopCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(14), frame.size.width, Height320(14))];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.font = AllFont(12);
        
        [self addSubview:_titleLabel];
        
        _numberLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _titleLabel.bottom+Height320(4), frame.size.width, Height320(18))];
        
        _numberLabel.font = AllFont(16);
        
        _numberLabel.textColor = UIColorFromRGB(0x333333);
        
        _numberLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_numberLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _numberLabel.bottom+Height320(4), frame.size.width, Height320(12))];
        
        _subtitleLabel.font = AllFont(10);
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_subtitleLabel];
        
    }
    return self;
}

-(void)setNumber:(NSString *)number
{
    
    _number = number;
    
    _numberLabel.text = number;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setWeekNumber:(NSString *)weekNumber
{
    
    _weekNumber = weekNumber;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"周%@  月%@",[NSString integerFormatString:_weekNumber],[NSString integerFormatString:_monthNumber]];
    
}

-(void)setMonthNumber:(NSString *)monthNumber
{
    
    _monthNumber = monthNumber;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"周%@  月%@",[NSString integerFormatString:_weekNumber],[NSString integerFormatString:_monthNumber]];
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    _subtitleLabel.text = _subtitle;
    
}


@end
