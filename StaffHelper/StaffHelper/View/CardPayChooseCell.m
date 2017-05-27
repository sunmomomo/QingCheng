//
//  CardPayChooseCell.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardPayChooseCell.h"

@interface CardPayChooseCell ()

{
    
    UILabel *_textLabel;
    
    UILabel *_placeholderLabel;
    
    UILabel *_cardNameLabel;
    
    UILabel *_remainLabel;
    
    UIView *_lineView;
    
}

@end

@implementation CardPayChooseCell

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _textLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), 0, Width320(60), frame.size.height)];
        
        _textLabel.text = @"支付方式";
        
        _textLabel.textColor = UIColorFromRGB(0x999999);
        
        _textLabel.font = AllFont(14);
        
        [self addSubview:_textLabel];
        
        _placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textLabel.right, 0, MSW-Width320(29)-_textLabel.right, frame.size.height)];
        
        _placeholderLabel.textColor = UIColorFromRGB(0x999999);
        
        _placeholderLabel.font = AllFont(14);
        
        _placeholderLabel.textAlignment = NSTextAlignmentRight;
        
        [self addSubview:_placeholderLabel];
        
        _cardNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(_textLabel.right, Height320(12), MSW-Width320(29)-_textLabel.right, Height320(16))];
        
        _cardNameLabel.textColor = UIColorFromRGB(0x333333);
        
        _cardNameLabel.textAlignment = NSTextAlignmentRight;
        
        _cardNameLabel.font = AllFont(14);
        
        [self addSubview:_cardNameLabel];
        
        UIImageView *arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(23), frame.size.height/2-Height320(6), Width320(7), Height320(12))];
        
        arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
        [self addSubview:arrowImg];
        
        _remainLabel = [[UILabel alloc]initWithFrame:CGRectMake(_cardNameLabel.left, _cardNameLabel.bottom+Height320(2), _cardNameLabel.width, Height320(14))];
        
        _remainLabel.textColor = UIColorFromRGB(0x999999);
        
        _remainLabel.textAlignment = NSTextAlignmentRight;
        
        _remainLabel.font = AllFont(12);
        
        _remainLabel.hidden = YES;
        
        [self addSubview:_remainLabel];
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(Width320(16), frame.size.height-OnePX, MSW-Width320(32), OnePX)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    _lineView.hidden = _noLine;
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = placeholder;
    
    _textLabel.text = _placeholder;
    
}

-(void)setCardPlaceholder:(NSString *)cardPlaceholder
{
    
    _cardPlaceholder = cardPlaceholder;
    
    _placeholderLabel.text = _cardPlaceholder;
    
}

-(void)setCardName:(NSString *)cardName
{
    
    _cardName = cardName;
    
    _cardNameLabel.text = _cardName;
    
    _placeholderLabel.hidden = YES;
    
}

-(void)setRemain:(NSString *)remain
{
    
    _remain = remain;
    
    _remainLabel.text = _remain;
    
    if (_remain.length) {
        
        _remainLabel.hidden = NO;
        
        [_cardNameLabel changeTop:Height320(12)];
        
    }else{
        
        _remainLabel.hidden = YES;
        
        [_cardNameLabel changeTop:self.height/2-Height320(8)];
        
    }
    
}

-(void)changeHeight:(CGFloat)height
{
    
    [super changeHeight:height];
    
    [_lineView changeTop:height-OnePX];
    
    [_textLabel changeHeight:height];
    
}

@end
