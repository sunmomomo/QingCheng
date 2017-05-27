//
//  YFAlertView.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFAlertView.h"
#import <UIKit/UIKit.h>


@implementation YFAlertView

static YFAlertView *alertObject;

+(instancetype)alertWithCallBackBlock:(YFAlertViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    alertObject = [[YFAlertView alloc] init];
    
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:alertObject cancelButtonTitle:cancelButtonName otherButtonTitles: otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [alert addButtonWithTitle:other];
        }
        va_end(args);
    }
    alertObject.alertViewCallBackBlock = alertViewCallBackBlock;
    
    [alert show];
    return alertObject;

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (self.alertViewCallBackBlock) {
        self.alertViewCallBackBlock(buttonIndex);
    }
}

@end
