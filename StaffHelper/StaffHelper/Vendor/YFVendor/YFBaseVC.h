//
//  YFBaseVC.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//


#import "MOViewController.h"
#import "YFAppConfig.h"

@interface YFBaseVC : MOViewController

@property(nonatomic,strong)UIView *emptyView;
@property(nonatomic, strong)UIView *failViewYF;

//跳转页面
@property(nonatomic, copy)void(^pushVC)(UIViewController*);
/**
 * 加载框
 */
-(void)showLoadingViewWithMessage:(NSString*)message;

-(void)stopLoadingViewWithMessage:(NSString*)message;


-(void)pushViewControllerFY:(UIViewController *)VC;


-(void)addRightutton:(NSString *)title action:(SEL)action;

- (void)showHint:(NSString *)hint;

- (void)showHint:(NSString *)hint customView:(UIView *)customView;

-(void)emptyDataReminderAction;

- (void)showAlertViewMessageFY:(NSString *)message;

/**
 * 请求失败
 停止刷新动画，失败提示
 */
-(void)failRequest:(NSError *) error;

// 失败后 点击 调用该 方法
- (void)reloadNetDataYF;
/**
 * 清除 所有的 加载动画View 失败View 空信息视图
 */
-(void)clearAllRemindView;

// 展示 网络失败的View
- (void)showFailViewOnSuperView:(UIView *)superView;

@end
