//
//  YFPopBaseView.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface YFPopBaseView : UIControl

@property(nonatomic, strong)UIView *superView;


/**
 * 参照View，根据这个View 设置弹出View的位置
 */
@property(nonatomic, weak)UIView *referenceView;

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView;

- (instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame;

@property(nonatomic,strong)UIView * childredView;

@property(nonatomic,assign)CGFloat hideAlpha;

-(void)show;
// 有动画
-(void)hide;
- (void)showOrHide;

- (void)hideAnimate:(BOOL)isAmate;
/**
 * 背景
 */
-(void)initChildrenViewWithFrame:(CGRect)frame;

/**
 * 显示加载框
 */
-(void)showLoadingViewWithMessage:(NSString*)message;

/**
 * 加载完毕
 */
-(void)stopLoadingViewWithMessage:(NSString*)message;
/**
 * 各种错误信息提示
 */
-(void)showErrorInfo:(NSError *)error;
/**
 * 弹出框
 */
- (void)showAlertViewWithMessage:(NSString *)message;

-(void)showAnimate:(BOOL)isAmate;

- (void)hideControlAction:(id)sender;
@property(nonatomic,assign)CGRect hiddenFrame;

@property(nonatomic,assign)CGRect originFrame;

@end
