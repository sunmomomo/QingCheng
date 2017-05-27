//
//  YFTableViewHUD.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTableViewHUD.h"

@implementation YFTableViewHUD

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)willMoveToSuperview:(UIView *)newSuperview
{
    [super willMoveToSuperview:newSuperview];
    
    if (self.frame.size.height == MSH)
    {
        self.frame = CGRectMake(0, 64.0, self.frame.size.width, self.frame.size.height - 64.0);
    }else
    {
        self.frame = newSuperview.bounds;
    }
}

@end
