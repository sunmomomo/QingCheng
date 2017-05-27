//
//  UIView+lineViewYF.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "UIView+lineViewYF.h"

@implementation UIView (lineViewYF)

- (instancetype)addLinewViewToBottom
{
   return [self addLinewViewWithFrame:CGRectMake(0, self.height - OnePX, self.width, OnePX)];
}

- (instancetype)addLinewViewWithxOffset:(CGFloat )xxOffset
{
   return [self addLinewViewWithFrame:CGRectMake(xxOffset, self.height - OnePX, self.width - xxOffset, OnePX)];
}


- (instancetype)addLinewViewToTop
{
   return [self addLinewViewWithFrame:CGRectMake(0, 0, self.width, OnePX)];
}

- (instancetype)addLinewViewToTopWithxOffset:(CGFloat )xxOffset
{
    return [self addLinewViewWithFrame:CGRectMake(xxOffset, 0, self.width - xxOffset, OnePX)];
}


- (instancetype)addLinewViewWithFrame:(CGRect )frame
{
    UIView *linewView = [[UIView alloc] initWithFrame:frame];
    
    linewView.backgroundColor = YFLineViewColor;
    
    [self addSubview:linewView];
    
    return linewView;
}

@end
