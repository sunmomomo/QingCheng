//
//  YFWebViewBaseAction.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFWebViewBaseAction.h"

#import "YFCompetionHeader.h"

@implementation YFWebViewBaseAction


- (UIViewController *)vcWithParam:(NSDictionary *)dic
{
    UIViewController *vc = dic[YFViewCKey];
    if ([vc isKindOfClass:[UIViewController class]])
    {
        return vc;
    }
    return nil;
}

- (UIWebView *)webViewWithParam:(NSDictionary *)dic
{
    UIWebView *webView = dic[YFWebViewCKey];
    if ([webView isKindOfClass:[UIWebView class]])
    {
        return webView;
    }
    return nil;
}



@end
