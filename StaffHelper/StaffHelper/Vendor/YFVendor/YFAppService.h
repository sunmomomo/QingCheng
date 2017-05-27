//
//  YFAppService.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFAppService : NSObject

/**
 * action 异步
 mainAction 回调主线程
 */
+(void)asypath:(void (^_Nullable)())action mainAction:(void (^_Nullable)())mainAction;

+(void)showAlertMessage:(NSString *_Nullable)message;

+(void)showAlertMessage:(NSString *_Nullable)message sureBlock:(void(^_Nullable)())sureBlock;

+(void)showAlertMessageWithError:(NSError *_Nullable)error;


+(nullable NSString *)errorStringFromError:(nullable NSError *)error;
+(void)showAlertMessage:(nullable NSString *)message sureTitle:(nullable NSString *)sureTitle sureBlock:(void(^_Nullable)())sureBlock;

+(void)showAlertMessage:(nullable NSString *)message onlySureBlock:(void(^_Nullable)())sureBlock;

+(void)showAlertMessage:(nullable NSString *)message oneTitle:(nullable NSString *)oneTitle;


@end
