//
//  UIView+YFLoadingView.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "UIView+YFLoadingView.h"
#import "MBProgressHUD.h"
#import <objc/runtime.h>
static const void *kHttpRequestHUDKeyFY = @"kHttpRequestHUDKeyFY";
static const void *kHttpHintHUDKeyFY = @"kHttpHintHUDKeyFY";

@interface UIView ()

@property(nonatomic,strong)MBProgressHUD *progressHUDFY;
@property(nonatomic,strong)MBProgressHUD *hintHUDFY;

@end

@implementation UIView (YFLoadingView)

-(MBProgressHUD *)progressHUDFY
{
    MBProgressHUD *HUD = objc_getAssociatedObject(self, &kHttpRequestHUDKeyFY);
    if (HUD == nil)
    {
        HUD = [[MBProgressHUD alloc] initWithView:self];
        objc_setAssociatedObject(self, &kHttpRequestHUDKeyFY, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    [self addSubview:HUD];
    [self bringSubviewToFront:HUD];
    return HUD;
}

-(MBProgressHUD *)hintHUDFY
{
    MBProgressHUD *HUD = objc_getAssociatedObject(self, &kHttpHintHUDKeyFY);
    if (HUD == nil)
    {
        HUD = [MBProgressHUD showHUDAddedTo:self animated:YES];
        objc_setAssociatedObject(self, &kHttpRequestHUDKeyFY, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        HUD.userInteractionEnabled = NO;
        // Configure for text only and offset down
        HUD.mode = MBProgressHUDModeText;
        HUD.margin = 10.f;
        HUD.offset = CGPointMake(HUD.offset.x, - 45.0);
    }
    [self addSubview:HUD];
    [self bringSubviewToFront:HUD];
    return HUD;
}

-(void)showLoadingViewWithMessage:(NSString*)message
{
    if (message) {
        self.progressHUDFY.label.text = message;
    }else
    {
        self.progressHUDFY.label.text = @"";
    }
    
    [self.progressHUDFY showAnimated:YES];
}

-(void)stopLoadingViewWithMessage:(NSString*)message
{
    
    if (message.length)
    {
        self.progressHUDFY.label.text = message;
        [self.progressHUDFY hideAnimated:YES afterDelay:.5];
    }
    else
    {
        [self.progressHUDFY hideAnimated:YES];
    }
}

- (void)showHint:(NSString *)hint
{
    MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self];
    
    hud.mode = MBProgressHUDModeText;
    
    [self addSubview:hud];
    
    hud.label.text = hint;
    
    hud.label.numberOfLines = 0;
    
    [hud showAnimated:YES];
    
    [hud hideAnimated:YES afterDelay:1.5];
}


@end
