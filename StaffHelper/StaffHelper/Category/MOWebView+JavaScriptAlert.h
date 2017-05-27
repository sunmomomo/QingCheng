//
//  MOWebView+JavaScriptAlert.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/11/10.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOWebView.h"

@interface MOWebView (JavaScriptAlert)<UIAlertViewDelegate>
-(void)webView:(UIWebView *)sender runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;

-(BOOL)webView:(UIWebView *)sender runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(id)frame;
@end
