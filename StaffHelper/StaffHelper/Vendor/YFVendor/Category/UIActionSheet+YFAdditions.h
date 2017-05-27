//
//  UIActionSheet+YFAdditions.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^YFActionSViewCallBackBlock)(NSInteger buttonIndex);


@interface UIActionSheet (YFAdditions)


@property (nonatomic, copy) YFActionSViewCallBackBlock actionSheetCallBackBlock;

/**
 * buttonIndex 0 2 3 4
 1 === 取消
 */
+(void)actionSWithCallBackBlock:(YFActionSViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...;

/**
 * buttonIndex 0 1 ,具体 请尝试
 2 === 取消
 */
+(void)actionSWithCallBackBlock:(YFActionSViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title destructiveButtonTitle:(NSString *)destructiveButtonTitle  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...;



@end

