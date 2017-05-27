//
//  YFAlertView.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^YFAlertViewCallBackBlock)(NSInteger buttonIndex);


@interface YFAlertView : NSObject

@property (nonatomic, copy) YFAlertViewCallBackBlock alertViewCallBackBlock;

+(instancetype)alertWithCallBackBlock:(YFAlertViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message  cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...;

@end
