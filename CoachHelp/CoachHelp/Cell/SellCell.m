//
//  SellCell.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/18.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "SellCell.h"

@interface SellCell ()

{
    
    UILabel *_dayLabel;
    
    UILabel *_monthLabel;
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_priceLabel;
    
    UIView *_lineView;
    
}

@end

@implementation SellCell

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        
        _dayLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(2.5), Height320(9.7), Width320(48), Height320(29))];
        
        _dayLabel.textColor = UIColorFromRGB(0x666666);
        
        _dayLabel.font = AllFont(25);
        
        _dayLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_dayLabel];
        
        _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(3.9), _dayLabel.bottom, Width320(45), Height320(17.7))];
        
        _monthLabel.font = AllFont(14);
        
        _monthLabel.textColor = UIColorFromRGB(0x999999);
        
        _monthLabel.textAlignment = NSTextAlignmentCenter;
        
        [self.contentView addSubview:_monthLabel];
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(Width320(68.5), 0, 1, Height320(63.5))];
        
        sep.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:sep];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(sep.right+Width320(13), Height320(13.3), MSW-Width320(73)-sep.right, Height320(18))];
        
        _titleLabel.font = AllFont(15);
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        [self.contentView addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(_titleLabel.left, _titleLabel.bottom+Height320(3), _titleLabel.width, Height320(14))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.font = AllFont(11);
        
        [self.contentView addSubview:_subtitleLabel];
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(60), Height320(11.6), Width320(40), Height320(15))];
        
        label.text = @"实收";
        
        label.textColor = UIColorFromRGB(0x999999);
        
        label.font = AllFont(12);
        
        label.textAlignment = NSTextAlignmentRight;
        
        [self.contentView addSubview:label];
        
        _priceLabel = [[UILabel alloc]initWithFrame:CGRectMake(MSW-Width320(120), label.bottom+Height320(1.8), Width320(100), Height320(15))];
        
        _priceLabel.textColor = kMainColor;
        
        _priceLabel.textAlignment = NSTextAlignmentRight;
        
        _priceLabel.font = AllFont(12);
        
        [self.contentView addSubview:_priceLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 1)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        [self.contentView addSubview:_lineView];
        
    }
    
    return self;
    
}


-(void)setMonth:(NSString *)month
{
    
    _month = month;
    
    if (_sectionFirst) {
        
        _monthLabel.text = month;
        
    }
    
}

-(void)setDay:(NSString *)day
{
    
    _day = day;
    
    if (_sectionFirst) {
        
        _dayLabel.text = _day;
        
    }
    
}

-(void)setSectionFirst:(BOOL)sectionFirst
{
    
    _sectionFirst = sectionFirst;
    
    if (_sectionFirst) {
        
        _monthLabel.hidden = NO;
        
        _dayLabel.hidden = NO;
        
        [_lineView changeLeft:0];
        
        [_lineView changeWidth:MSW];
        
    }else
    {
        
        _monthLabel.hidden = YES;
        
        _dayLabel.hidden = YES;
        
        [_lineView changeLeft:Width320(68.5)];
        
        [_lineView changeWidth:MSW-Width320(68.5)];
        
    }
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setCard:(NSString *)card
{
    
    _card = card;
    
    _subtitleLabel.text = card;
    
}

-(void)setCost:(float)cost
{
    
    _cost = cost;
    
    if ([[NSString stringWithFormat:@"%.2f",_cost] hasSuffix:@".00"]) {
        
        _priceLabel.text = [NSString stringWithFormat:@"￥%ld元",(long)_cost];
        
    }else{
        
        _priceLabel.text = [NSString stringWithFormat:@"￥%.2f元",_cost];
        
    }
    
}

@end
