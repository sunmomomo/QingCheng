//
//  HorizontalGradientView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "HorizontalGradientView.h"

@implementation HorizontalGradientView

-(void)setLeftColor:(UIColor *)leftColor
{
    
    _leftColor = leftColor;
    
    if (_leftColor && _rightColor) {
        
        [self setGrandientLayer];
        
    }
    
}

-(void)setRightColor:(UIColor *)rightColor
{
    
    _rightColor = rightColor;
    
    if (_leftColor && _rightColor) {
        
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
                            (id)[_leftColor  CGColor],
                            (id)[_rightColor CGColor], nil];
    gradientLayer.startPoint = CGPointMake(0.0, 0.0);
    gradientLayer.endPoint = CGPointMake(1.0, 0.0);
    
    if ([[self.layer.sublayers firstObject] isKindOfClass:[CAGradientLayer class]]) {
        
        [self.layer replaceSublayer:[self.layer.sublayers firstObject] with:gradientLayer];
        
    }else{
        
        [self.layer insertSublayer:gradientLayer atIndex:0];
        
    }
    
}

-(void)reload
{
    
    [self setGrandientLayer];
    
}

@end
