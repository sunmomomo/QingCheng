//
//  QCLoginTF.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/15.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "QCTextField.h"

@interface QCTextField ()

{
    
    NSString *_placeholderString;
    
}

@property(nonatomic,strong)UIButton *nowLeftView;

@property(nonatomic,strong)UIImageView *leftImgView;

@property(nonatomic,strong)UILabel *leftLabel;

@property(nonatomic,strong)UILabel *rightLabel;

@property(nonatomic,strong)UIImageView *leftArrow;

@property(nonatomic,strong)UIView *leftLine;

@end

@implementation QCTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.textColor = UIColorFromRGB(0x222222);
        
        self.font = AllFont(14);
        
        self.returnKeyType = UIReturnKeyDone;
        
        self.nowLeftView = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width320(200), self.height)];
        
        self.leftImgView = [[UIImageView alloc]initWithFrame:CGRectMake(0, frame.size.height/2-Height320(7.5), Width320(15), Height320(15))];
        
        self.leftImgView.contentMode = UIViewContentModeScaleAspectFit;
                        
        [self.nowLeftView addSubview:self.leftImgView];
        
        self.leftLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.nowLeftView.width-self.leftImgView.right, self.height)];
        
        self.leftLabel.textColor = UIColorFromRGB(0x999999);
        
        self.leftLabel.font = AllFont(14);
        
        [self.nowLeftView addSubview:self.leftLabel];
        
        self.leftArrow = [[UIImageView alloc]initWithFrame:CGRectMake(self.leftLabel.right+Width320(6), frame.size.height/2-Height320(3.5), Width320(12), Height320(7))];
        
        self.leftArrow.image = [UIImage imageNamed:@"down_arrow"];
        
        self.leftArrow.hidden = YES;
        
        [self.nowLeftView addSubview:self.leftArrow];
        
        self.leftLine = [[UIView alloc]initWithFrame:CGRectMake(self.leftArrow.right+Width320(8)-OnePX, frame.size.height/2-Height320(10), OnePX, Height320(20))];
        
        self.leftLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        self.leftLine.hidden = YES;
        
        [self.nowLeftView addSubview:self.leftLine];
        
        [self.nowLeftView addTarget:self action:@selector(leftClick:) forControlEvents:UIControlEventTouchUpInside];
        
        self.rightLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(50), self.height)];
        
        self.rightLabel.font = AllFont(14);
        
        self.rightLabel.textColor = UIColorFromRGB(0x999999);
        
        self.rightLabel.userInteractionEnabled = YES;
        
        self.rightLabel.textAlignment = NSTextAlignmentRight;
        
        [self.rightLabel addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)]];
        
        self.rightView = self.rightLabel;
        
        self.leftView = self.nowLeftView;
        
        self.leftViewMode = UITextFieldViewModeAlways;
        
        self.textAlignment = NSTextAlignmentRight;
        
    }
    
    return self;
    
}

-(void)leftClick:(UIButton*)button
{
    
    if (_leftChoose) {
        
        if ([self.qcdelegate respondsToSelector:@selector(QCTextFieldLeftClick:)]) {
            
            [self.qcdelegate QCTextFieldLeftClick:self];
            
        }else{
            
            [self becomeFirstResponder];
            
        }
        
    }else{
        
        [self becomeFirstResponder];
        
    }
    
}

-(void)setFont:(UIFont *)font
{
    
    [super setFont:font];
    
    self.leftLabel.font = font;
    
    self.rightLabel.font = font;
    
    if (_placeholderString) {
        
        self.placeholder = _placeholderString;
        
    }
    
}

-(void)labelTap:(UITapGestureRecognizer*)tap
{
    
    [self becomeFirstResponder];
    
}

-(void)setLeftImg:(UIImage *)leftImg
{
    
    self.leftImgView.image = leftImg;
    
    [self.leftLabel changeLeft:self.leftImgView.right+Width320(8)];
    
    [self.leftArrow changeLeft:self.leftLabel.right+Width320(6)];
    
    [self.leftLine changeLeft:self.leftArrow.right+Width320(8)-OnePX];
    
    [self.nowLeftView changeWidth:_leftChoose?_leftLine.right:_leftLabel.right];
    
}

