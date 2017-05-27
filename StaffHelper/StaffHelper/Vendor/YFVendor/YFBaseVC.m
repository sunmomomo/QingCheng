//
//  YFBaseVC.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseVC.h"
#import "UIView+YFLoadAniView.h"
#import "MBProgressHUD.h"
#import "YFAppService.h"
#import "YFAppConfig.h"
#import "YFFailView.h"


@interface YFBaseVC ()

@property(nonatomic, assign)CGFloat naviOffsetYY;
@property(nonatomic, strong)YFFailView *failView;

@end


@implementation YFBaseVC
{
    UIBarButtonItem *_leftBackSpacerL;
}


-(void)loadView
{
    [super loadView];
    self.view.backgroundColor = [UIColor whiteColor];
    self.automaticallyAdjustsScrollViewInsets = NO;
    __weak typeof(self)weakS = self;
    
    [self setPushVC:^(UIViewController *VC) {
        [weakS pushViewControllerFY:VC];
    }];
    
    
}


-(void)addLeftBackButton
{
    if (!_leftBackSpacerL)
    {
        UIBarButtonItem *negativeSpacerL = [[UIBarButtonItem alloc]
                                            initWithBarButtonSystemItem:UIBarButtonSystemItemFixedSpace
                                            target:nil
                                            action:nil];
        negativeSpacerL.width = -10; //去除空白像素设置
        
        //        self.navigationController.interactivePopGestureRecognizer.delegate = (id<UIGestureRecognizerDelegate>)self;
    }
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = YFMainBackColor;
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if (self.navigationController.viewControllers.count > 0)
    {
        [self addLeftBackButton];
    }
}

-(void)showLoadingViewWithMessage:(NSString *)message
{
    if (self.navi.superview)
    {
    self.view.loadViewYF.frame = CGRectMake(0, 64.0, MSW, MSH - 64.0);
    }
    else
    {
        self.view.loadViewYF.frame = CGRectMake(0, 0, MSW, MSH);
    }
    [self.view showLoadingAniViewYF];
}
-(void)stopLoadingViewWithMessage:(NSString *)message
{
    [self.view stopLoadingAniViewYF];
}

-(void)pushViewControllerFY:(UIViewController *)VC
{
    [self.navigationController pushViewController:VC animated:YES];
}


-(void)addRightutton:(NSString *)title action:(SEL)action
{
    //    UIFont *font = [UIFont systemFontOfSize:14.0];
    //
    //    UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
    //    //    button.frame = CGRectMake(0, 20, 44, 44);
    //    CGFloat width = [self viewWidthFromStr:title font:font];
    //
    //    button.frame = CGRectMake(self.view.frame.size.width - width - 20, 20 + _naviOffsetYY, width, 44);
    //    [button.titleLabel setFont:font];
    //    [button setTitle:title forState:UIControlStateNormal];
    //    [button setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    //    [button addTarget:self action:action forControlEvents:UIControlEventTouchUpInside];
    //    [self setRightNaviButton:button];
}

-(CGFloat)viewWidthFromStr:(NSString *)str font:(UIFont *)font
{
    CGSize size = YF_MULTILINE_TEXTSIZE(str, font, CGSizeMake(1000, 40), 0) ;
    
    
    return size.width + 5.0;
}
#pragma mark 设置导航栏 button
-(void)setLeftNaviButton:(UIButton *)button
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}
-(void)setRightNaviButton:(UIButton *)button
{
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:button];
}

-(void)leftBarButtonClick:(UIButton *)btn
{
    if (self.navigationController.viewControllers.count == 1)
    {
        [self dismissViewControllerAnimated:YES completion:nil];
    }else
    {
        [self.navigationController popViewControllerAnimated:YES];
    }
}

#pragma mark -- Custom Action
- (void)showHint:(NSString *)hint
{
    
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    
    hud.mode = MBProgressHUDModeText;
    
    [self.view addSubview:hud];
    
    hud.label.text = hint;
    
    hud.label.numberOfLines = 0;
    
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:1.5];
}
- (void)showHint:(NSString *)hint customView:(UIView *)customView
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
    //    hud.bezelView.frame = CGRectMake(0, 0, 120, 120);
    hud.bezelView.backgroundColor = RGBA_YF(0, 0, 0, 0.7);
    
    
    if (customView)
    {
        hud.mode = MBProgressHUDModeCustomView;
        hud.customView = customView;
        
    }
    else
    {
        hud.mode = MBProgressHUDModeText;
    }
    hud.label.font = FontSizeFY(13.0);
    hud.label.textColor = [UIColor whiteColor];
    [self.view addSubview:hud];
    
    hud.label.text = hint;
    
    hud.label.numberOfLines = 0;
    
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:1.5];
}



- (void)showAlertViewMessageFY:(NSString *)message
{
    [YFAppService showAlertMessage:message];
}

-(void)emptyDataReminderAction
{
    if (self.emptyView)
    {
        
        [self.view addSubview:self.emptyView];
        
        [self.view bringSubviewToFront:self.emptyView];
    }else
        [YFAppService showAlertMessage:@"未查询到数据"];
}

-(void)clearAllRemindView
{
    [self.emptyView removeFromSuperview];
    [self hideFailView];
}

//   ing 失败掉的 方法
-(void)failRequest:(NSError *)error
{
    [self stopLoadingViewWithMessage:nil];
    if (self.failView) {
        [self showFailViewOnSuperView:nil];
    }else
        [YFAppService showAlertMessageWithError:error];
}


- (void)showFailViewOnSuperView:(UIView *)superView
{
    if (superView == nil)
    {
        superView = self.view;
    }
    if ([self.view isEqual:superView] && self.navi.superview) {
        self.failView.frame = CGRectMake(0, 64.0, self.view.width, self.view.height - 64.0);
    }else
    {
        self.failView.frame = CGRectMake(0, 0, superView.width, superView.height);
    }
    
    [superView addSubview:self.failView];
    [superView bringSubviewToFront:self.failView];
    self.failView.hidden = NO;
    
    DebugLogYF(@"--000---000000");
}
- (void)hideFailView
{
    [self.failView removeSelfFromView];
}
- (void)reloadNetDataYF
{
    
}
-(void)reloadData
{
    //    [self reloadNetDataYF];
}


#pragma mark Getter
- (YFFailView *)failView
{
    if (_failView == nil)
    {
        weakTypesYF
        CGRect frame;
        if (self.navi.superview)
        {
            frame = CGRectMake(0, 64.0, MSW, MSH - 64.0);
        }else
        {
            frame = self.view.bounds;
        }
        _failView = [[YFFailView alloc] initWithFrame:frame LoadBlock:^{
            [weakS reloadNetDataYF];
        }];
    }
    return _failView;
}

-(UIView *)failViewYF
{
    return _failView;
}

@end
