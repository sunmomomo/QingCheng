//
//  MOTextView.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "MOTextView.h"

@interface MOTextView ()

@property(nonatomic,strong)UILabel *placeholderLabel;

@end

@implementation MOTextView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.returnKeyType = UIReturnKeyDone;
        
        self.placeholderLabel = [[UILabel alloc]initWithFrame:CGRectMake(5, Height320(5), frame.size.width, frame.size.height)];
        
        self.placeholderLabel.numberOfLines = 1;
        
        self.placeholderLabel.tag = 999;
        
        self.placeholderLabel.textColor = UIColorFromRGB(0x999999);
        
        self.placeholderLabel.font = STFont(14);
        
        [self addSubview:self.placeholderLabel];
        
         [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textChanged:) name:UITextViewTextDidChangeNotification object:nil];
        
    }
    
    return self;
    
}

-(void)setNeedNext:(BOOL)needNext
{
    
    _needNext = needNext;
    
    if (_needNext) {
        
        self.returnKeyType = UIReturnKeyDefault;
        
    }
    
}

- (void)textChanged:(NSNotification *)notification

{
    
    if([self.placeholderLabel.text length] == 0)
        
    {
        
        return;
        
    }
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    
    if ([[self text] hasSuffix:@"\n"]) {
        
        if (!_needNext) {
            
            self.text = [self.text stringByReplacingOccurrencesOfString:@"\n" withString:@""];
            
            if ([self.textDelegate respondsToSelector:@selector(textViewShouldReturn)]) {
                
                [self.textDelegate textViewShouldReturn];
                
            }
            
            [self resignFirstResponder];
            
        }
        
    }
    
}

-(void)setText:(NSString *)text
{
    
    [super setText:text];
    
    if([[self text] length] == 0)
        
    {
        
        [[self viewWithTag:999] setAlpha:1];
        
    }
    
    else
        
    {
        
        [[self viewWithTag:999] setAlpha:0];
        
    }
    
}

-(void)setFont:(UIFont *)font
{
    
    [super setFont:font];
    
    self.placeholderLabel.font = font;
    
}

-(void)setPlaceholder:(NSString *)placeholder
{
    
    _placeholder = placeholder;
    
    self.placeholderLabel.text = placeholder;
    
    [self.placeholderLabel sizeToFit];
    
}

-(void)setPlaceholderColor:(UIColor *)placeholderColor
{
    
    _placeholderColor = placeholderColor;
    
    self.placeholderLabel.textColor = placeholderColor;
    
}



@end
