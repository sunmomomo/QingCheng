//
//  YFBlurHelp.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>


@interface YFBlurHelp : NSObject


/**
 *  将view转为image
 */
+ (UIImage *)getImageFromView:(UIView *)view;

/**
 * 获取随机颜色color
 */
+ (UIColor *)getRandomColor;

/**
 *根据比例（0...1）在min和max中取值
 */
+ (float)lerp:(float)percent min:(float)nMin max:(float)nMax;

@end
