//
//  CodeButton.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CodeButton.h"

@interface CodeButton ()

{
    
    UILabel *_titleLabel;
    
}

@end

@implementation CodeButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(10, Height320(5), 1, frame.size.height-Height320(10))];
        
        sep.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:sep];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(sep.right+10, 0, frame.size.width-sep.right-10, frame.size.height)];
        
        _titleLabel.textColor = UIColorFromRGB(0x666666);
        
        _titleLabel.textAlignment = NSTextAlignmentRight;
        
        _titleLabel.text = @"发送验证码";
        
        _titleLabel.font = AllFont(12);
        
        _titleLabel.adjustsFontSizeToFitWidth = YES;
        
        [self addSubview:_titleLabel];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

@end
