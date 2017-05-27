//
//  YFPopBaseView.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFPopBaseView.h"

#import "MBProgressHUD.h"
#import "UIView+YFLoadAniView.h"

@interface YFPopBaseView ()
//加载框
@property(nonatomic,strong)MBProgressHUD *proHUD;

@end

@implementation YFPopBaseView
{
    CGRect _childrenFrame;
}

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView childrenFrame:(CGRect)childrenFrame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        _childrenFrame = childrenFrame;
        
        [self setSubViewOfPopViewFrame:frame superView:superView];

    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame superView:(UIView *)superView
{
    self= [super initWithFrame:frame];
    
    if (self){
        
        [self setSubViewOfPopViewFrame:frame superView:superView];
    }
    
    return self;
}

- (void)setSubViewOfPopViewFrame:(CGRect)frame superView:(UIView *)superView
{
    self.hideAlpha = 0.0;
    if (superView == nil) {
        superView = [[UIApplication sharedApplication].delegate window];
    }
    _superView = superView;
    
    if (CGRectEqualToRect(frame, CGRectZero)) {
        CGFloat widthSort =[UIScreen mainScreen].bounds.size.width;
        
        CGFloat heightSort =[UIScreen mainScreen].bounds.size.height;
        
        
        self.frame = CGRectMake(0, 0, widthSort, heightSort);
    }
    
    
    [self setBackgroundColor:[UIColor colorWithRed:0. green:0. blue:0. alpha:.8]];
    
    self.hidden = YES;
    
    [superView addSubview:self];
    
    [self addTarget:self action:@selector(hideControlAction:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)hideControlAction:(id)sender
{
    [self hide];
}

-(void)initChildrenViewWithFrame:(CGRect)frame
{
    _originFrame = frame;
    
    
    _hiddenFrame = CGRectMake(_originFrame.origin.x, _originFrame.origin.y + _originFrame.size.height, _originFrame.size.width, _originFrame.size.height);
    
    _childredView = [[UIView alloc] initWithFrame:_hiddenFrame];
    
    _childredView .backgroundColor = [UIColor whiteColor];
    
    [self addSubview:_childredView ];
}

- (void)showOrHide
{
    if (self.hidden == NO)
    {
        [self hide];
        return;
    }
    [self show];
}


-(void)show
{
    [self showAnimate:YES];
}

-(void)showAnimate:(BOOL)isAmate
{
    
    CGFloat intemerTime = 0;
    CGFloat intemerTime2 = 0;
    if (isAmate)
    {
        intemerTime = 0.3;
        intemerTime2 = 0.1;
    }
    
    if (self.hidden == NO)
    {
        return;
    }
    
    [[[UIApplication sharedApplication].delegate window]endEditing:YES];
    
    [_superView addSubview:self];
    
    self.hidden = NO;
    
    self.userInteractionEnabled = YES;
    
    if (_childredView)
    {
        
        _childredView.alpha = self.hideAlpha;
        
        if (CGRectEqualToRect(_originFrame, _childredView.frame) == NO)
        {
            UIViewAnimationOptions option;
            
            if (_hiddenFrame.origin.y > _childredView.frame.origin.y) {
                option = UIViewAnimationOptionTransitionCurlDown;
            }else
            {
                option = UIViewAnimationOptionTransitionCurlDown;
            }
            
            __weak typeof(self)weakSelf  = self;
            
            [UIView animateWithDuration:intemerTime delay:0 options:option animations:^{
                _childredView.alpha = 1.;
                weakSelf.childredView.frame = _originFrame;
            } completion:^(BOOL finished) {
                
            }];
        }else
        {
            [UIView animateWithDuration:intemerTime2 delay:0 options:UIViewAnimationOptionTransitionCurlDown animations:^{
                
                self.alpha = 1.;
                
            } completion:^(BOOL finished) {
                
                [self removeFromSuperview];
            }];
        }
    }
}

-(void)hide
{
    [self hideAnimate:YES];
}

- (void)hideAnimate:(BOOL)isAmate
{
    CGFloat intemerTime = 0;
    CGFloat intemerTime2 = 0;
    if (isAmate)
    {
        intemerTime = 0.3;
        intemerTime2 = 0.1;
    }else
    {
        self.hidden = YES;
    }
    
    self.userInteractionEnabled = NO;
    
    if (_childredView)
    {
        if (CGRectEqualToRect(_hiddenFrame, _childredView.frame) == NO)
        {
            
            UIViewAnimationOptions option;
            
            if (_hiddenFrame.origin.y > _childredView.frame.origin.y) {
                option = UIViewAnimationOptionTransitionCurlDown;
            }else
            {
                option = UIViewAnimationOptionTransitionCurlDown;
            }
            
            __weak typeof(self)weakSelf  = self;
            
            [UIView animateWithDuration:intemerTime delay:0 options:option animations:^{
                
                _childredView.alpha = self.hideAlpha;
                
                weakSelf.childredView.frame = _hiddenFrame;
                
            } completion:^(BOOL finished) {
                //                [AppModel shareAppModel].chooseId = nil;
                
                weakSelf.hidden = YES;
                
            }];
        }
        
    }else
    {
        [UIView animateWithDuration:intemerTime2 delay:0 options:UIViewAnimationOptionTransitionCurlUp animations:^{
            
            self.alpha = 0.;
            
        } completion:^(BOOL finished) {
            
        }];
    }
    
}

-(void)setFrame:(CGRect)frame
{
    [super setFrame:frame];
    
    _originFrame = CGRectMake(0, self.frame.size.height - self.childredView.frame.size.height, self.frame.size.width, self.childredView.frame.size.height);
    
    _hiddenFrame = CGRectMake(_originFrame.origin.x, _originFrame.origin.y + _originFrame.size.height, _originFrame.size.width, _originFrame.size.height);
    
    self.childredView.frame = _hiddenFrame;
    
}

-(void)showLoadingViewWithMessage:(NSString*)message
{
    self.loadViewYF.frame = self.bounds;
    [self showLoadingAniViewYF];
}
-(void)stopLoadingViewWithMessage:(NSString*)message
{
    [self stopLoadingAniViewYF];
}

-(MBProgressHUD *)proHUD
{
    if (_proHUD == nil)
    {
        _proHUD = [[MBProgressHUD alloc] initWithView:self];
        
        [self addSubview:_proHUD];
    }
    [self bringSubviewToFront:_proHUD];
    return _proHUD;
}

//各种错误信息提示
-(void)showErrorInfo:(NSError *)error
{
    //错误提示语
    NSString *errorString = nil;
    
    if (error.code == -1009)
    {
        errorString = @"网络断开连接";
    }
    else if (error.code == -1003 || error.code == -1004)
    {
        errorString = @"服务器异常";
    }
    else if (error.code == -1001)
    {
        errorString = @"请求超时,请检查网络后重试!";
    }
    else if (error.code == 3848)
    {
        errorString = @"转换JOSN格式错误";
    }
    else if (error.code == -1016)
    {
        //不需要提示给用户，调试接口时应该解决掉这个问题
        errorString = @"网络不给力";
    }
    else
    {
        errorString = @"网络不给力";
    }
    [self showAlertViewWithMessage:errorString];
}

/**
 * 弹框方法
 */
- (void)showAlertViewWithMessage:(NSString *)message
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
    [alertView show];
}


@end
