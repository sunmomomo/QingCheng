//
//  ChestSearchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestSearchCell.h"

@interface ChestSearchCell ()

{
    
    UIView *_rightLine;
    
    UIView *_bottomLine;
    
    UILabel *_titleLabel;
    
    UILabel *_usedLabel;
    
    UIImageView *_chooseImg;
    
}

@end

@implementation ChestSearchCell

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
        
        _usedLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(42), frame.size.width, Height320(16))];
        
        _usedLabel.textColor = UIColorFromRGB(0x999999);
        
        _usedLabel.textAlignment = NSTextAlignmentCenter;
        
        _usedLabel.font = AllFont(12);
        
        [self addSubview:_usedLabel];
        
        _bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-OnePX, frame.size.width, OnePX)];
        
        _bottomLine.backgroundColor = kMainColor;
        
        [self addSubview:_bottomLine];
        
        _rightLine = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width-OnePX, 0, OnePX, frame.size.height)];
        
        _rightLine.backgroundColor = kMainColor;
        
        [self addSubview:_rightLine];
        
        _chooseImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(21), Height320(12), Width320(16), Height320(12))];
        
        _chooseImg.image = [UIImage imageNamed:@"main_choose"];
        
        [self addSubview:_chooseImg];
        
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
        
        if (_title.length) {
            
            _usedLabel.text = @"已占用";
            
        }else{
            
            _usedLabel.text = @"";
            
        }
        
    }else{
        
        self.backgroundColor = [kMainColor colorWithAlphaComponent:0.1];
        
        _titleLabel.textColor = kMainColor;
        
        _usedLabel.text = @"";
        
    }
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _chooseImg.hidden = !_choosed;
    
}

@end
