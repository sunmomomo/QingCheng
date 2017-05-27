//
//  UIView+masonryExtesionYF.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "UIView+masonryExtesionYF.h"
#import "Masonry.h"


@implementation UIView (masonryExtesionYF)


-(void)setxYF:(CGFloat)xx
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview.mas_left).offset(xx);
    }];
}
-(void)setyYF:(CGFloat)yy
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_top).offset(yy);
    }];
}

-(void)setLeftYF:(CGFloat)xx toView:(UIView *)view
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_left).offset(xx);
    }];
}
-(void)setLeftYF:(CGFloat)xx toViewRight:(UIView *)view
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view.mas_right).offset(xx);
    }];
}

-(void)setTopYF:(CGFloat)yy toView:(UIView *)view
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(view.mas_top).offset(yy);
    }];
}


-(void)setEqualCenterXOffset:(CGFloat)offset
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.superview.mas_centerX).offset(offset);
    }];
}

-(void)setEqualCenterYOffset:(CGFloat)offset
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.superview.mas_centerY).offset(offset);
    }];
}

-(void)setEqualCenterXOffset:(CGFloat)offset toView:(UIView *)view
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(view.mas_centerX).offset(offset);
    }];
}

-(void)setEqualCenterYOffset:(CGFloat)offset toView:(UIView *)view
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(view.mas_centerY).offset(offset);
    }];
}

-(void)setLeadingYF:(CGFloat)leading
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview.mas_left).offset(leading);
    }];
}

-(void)setTrailingYF:(CGFloat)trailing
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.superview.mas_right).offset(trailing);
    }];
}



-(void)setBottomYF:(CGFloat)bottom
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(@(bottom));
    }];
}

-(void)setTopYF:(CGFloat)top
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.superview.mas_top).offset(top);
    }];
}



-(void)setBottomLine
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.superview.mas_left);
        make.right.equalTo(self.superview.mas_right);
        make.height.equalTo(@(0.5));
        make.bottom.equalTo(self.superview.mas_bottom).offset(-0.5);
    }];
}


-(void)setWidthYF:(CGFloat)width
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(width));
    }];
    
}

-(void)setHeightYF:(CGFloat)height
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.equalTo(@(height));
    }];
}

-(void)setSizeYF:(CGSize)size
{
    [self mas_makeConstraints:^(MASConstraintMaker *make) {
        make.width.equalTo(@(size.width));
        make.height.equalTo(@(size.height));

    }];
}

@end
