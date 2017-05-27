//
//  UIView+masonryExtesionYF.h
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (masonryExtesionYF)

-(void)setxYF:(CGFloat)xx;
-(void)setyYF:(CGFloat)yy;



-(void)setTrailingYF:(CGFloat)trailing;


-(void)setBottomLine;

-(void)setWidthYF:(CGFloat)width;
-(void)setHeightYF:(CGFloat)height;
-(void)setSizeYF:(CGSize)size;

-(void)setBottomYF:(CGFloat)bottom;

-(void)setTopYF:(CGFloat)top;



-(void)setEqualCenterXOffset:(CGFloat)offset;

-(void)setEqualCenterYOffset:(CGFloat)offset;


-(void)setLeftYF:(CGFloat)xx toView:(UIView *)view;
-(void)setLeftYF:(CGFloat)xx toViewRight:(UIView *)view;
-(void)setTopYF:(CGFloat)yy toView:(UIView *)view;


-(void)setEqualCenterXOffset:(CGFloat)offset toView:(UIView *)view;
-(void)setEqualCenterYOffset:(CGFloat)offset toView:(UIView *)view;;

@end
