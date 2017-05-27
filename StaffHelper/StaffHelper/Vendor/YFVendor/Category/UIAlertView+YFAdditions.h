//
//  UIAlertView+YFAdditions.h
//  YFActionSheet
//
//  Created by YFWCQ on 16/7/30.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YFAlertViewCallBackBlock)(NSInteger buttonIndex);

@interface UIAlertView (YFAdditions)

@property (nonatomic, copy) YFAlertViewCallBackBlock alertViewCallBackBlock;


+(instancetype)alertWithCallBackBlock:(YFAlertViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
