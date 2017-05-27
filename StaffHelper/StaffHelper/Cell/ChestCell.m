//
//  ChestCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestCell.h"

@interface ChestCell ()

{
    
    UIView *_rightLine;
    
    UIView *_bottomLine;
    
    UILabel *_titleLabel;
    
    UILabel *_nameLabel;
    
    UILabel *_phoneLabel;
    
    UILabel *_timeLabel;
    
    UILabel *_longLabel;
    
}

@end

@implementation ChestCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = [kMainColor colorWithAlphaComponent:0.1];
        
        UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, OnePX)];
        
        topLine.backgroundColor = kMainColor;
        
        [self addSubview:topLine];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(8), frame.size.width, Height320(21))];
        
        _titleLabel.textColor = kMainColor;
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.font = AllFont(17);
        
        [self addSubview:_titleLabel];
        
        _nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(32), frame.size.width, Height320(16))];
        
        _nameLabel.textColor = UIColorFromRGB(0x999999);
        
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        
        _nameLabel.font = AllFont(12);
        
        [self addSubview:_nameLabel];
        
        _phoneLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _nameLabel.bottom, frame.size.width, Height320(16))];
        
        _phoneLabel.textColor = UIColorFromRGB(0x999999);
        
        _phoneLabel.textAlignment = NSTextAlignmentCenter;
        
        _phoneLabel.font = AllFont(12);
        
        [self addSubview:_phoneLabel];
        
        _timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _phoneLabel.bottom, frame.size.width, Height320(16))];
        
        _timeLabel.textColor = UIColorFromRGB(0x999999);
        
        _timeLabel.textAlignment = NSTextAlignmentCenter;
        
        _timeLabel.font = AllFont(12);
        
        [self addSubview:_timeLabel];
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        _bottomLine.backgroundColor = kMainColor;
        
        [self addSubview:_bottomLine];
        
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-OnePX, 0, OnePX, frame.size.height)];
        
        _rightLine.backgroundColor = kMainColor;
        
        [self addSubview:_rightLine];
        
    }
    return self;
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setHaveRightLine:(BOOL)haveRightLine
{
    
    _haveRightLine = haveRightLine;
    
    _rightLine.hidden = !_haveRightLine;
    
}

-(void)setHaveBottomLine:(BOOL)haveBottomLine
{
    
    _haveBottomLine = haveBottomLine;
    
    _bottomLine.hidden = !_haveBottomLine;
    
}

-(void)setCanSelected:(BOOL)canSelected
{
    
    _canSelected = canSelected;
    
    if (!_canSelected) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.textColor = UIColorFromRGB(0x999999);
        
    }else{
        
        self.backgroundColor = [kMainColor colorWithAlphaComponent:0.1];
        
        _titleLabel.textColor = kMainColor;
        
    }
    
}

-(void)setLongTermUse:(BOOL)longTermUse
{
    
    _longTermUse = longTermUse;
    
    if (_longTermUse) {
        
        _nameLabel.text = _name;
        
        _phoneLabel.text = _phone;
        
        _timeLabel.text = _time;
        
        _longLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(124), Height320(10), Width320(30), Height320(16))];
        
        _longLabel.layer.cornerRadius = _longLabel.height/2;
        
        _longLabel.layer.masksToBounds = YES;
        
        _longLabel.backgroundColor = UIColorFromRGB(0xF9944E);
        
        _longLabel.text = @"长期";
        
        _longLabel.textColor = UIColorFromRGB(0xffffff);
        
        _longLabel.textAlignment = NSTextAlignmentCenter;
        
        _longLabel.font = AllFont(10);
        
        [self addSubview:_longLabel];
        
    }else{
        
        _nameLabel.text = @"";
        
        _phoneLabel.text = _name;
        
        _timeLabel.text = _phone;
        
        [_longLabel removeFromSuperview];
        
    }
    
}

-(void)setIsEmpty:(BOOL)isEmpty
{
    
    _isEmpty = isEmpty;
    
    if (_isEmpty) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.text = @"";
        
        _nameLabel.text = @"";
        
        _phoneLabel.text = @"";
        
        _timeLabel.text = @"";
        
        _longLabel.hidden = YES;
        
        [_longLabel removeFromSuperview];
        
    }
    
}

@end
