//
//  MOTextField.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/12.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "MOTextField.h"

@interface MOTextField ()

{
    
    UIView *_lineView;
    
}

@end

@implementation MOTextField

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        self.backgroundColor = UIColorFromRGB(0xffffff);
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(0, frame.size.height-1/[UIScreen mainScreen].scale, frame.size.width, 1/[UIScreen mainScreen].scale)];
        
        _lineView.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [self addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setNoLine:(BOOL)noLine
{
    
    _noLine = noLine;
    
    if (_noLine) {
        
        _lineView.hidden = YES;
        
    }else
    {
        
        _lineView.hidden = NO;
        
    }
    
}

-(void)setLineColor:(UIColor *)lineColor
{
    
    _lineColor = lineColor;
    
    _lineView.backgroundColor = _lineColor;
    
}

@end
