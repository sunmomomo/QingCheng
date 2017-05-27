//
//  GymProButton.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymProButton.h"

@interface GymProButton ()

{
    
    UILabel *_titleLabel;
    
    UILabel *_subtitleLabel;
    
    UILabel *_discardedLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation GymProButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(20), frame.size.width, Height320(18))];
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = AllFont(14);
        
        [self addSubview:_titleLabel];
        
        _subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(40), frame.size.width, Height320(15))];
        
        _subtitleLabel.textColor = UIColorFromRGB(0x999999);
        
        _subtitleLabel.textAlignment = NSTextAlignmentCenter;
        
        _subtitleLabel.font = AllFont(12);
        
        [self addSubview:_subtitleLabel];
        
        _discardedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(32), frame.size.width, Height320(14))];
        
        _discardedLabel.textColor = UIColorFromRGB(0xbbbbbb);
        
        _discardedLabel.textAlignment = NSTextAlignmentCenter;
        
        _discardedLabel.font = AllFont(10);
        
        _discardedLabel.hidden = YES;
        
        [self addSubview:_discardedLabel];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(19), Height320(7), Width320(12), Height320(9))];
        
        _chooseImg.image = [UIImage imageNamed:@"white_check"];
        
        [self addSubview:_chooseImg];
        
        _chooseImg.hidden = YES;
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-OnePX, 0, OnePX, frame.size.height)];
        
        line.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:line];
        
    }
    
    return self;
    
}

-(void)setPrice:(NSInteger)price
{
    
    _price = price;
    
    _subtitleLabel.text = [NSString stringWithFormat:@"%ld元",(long)_price];
    
}

-(void)setMonth:(NSInteger)month
{
    
    _month = month;
    
    _titleLabel.text = [NSString stringWithFormat:@"%ld个月",(long)_month];
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    self.backgroundColor = self.userInteractionEnabled?_choosed?kMainColor:UIColorFromRGB(0xffffff):UIColorFromRGB(0xffffff);
    
    _titleLabel.textColor = self.userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0x333333):UIColorFromRGB(0xcccccc);
    
    _subtitleLabel.textColor = self.userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0x999999):UIColorFromRGB(0xcccccc);
    
    _discardedLabel.textColor = self.userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0xbbbbbb):UIColorFromRGB(0xcccccc);
    
    _chooseImg.hidden = !_choosed;
    
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    _titleLabel.textColor = userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0x333333):UIColorFromRGB(0xcccccc);
    
    _subtitleLabel.textColor = userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0x999999):UIColorFromRGB(0xcccccc);
    
    _discardedLabel.textColor = userInteractionEnabled?_choosed?UIColorFromRGB(0xffffff):UIColorFromRGB(0xbbbbbb):UIColorFromRGB(0xcccccc);
    
}

-(void)setDiscardedPrice:(NSInteger)discardedPrice
{
    
    _discardedPrice = discardedPrice;
    
    if (_discardedPrice) {
        
        [_titleLabel changeTop:Height320(14)];
        
        [_subtitleLabel changeTop:Height320(48)];
        
        _discardedLabel.hidden = NO;
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld元",(long)_discardedPrice]];
        
        [astr addAttribute:NSStrikethroughStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:NSMakeRange(0, astr.length)];
        
        _discardedLabel.attributedText = astr;
        
    }
    
}

@end
