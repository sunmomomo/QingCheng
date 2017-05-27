//
//  GradientView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GradientView.h"

@implementation GradientView

-(void)setTopColor:(UIColor *)topColor
{
    
    _topColor = topColor;
    
    if (_topColor && _bottomColor) {
        
        [self setGrandientLayer];
        
    }
    
}

-(void)setBottomColor:(UIColor *)bottomColor
{
    
    _bottomColor = bottomColor;
    
    if (_topColor && _bottomColor) {
        
        [self setGrandientLayer];
        
    }
    
}

-(void)setGrandientLayer
{
    
    CAGradientLayer *gradientLayer = [CAGradientLayer layer];  // 设置渐变效果
    gradientLayer.bounds = self.bounds;
    gradientLayer.borderWidth = 0;
    
    gradientLayer.frame = self.bounds;
    gradientLayer.colors = [NSArray arrayWithObjects:
                             (id)[[_topColor colorWithAlphaComponent:0.86] CGColor],
                             (id)[[_bottomColor colorWithAlphaComponent:0.86] CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(0.0, 1.0);
    
    gradientLayer.cornerRadius = 8;
    
    [self.layer insertSublayer:gradientLayer atIndex:0];
    
}

@end
