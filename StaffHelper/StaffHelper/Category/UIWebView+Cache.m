//
//  UIWebView+Cache.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/11/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "UIWebView+Cache.h"

@implementation UIWebView (Cache)

+(void)setCache
{
    
    UIWebView* webView = [[UIWebView alloc] initWithFrame:CGRectZero];
    
    NSString* secretAgent = [webView stringByEvaluatingJavaScriptFromString:@"navigator.userAgent"];
    
    NSString *newUagent = @"";
    
    if ([secretAgent rangeOfString:APPNAME].length) {
        
        newUagent = secretAgent;
        
    }else
    {
        
        newUagent = [NSString stringWithFormat:@"%@ FitnessTrainerAssistant/%@ iOS OEM:%@ QingchengApp/%@",secretAgent,VERSION,PushDistribute,APPNAME];
        
    }
    
    NSDictionary *dictionary = [[NSDictionary alloc]
                                initWithObjectsAndKeys:newUagent, @"UserAgent",nil];
    
    [[NSUserDefaults standardUserDefaults] registerDefaults:dictionary];
    
    NSDictionary *properties = [[NSMutableDictionary alloc] init];
    
    [properties setValue:[[NSUserDefaults standardUserDefaults]valueForKey:@"sessionId"] forKey:NSHTTPCookieValue];
    
    [properties setValue:@".qingchengfit.cn" forKey:NSHTTPCookieDomain];
    
    [properties setValue:@"qc_session_id" forKey:NSHTTPCookieName];
    
    [properties setValue:[NSDate dateWithTimeIntervalSinceNow:3*365*24*60*60] forKey:NSHTTPCookieExpires];
    
    [properties setValue:@"/" forKey:NSHTTPCookiePath];
    
    [properties setValue:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *cookie = [[NSHTTPCookie alloc]initWithProperties:properties];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:cookie];
    
    NSDictionary *oemProperties = [[NSMutableDictionary alloc] init];
    
    [oemProperties setValue:PushDistribute forKey:NSHTTPCookieValue];
    
    [oemProperties setValue:@".qingchengfit.cn" forKey:NSHTTPCookieDomain];
    
    [oemProperties setValue:@"oem" forKey:NSHTTPCookieName];
    
    [oemProperties setValue:[NSDate dateWithTimeIntervalSinceNow:3*365*24*60*60] forKey:NSHTTPCookieExpires];
    
    [oemProperties setValue:@"/" forKey:NSHTTPCookiePath];
    
    [oemProperties setValue:@"0" forKey:NSHTTPCookieVersion];
    
    NSHTTPCookie *oemCookie = [[NSHTTPCookie alloc]initWithProperties:oemProperties];
    
    [[NSHTTPCookieStorage sharedHTTPCookieStorage] setCookie:oemCookie];
    
}

@end
