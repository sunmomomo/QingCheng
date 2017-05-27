//
//  LoginLineView.m
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/10.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "LoginLineView.h"

@implementation LoginLineView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        
        self.leftLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width/2, frame.size.height)];
        
        [self addSubview:self.leftLine];
        
        self.rightLine = [[UIView alloc]initWithFrame:CGRectMake(frame.size.width/2, 0, frame.size.width/2, frame.size.height)];
        
        [self addSubview:self.rightLine];
        
    }
    
    return self;
    
}

-(void)setLeftColor:(UIColor *)color
{
    
    self.leftLine.backgroundColor = color;
    
}

-(void)setRightColor:(UIColor *)color
{
    
    self.rightLine.backgroundColor = color;
    
}

@end
