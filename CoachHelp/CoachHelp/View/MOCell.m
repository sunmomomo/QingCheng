//
//  MOCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOCell.h"

@interface MOCell ()

{
    
    UIView *_lineView;
    
    UIImageView *_arrowImg;
    
    UILabel *_placeholderLabel;
    
    UIImageView *_imageView;
    
}

@property(nonatomic,strong)UILabel *headLabel;

@end

@implementation MOCell

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _noLine = NO;
        
        _haveArrow = YES;
        
        _subtitleColor = UIColorFromRGB(0x666666);
        
        self.headLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        
        self.headLabel.textColor = UIColorFromRGB(0x999999);
        
        self.headLabel.font = AllFont(14);
        
        self.headLabel.userInteractionEnabled = NO;
        
        [self addSubview:self.headLabel];
        
        self.subtitleLabel = [[UILabel alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2-Width320(15.4), frame.size.height)];
        
        self.subtitleLabel.textColor = UIColorFromRGB(0x666666);
        
        self.subtitleLabel.font = AllFont(14);
        
        self.subtitleLabel.textAlignment = NSTextAlignmentRight;
        
        self.subtitleLabel.userInteractionEnabled = NO;
        
        [self addSubview:self.subtitleLabel];
        
        _placeholderLabel = [[UILabel alloc]initWithFrame:self.subtitleLabel.frame];
        
        _placeholderLabel.textColor = UIColorFromRGB(0x999999);
        
        _placeholderLabel.font = AllFont(14);
        
        _placeholderLabel.textAlignment = NSTextAlignmentRight;
        
        _placeholderLabel.userInteractionEnabled = NO;
        
        [self addSubview:_placeholderLabel];
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(7.4), frame.size.height/2-Height320(6), Width320(7.4), Height320(12))];
        
        _arrowImg.image = [UIImage imageNamed:@"gray_arrow"];
        
        [self addSubview:_arrowImg];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1/[UIScreen mainScreen].scale, frame.size.width, 1/[UIScreen mainScreen].scale)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_lineView];
        
        _imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(8), Width320(24), Height320(24))];
        
        _imageView.hidden = YES;
        
        [self addSubview:_imageView];
        
    }
    return self;
}

-(void)setHaveArrow:(BOOL)haveArrow
{
    
    _haveArrow = haveArrow;
    
    if (_haveArrow) {
        
        _arrowImg.hidden = NO;
        
        [_subtitleLabel changeLeft:self.width/2];
        
    }else
    {
        
        _arrowImg.hidden = YES;
        
        [_subtitleLabel changeLeft:self.width/2+Width320(15.4)];
        
    }
    
}

-(UILabel *)titleLabel
{
    
    return self.headLabel;
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _lineView.hidden = _noLine;
    
}

-(void)setMustInput:(BOOL)mustInput
{
    
    _mustInput = mustInput;
    
    if (self.headLabel.text.length) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[self.headLabel.text stringByAppendingString:@"*"]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xD0021B) range:NSMakeRange(astr.length-1, 1)];
        
        self.headLabel.attributedText = astr;
        
    }
    
}

-(void)setSubtitle:(NSString *)subtitle
{
    
    _subtitle = subtitle;
    
    if (_subtitle.length) {
        
        _subtitleLabel.text = subtitle;
        
        _subtitleLabel.hidden = NO;
        
        _placeholderLabel.hidden = YES;
        
    }else
    {
        
        _subtitleLabel.hidden = YES;
        
        _placeholderLabel.hidden = NO;
        
    }
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = placeholder;
    
    _placeholderLabel.text = _placeholder;
    
}

-(void)setSubtitleColor:(UIColor *)subtitleColor
{
    
    _subtitleColor = subtitleColor;
    
    _subtitleLabel.textColor = _subtitleColor;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    if (_image) {
        
        [_headLabel changeLeft:_imageView.right+Width320(8)];
        
        _imageView.hidden = NO;
        
    }else{
        
        [_headLabel changeLeft:0];
        
        _imageView.hidden = YES;
        
    }
    
}

-(void)setUserInteractionEnabled:(BOOL)userInteractionEnabled
{
    
    [super setUserInteractionEnabled:userInteractionEnabled];
    
    if (!userInteractionEnabled) {
        
        _arrowImg.hidden = YES;
        
        _subtitleLabel.textColor = UIColorFromRGB(0x333333);
        
    }else{
        
        _arrowImg.hidden = NO;
        
        _subtitleLabel.textColor = _subtitleColor;
        
    }
    
}

@end
