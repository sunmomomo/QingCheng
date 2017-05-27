//
//  CommentToolView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CommentToolView.h"

@interface CommentToolView ()<MOToolTextViewDelegate>

{
    
    UIButton *_button;
    
}

@end

@implementation CommentToolView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        self.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.layer.borderWidth = OnePX;
        
        self.textView = [[MOToolTextView alloc]initWithFrame:CGRectMake(Width(15), Height(6), MSW-Width(100), Height(36))];
        
        self.textView.layer.borderWidth = OnePX;
        
        self.textView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.textView.backgroundColor = UIColorFromRGB(0xf9f9f9);
        
        self.textView.font = AllFont(14);
        
        self.textView.needNext = YES;
        
        self.textView.textDelegate = self;
        
        [self addSubview:self.textView];
        
        _button = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width(78), Height(6), Width(68), Height(36))];
        
        _button.layer.cornerRadius = Width(2);
        
        _button.backgroundColor = kMainColor;
        
        [_button setTitle:@"发送" forState:UIControlStateNormal];
        
        [_button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        _button.titleLabel.font = AllFont(15);
        
        [self addSubview:_button];
        
        _button.alpha = _textView.text.length?1:0.3;
        
        _button.userInteractionEnabled = _textView.text.length;
        
        [_button addTarget:self action:@selector(send) forControlEvents:UIControlEventTouchUpInside];
        
    }
    
    return self;
    
}

-(void)send
{
    
    if ([self.delegate respondsToSelector:@selector(sendText:)]) {
        
        [self.delegate sendText:self.textView.text];
        
    }
    
}

-(void)textViewDidChanged
{
    
    _button.alpha = _textView.text.length?1:0.3;
    
    _button.userInteractionEnabled = _textView.text.length;
    
    CGSize size = [_textView.text boundingRectWithSize:CGSizeMake(_textView.width-Width(21), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(14)} context:nil].size;
    
    [_textView changeHeight:MIN(Height(100), MAX(size.height+Height(12), Height(36)))];
    
    [self changeHeight:_textView.height+Height(12)];
    
    [self.delegate textViewChangeHeight:self.height];
    
}

-(BOOL)becomeFirstResponder
{
    
    [self.textView becomeFirstResponder];
    
    return YES;
    
}

@end
