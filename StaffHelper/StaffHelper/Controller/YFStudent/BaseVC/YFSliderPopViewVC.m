//
//  YFSliderPopViewVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSliderPopViewVC.h"

@interface YFSliderPopViewVC ()

@end

@implementation YFSliderPopViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)showLeftView
{
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
      
        self.rightView.frame = CGRectMake(self.view.width, self.rightView.mj_y, self.rightView.width, self.rightView.height);
        
        self.leftView.frame = CGRectMake(0, self.leftView.mj_y, self.leftView.width, self.leftView.height);

        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)showRightView
{
    CGFloat width = self.view.width;
    if (width == 0)
    {
        width = self.leftView.width;
    }
    
    DebugLogParamYF(@"*****&&&&--:%@",self.leftView);
    
    [UIView animateWithDuration:0.4 delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
        
        self.rightView.frame = CGRectMake(0, self.rightView.mj_y, self.rightView.width, self.rightView.height);
        
        self.leftView.frame = CGRectMake(-width, self.leftView.mj_y, self.leftView.width, self.leftView.height);
        
        
    } completion:^(BOOL finished) {
        DebugLogParamYF(@"*****&&&&--:%@",self.leftView);
    }];
}

- (void)showRightViewNow
{
    self.rightView.frame = CGRectMake(0, self.rightView.mj_y, self.rightView.width, self.rightView.height);
    
    self.leftView.frame = CGRectMake(-self.view.width, self.leftView.mj_y, self.leftView.width, self.leftView.height);
}

@end
