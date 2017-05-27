//
//  QCTextView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/24.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "QCTextView.h"

@interface QCTextView ()<UITextViewDelegate>

@property(nonatomic,strong)UILabel *placeholderLabel;

@property(nonatomic,strong)UITextView *textView;

@end

@implementation QCTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
        
    }
    
    return self;
    
}

-(void)load
{
    
    self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, Height320(9.5), Width320(200), Height320(19))];
    
    self.placeholderLabel.textColor = UIColorFromRGB(0x666666);
    
    self.placeholderLabel.font = STFont(14);
    
    [self addSubview:self.placeholderLabel];
    
    self.placeholderLabel.userInteractionEnabled = NO;
    
    self.textView = [[UITextView alloc]initWithFrame:CGRectMake(5, self.placeholderLabel.bottom+Height320(5), self.width, self.height-self.placeholderLabel.bottom-Height320(23))];
    
    self.textView.textColor = UIColorFromRGB(0x222222);
    
    self.textView.font = STFont(14);
    
    self.textView.delegate = self;
    
    self.textView.returnKeyType = UIReturnKeyDone;
    
    [self addSubview:self.textView];
    
    [self addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tap:)]];
    
}

-(void)tap:(UITapGestureRecognizer*)tap
{
    
    [self.textView becomeFirstResponder];
    
}

-(void)setText:(NSString *)text
{
    
    _text = text;
    
    self.textView.text = _text;
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = placeholder;
    
    self.placeholderLabel.text = _placeholder;
    
}

-(void)textViewDidChange:(UITextView *)textView
{
    
    _text = textView.text;
    
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    _placeholderColor = placeholderColor;
    
    _placeholderLabel.textColor = _placeholderColor;
    
}

-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"]) {
        
        [textView resignFirstResponder];
        
        return NO;
    }
    return YES;
}

-(BOOL)resignFirstResponder
{
    
    [super resignFirstResponder];
    
    [self.textView resignFirstResponder];
    
    return YES;
    
}


@end
