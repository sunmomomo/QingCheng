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
    
    UILabel *_proLabel;
    
    UILabel *_cardStopLabel;
    
    UILabel *_headLabel;
    
}

@end

@implementation MOSwitchCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width-Width320(39)-Width320(10), frame.size.height)];
        
        _headLabel.textColor = UIColorFromRGB(0x333333);
        
        _headLabel.font = AllFont(14);
        
        [self addSubview:_headLabel];
        
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
    
    _switch.userInteractionEnabled = userInteractionEnabled;
    
    _switch.onTintColor = userInteractionEnabled?kMainColor:UIColorFromRGB(0xdddddd);
    
    _headLabel.textColor = userInteractionEnabled?UIColorFromRGB(0x666666):UIColorFromRGB(0xcccccc);
    
}

-(UILabel *)titleLabel
{
    
    return _headLabel;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    if (_image) {
        
        [_headLabel changeLeft:_imageView.right+Width320(8)];
        
        _imageView.image = _image;
        
        _imageView.hidden = NO;
        
    }else{
        
        [_headLabel changeLeft:0];
        
        _imageView.hidden = YES;
        
    }
    
}

-(void)setPro:(BOOL)pro
{
    
    _pro = pro;
    
    if (_pro && !_proLabel) {
        
        [_headLabel autoWidth];
        
        _proLabel = [[UILabel alloc]initWithFrame:CGRectMake(_headLabel.right+Width320(3), Height320(14), Width320(20), Height320(12))];
        
        _proLabel.backgroundColor = kMainColor;
        
        _proLabel.layer.cornerRadius = _proLabel.height/2;
        
        _proLabel.layer.masksToBounds = YES;
        
        _proLabel.text = @"PRO";
        
        _proLabel.textColor = UIColorFromRGB(0xffffff);
        
        _proLabel.textAlignment = NSTextAlignmentCenter;
        
        _proLabel.font = AllFont(7);
        
        [self addSubview:_proLabel];
        
    }
    
    _proLabel.hidden = !_pro;
    
}

-(void)setCardStopped:(BOOL)cardStopped
{
    
    _cardStopped = cardStopped;
    
    if (_cardStopped && !_cardStopLabel) {
        
        _cardStopLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height(11), Width(40), Height(18))];
        
        _cardStopLabel.layer.cornerRadius = _cardStopLabel.height/2;
        
        _cardStopLabel.layer.masksToBounds = YES;
        
        _cardStopLabel.backgroundColor = UIColorFromRGB(0xeeeeee);
        
        _cardStopLabel.text = @"已停用";
        
        _cardStopLabel.textColor = UIColorFromRGB(0x999999);
        
        _cardStopLabel.textAlignment = NSTextAlignmentCenter;
        
        _cardStopLabel.font = AllFont(11);
        
        [self addSubview:_cardStopLabel];
        
    }
    
    [_headLabel changeLeft:_cardStopped?_cardStopLabel.right+Width(2):0];
    
}

@end
