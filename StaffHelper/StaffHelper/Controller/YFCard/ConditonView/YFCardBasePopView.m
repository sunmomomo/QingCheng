//
//  YFCardBasePopView.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardBasePopView.h"

@implementation YFCardBasePopView
{
    UIControl *_blackGroundView;
}
- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame sufient:(BOOL)isSuffent
{
    self = [super initWithFrame:frame superView:superView childrenFrame:childrenFrame];
    if (self)
    {
        self.isValidParam = YES;
        _blackGroundView = [[UIControl alloc] initWithFrame:CGRectZero];
        _blackGroundView.backgroundColor = RGBACOLOR(0, 0, 0, 0.4);
        [_blackGroundView addTarget:self action:@selector(hideControlAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:_blackGroundView];
        [self sendSubviewToBack:_blackGroundView];
        self.childredView.backgroundColor = [UIColor whiteColor];
    }
    return self;
}

-(void)initChildrenViewWithFrame:(CGRect)frame
{
    
    
    [super initChildrenViewWithFrame:frame];
}

-(void)setReferenceView:(UIView *)referenceView
{
    
}

- (void)showAnimate:(BOOL)isAmate
{
//    self.hiddenFrame = CGRectMake(self.originFrame.origin.x, self.originFrame.origin.y, self.originFrame.size.width, 0);
//    
    _blackGroundView.frame = CGRectMake(self.originFrame.origin.x, self.originFrame.origin.y, self.originFrame.size.width, self.height - self.originFrame.origin.y);
//
//    
//    self.childredView.frame = self.hiddenFrame;
    [super showAnimate:isAmate];
}

- (void)hideAnimate:(BOOL)isAmate
{
    if (self.hideBlock) {
        self.hideBlock();
    }
    [super hideAnimate:isAmate];
}



@end
