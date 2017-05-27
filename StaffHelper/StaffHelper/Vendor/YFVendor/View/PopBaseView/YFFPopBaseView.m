//
//  YFFPopBaseView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFFPopBaseView.h"

@implementation YFFPopBaseView
{
    UIView *_superView;
}
+(instancetype)defaultView
{
    
    return [[self alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
}


- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        UIView *tapView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        tapView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
        
        [self addSubview:tapView];
        
        [tapView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(close)]];
    }
    
    return self;
}

-(void)showInView:(UIView *)view
{
    _superView = view;
    
    [view addSubview:self];
    
    [view bringSubviewToFront:self];
    
}

-(void)close
{
    
    self.hidden = YES;
    
    [self removeFromSuperview];
    
}

@end
