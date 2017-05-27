//
//  UIView+Frame.h
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/7/17.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (Frame)

@property(nonatomic,strong,readwrite)NSIndexPath *indexPath;

@property(nonatomic,assign)NSInteger viewIdentifier;

/**
 *获取View的底部坐标
 @return 返回底部坐标
 */
-(CGFloat)bottom;

/**
 *获取View的右坐标
 @return 返回右坐标
 */
-(CGFloat)right;

/**
 *获取View的宽度
 @return 返回宽度
 */
-(CGFloat)width;

/**
 *获取View的高度
 @return 返回高度
 */
-(CGFloat)height;

/**
 *获取View的左坐标
 @return 返回左坐标
 */
-(CGFloat)left;

/**
 *获取View的顶部坐标
 @return 返回顶部坐标
 */
-(CGFloat)top;

/**
 *改变View的x坐标
 */
-(void)changeLeft:(CGFloat)left;

/**
 *改变View的y坐标
 */
-(void)changeTop:(CGFloat)top;

/**
 *改变View的高度
 */
-(void)changeWidth:(CGFloat)width;

/**
 *改变View的宽度
 */
-(void)changeHeight:(CGFloat)height;

-(void)changeSize:(CGSize)size;

-(void)changeOrigin:(CGPoint)origin;

/**
 *快速移除View全部子视图
 */
-(void)removeAllView;

@end
