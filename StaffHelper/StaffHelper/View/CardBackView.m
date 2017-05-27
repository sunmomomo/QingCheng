//
//  CardBackView.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardBackView.h"

@implementation CardBackView

-(void)setBackColor:(UIColor *)backColor
{
    
    _backColor = backColor;
    
    CALayer *layer = [CALayer layer];
    
    layer.bounds = self.bounds;
    
    layer.borderWidth = 0;
    
    layer.frame = self.bounds;
    
    layer.backgroundColor = [_backColor colorWithAlphaComponent:0.8].CGColor;
    
    if (self.layer.sublayers.count) {
        
        CALayer *oldLayer = [self.layer.sublayers firstObject];
        
        [self.layer replaceSublayer:oldLayer with:layer];
        
    }else
    {
        
        [self.layer insertSublayer:layer atIndex:0];
        
    }
    
}

@end
