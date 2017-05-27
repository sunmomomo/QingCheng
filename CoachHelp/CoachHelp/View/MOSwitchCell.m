//
//  MOSwitchCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOSwitchCell.h"

@interface MOSwitchCell ()

{
    
    UISwitch *_switch;
    
    UIView *_lineView;
    
    UIImageView *_imageView;
    
    UILabel *_cardStopLabel;
    
}

@end

@implementation MOSwitchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, (frame.size.width)/2, frame.size.height)];
        
        self.titleLabel.textColor = UIColorFromRGB(0x999999);
        
        self.titleLabel.font = AllFont(14);
        
        [self addSubview:self.titleLabel];
        
        _switch = [[UISwitch alloc]initWithFrame:CGRectMake(frame.size.width-Width320(39), frame.size.height/2-Height320(12), Width320(39), Height320(24))];
        
        _switch.transform = CGAffineTransformMakeScale(MSW/414, MSW/414);
        
        _switch.center = CGPointMake(_switch.center.x, frame.size.height/2);
        
        _switch.onTintColor = kMainColor;
        
        [self addSubview:_switch];
        
        [_switch addTarget:self action:@selector(switchChanged:) forControlEvents:UIControlEventValueChanged];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, self.height-1/[UIScreen mainScreen].scale, self.width, 1/[UIScreen mainScreen].scale)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_lineView];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height/2-Height320(12), Width320(24), Height320(24))];
        
        _imageView.hidden = YES;
        
        [self addSubview:_imageView];
        
    }
    return self;
}

-(void)switchChanged:(UISwitch *)aSwitch
{
    
    _on = aSwitch.isOn;
    
    if ([self.delegate respondsToSelector:@selector(switchCellSwitchChanged:)]) {
        
        [self.delegate switchCellSwitchChanged:self];
        
    }
    
}

-(void)setOn:(BOOL)on
{
    
    _on = on;
    
    _switch.on = _on;
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _lineView.hidden = _noLine;
    
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    _switch.onTintColor = userInteractionEnabled?kMainColor:UIColorFromRGB(0xdddddd);
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    if (_image) {
        
        [_titleLabel changeLeft:_imageView.right+Width320(8)];
        
        _imageView.image = _image;
        
        _imageView.hidden = NO;
        
    }else{
        
        [_titleLabel changeLeft:0];
        
        _imageView.hidden = YES;
        
    }
    
}

-(void)setCardStopped:(BOOL)cardStopped
{
    
    _cardStopped = cardStopped;
    
    if (_cardStopped && !_cardStopLabel) {
        
        _cardStopLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(11), Width320(40), Height320(18))];
        
        _cardStopLabel.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        _cardStopLabel.text = @"已停用";
        
        _cardStopLabel.textColor = UIColorFromRGB(0x999999);
        
        _cardStopLabel.textAlignment = NSTextAlignmentCenter;
        
        _cardStopLabel.font = AllFont(11);
        
        [self addSubview:_cardStopLabel];
        
    }
    
    [_titleLabel changeLeft:_cardStopped?_cardStopLabel.right+Width320(2):0];
    
}

@end
