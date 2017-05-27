//
//  MOWebView+JavaScriptAlert.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/10.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOWebView+JavaScriptAlert.h"

@implementation MOWebView (JavaScriptAlert)

static BOOL alertState = NO;

-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* dialogue = [[UIAlertView alloc]initWithTitle:nil message:message delegate:self cancelButtonTitle:@"知道了" otherButtonTitles:nil, nil];
    [dialogue show];
    
    if (!self.noBlock) {
        
        CFRunLoopRun();
        
    }else
    {
        
        self.noBlock = NO;
        
    }
    
    return;
    
}

-(void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    
    CFRunLoopStop(CFRunLoopGetCurrent());
    
}

-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame{
    UIAlertView* alert = [[UIAlertView alloc] initWithTitle:nil message:message delegate:self cancelButtonTitle:NSLocalizedString(@"否", @"Cancel") otherButtonTitles:NSLocalizedString(@"是", @"Ok"), nil];
    [alert show];
    
    CFRunLoopRun();
    
    return alertState;
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==0) {
        alertState=NO;
    }else if(buttonIndex==1){
        alertState=YES;
    }
}
@end