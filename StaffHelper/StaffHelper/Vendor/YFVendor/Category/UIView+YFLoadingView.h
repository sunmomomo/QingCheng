//
//  UIView+YFLoadingView.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIView (YFLoadingView)

/**
 * message 可以 为 空
 */
- (void)showLoadingViewWithMessage:(NSString *)message;

/**
 * message 为空，会 马上 消失
 message 不为空，会 先显示 文字，延迟 消失
 */
- (void)stopLoadingViewWithMessage:(NSString *)message;


- (void)showHint:(NSString *)hint;

@end
