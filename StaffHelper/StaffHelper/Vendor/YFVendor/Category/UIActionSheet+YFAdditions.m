//
//  UIActionSheet+YFAdditions.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "UIActionSheet+YFAdditions.h"

#import <objc/runtime.h>

@interface UIActionSheet ()<UIActionSheetDelegate>

@end

static void* YFActionSheetKey = @"YFActionSheetKey_FY";

@implementation UIActionSheet (YFAdditions)

+ (void)actionSWithCallBackBlock:(YFActionSViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title message:(NSString *)message cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonName   destructiveButtonTitle:nil otherButtonTitles:otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [sheet addButtonWithTitle:other];
        }
        va_end(args);
    }
    sheet.actionSheetCallBackBlock = alertViewCallBackBlock;
    sheet.delegate = sheet;
    
    [sheet showInView:[[[UIApplication sharedApplication] delegate] window]];
}


+ (void)actionSWithCallBackBlock:(YFActionSViewCallBackBlock)alertViewCallBackBlock title:(NSString *)title destructiveButtonTitle:(NSString *)destructiveButtonTitle cancelButtonName:(NSString *)cancelButtonName otherButtonTitles:(NSString *)otherButtonTitles, ...
{
    UIActionSheet *sheet  = [[UIActionSheet alloc] initWithTitle:title delegate:nil cancelButtonTitle:cancelButtonName   destructiveButtonTitle:destructiveButtonTitle otherButtonTitles:otherButtonTitles, nil];
    NSString *other = nil;
    va_list args;
    if (otherButtonTitles) {
        va_start(args, otherButtonTitles);
        while ((other = va_arg(args, NSString*))) {
            [sheet addButtonWithTitle:other];
        }
        va_end(args);
    }
    sheet.actionSheetCallBackBlock = alertViewCallBackBlock;
    sheet.delegate = sheet;
    
    [sheet showInView:[[[UIApplication sharedApplication] delegate] window]];
}




-(void)setActionSheetCallBackBlock:(YFActionSViewCallBackBlock)actionSheetCallBackBlock
{
    [self willChangeValueForKey:@"callbackBlock"];
    objc_setAssociatedObject(self, &YFActionSheetKey, actionSheetCallBackBlock, OBJC_ASSOCIATION_COPY);
    [self didChangeValueForKey:@"callbackBlock"];
    
}

-(YFActionSViewCallBackBlock)actionSheetCallBackBlock
{
    return objc_getAssociatedObject(self, &YFActionSheetKey);
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (self.actionSheetCallBackBlock) {
        self.actionSheetCallBackBlock(buttonIndex);
    }
}


@end