-(void)setLeftChoose:(BOOL)leftChoose
{
    
    _leftChoose = leftChoose;
    
    _leftArrow.hidden = !_leftChoose;
    
    _leftLine.hidden = !_leftChoose;
    
    [self.leftArrow changeLeft:self.leftLabel.right+Width320(6)];
    
    [self.leftLine changeLeft:self.leftArrow.right+Width320(8)-OnePX];
    
    [self.nowLeftView changeWidth:_leftChoose?_leftLine.right:_leftLabel.right];
    
}

-(void)setMustInput:(BOOL)mustInput
{
    
    _mustInput = mustInput;
    
    if (_mustInput &&self.placeholder.length) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[self.placeholder stringByAppendingString:@"*"]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xD0021B) range:NSMakeRange(astr.length-1, 1)];
        
        self.leftLabel.attributedText = astr;
        
        [self.leftLabel autoWidth];
        
        [self.leftArrow changeLeft:self.leftLabel.right+Width320(6)];
        
        [self.leftLine changeLeft:self.leftArrow.right+Width320(8)-OnePX];
        
        [self.nowLeftView changeWidth:_leftChoose?_leftLine.right:_leftLabel.right];
        
    }
    
    if (!_mustInput) {
        
        self.leftLabel.text = self.placeholder;
        
        [self.leftLabel autoWidth];
        
        [self.leftArrow changeLeft:self.leftLabel.right+Width320(6)];
        
        [self.leftLine changeLeft:self.leftArrow.right+Width320(8)-OnePX];
        
        [self.nowLeftView changeWidth:_leftChoose?_leftLine.right:_leftLabel.right];
        
    }
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholderString = placeholder;
    
    if (_mustInput) {
        
        NSMutableAttributedString *astr = [[NSMutableAttributedString alloc]initWithString:[self.placeholder stringByAppendingString:@"*"]];
        
        [astr addAttribute:NSForegroundColorAttributeName value:UIColorFromRGB(0xD0021B) range:NSMakeRange(astr.length-1, 1)];
        
        self.leftLabel.attributedText = astr;
        
    }else{
        
        self.leftLabel.text = placeholder;
        
    }
    
    [self.leftLabel autoWidth];
    
    [self.leftArrow changeLeft:self.leftLabel.right+Width320(6)];
    
    [self.leftLine changeLeft:self.leftArrow.right+Width320(8)-OnePX];
    
    [self.nowLeftView changeWidth:_leftChoose?_leftLine.right:_leftLabel.right];
    
}

-(NSString *)placeholder
{
    
    return _placeholderString;
    
}

-(void)setTextPlaceholder:(NSString *)textPlaceholder
{
    
    _textPlaceholder = textPlaceholder;
    
    [super setPlaceholder:_textPlaceholder];
    
    [super setValue:UIColorFromRGB(0xcccccc) forKeyPath:@"_placeholderLabel.textColor"];
    
}

-(void)setPlaceholderColor:(UIColor*)placeholderColor
{
    
    _placeholderColor = placeholderColor;
    
    self.leftLabel.textColor = placeholderColor;
    
}

-(void)setUnit:(NSString *)unit
{
    
    _unit = unit;
    
    self.rightLabel.text = _unit;
    
    [self.rightLabel autoWidth];
    
    self.rightViewMode = _unit.length?UITextFieldViewModeAlways:UITextFieldViewModeNever;
    
}

-(void)setType:(QCTextFieldType)type
{
    
    if (type == QCTextFieldTypeCell) {
        
        UIImageView *arrow = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(6), Height320(13), Width320(7.4), Height320(12))];
        
        arrow.image = [UIImage imageNamed:@"gray_arrow"];
        
        self.rightView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(14), self.height)];
        
        [self.rightView addSubview:arrow];
        
        self.rightViewMode = UITextFieldViewModeAlways;
        
        [self.rightView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(labelTap:)]];
        
    }else
    {
        
        self.rightView = [UIView new];
        
        self.rightViewMode = UITextFieldViewModeNever;
        
    }
    
}

@end
