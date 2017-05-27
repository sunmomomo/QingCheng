//
//  UIView+YFLoadAniView.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YFLoadAniView)

@property(nonatomic,strong)UIView *loadViewYF;


- (void)setLoadViewOffsetNavi;

- (void)showLoadingAniViewYF;
- (void)stopLoadingAniViewYF;

- (void)setLoadViewFrame:(CGRect)frame;
@end
