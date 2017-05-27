//
//  UIView+YFLoadAniView.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "UIView+YFLoadAniView.h"

#import <objc/runtime.h>
#import "MOTableView.h"


static const void *kHttpRequestQCHUDKeyYF = @"kHttpRequestQCHUDKeyYF";


@interface UIView ()

@property(nonatomic,strong)QCTableViewHUD *progressHUDYF;

@end

@implementation UIView (YFLoadAniView)

@dynamic loadViewYF;

-(QCTableViewHUD *)progressHUDYF
{
    QCTableViewHUD *HUD = objc_getAssociatedObject(self, &kHttpRequestQCHUDKeyYF);
    if (HUD == nil)
    {
        if (self.height == MSH && self.width == MSW)
        {
        HUD = [[QCTableViewHUD alloc] initWithFrame:CGRectMake(0, 64.0, MSW, MSH - 64.0)];
        }else
        {
            HUD = [[QCTableViewHUD alloc] initWithFrame:self.bounds];
        }
        
        
        objc_setAssociatedObject(self, &kHttpRequestQCHUDKeyYF, HUD, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        HUD.hidden = YES;

    }
    [self addSubview:HUD];
    [self bringSubviewToFront:HUD];
    return HUD;
}


- (void)showLoadingAniViewYF
{
    [self.progressHUDYF loading];
}

- (void)stopLoadingAniViewYF
{
    
    [self.progressHUDYF stopLoading];
}
-(UIView *)loadViewYF
{
    return self.progressHUDYF;
}
-(void)setLoadViewYF:(UIView *)loadViewYF
{
    
}

- (void)setLoadViewOffsetNavi
{
    self.progressHUDYF.frame = CGRectMake(0, 64.0, self.progressHUDYF.width, MSH - 64.0);
}

- (void)setLoadViewFrame:(CGRect)frame
{
    self.progressHUDYF.frame = frame;
}


@end
