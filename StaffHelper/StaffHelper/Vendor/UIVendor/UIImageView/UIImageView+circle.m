//
//  UIImageView+circle.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "UIImageView+circle.h"


@implementation UIImageView (circle)

+ (UIImageView *)circleBorderWithFrame:(CGRect)frame
{
    UIImageView *imageView = [UIImageView circleWithFrame:frame];
    
    imageView.layer.borderWidth = OnePX;
    
    return imageView;
}

+ (UIImageView *)circleWithFrame:(CGRect)frame
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:frame];
    
    imageView.layer.cornerRadius = imageView.width/2;
    
    imageView.layer.masksToBounds = YES;
    
    imageView.backgroundColor = YFMainBackColor;
    
    return imageView;
}




@end
