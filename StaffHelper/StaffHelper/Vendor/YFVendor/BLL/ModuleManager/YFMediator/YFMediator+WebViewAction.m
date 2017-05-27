//
//  YFMediator+WebViewAction.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFMediator+WebViewAction.h"

#import "YFCompetionHeader.h"

@implementation YFMediator (WebViewAction)

/*
 scheme://[target]/[action]?[params]
 
 url sample:
 aaa://targetA/actionB?id=1234
 */

- (YFReturnValue)performActionWithWebUrl:(NSURL *)url params:(NSDictionary *)params completion:(void(^)(NSDictionary *info))completion
{
    NSMutableDictionary *urlParams = [[NSMutableDictionary alloc] init];
    NSString *urlString = [url query];
    for (NSString *param in [urlString componentsSeparatedByString:@"&"]) {
        NSArray *elts = [param componentsSeparatedByString:@"="];
        if([elts count] < 2) continue;
        [urlParams setObject:[elts lastObject] forKey:[elts firstObject]];
    }
    
    if (params) {
        [urlParams addEntriesFromDictionary:params];
    }
    // 这里这么写主要是出于安全考虑，防止黑客通过远程方式调用本地模块。这里的做法足以应对绝大多数场景，如果要求更加严苛，也可以做更加复杂的安全逻辑。
    NSString *actionName = [url.path stringByReplacingOccurrencesOfString:@"/" withString:@""];
 
    // 这个demo针对URL的路由处理非常简单，就只是取对应的target名字和method名字，但这已经足以应对绝大部份需求。如果需要拓展，可以在这个方法调用之前加入完整的路由逻辑
    
    YFReturnValue result;
    
    if (actionName.length == 0)
    {
         result = [self performTarget:@"WebView" action:url.host params:urlParams shouldCacheTarget:YES];
    }
    else
    {
         result = [self performTarget:url.host action:actionName params:urlParams shouldCacheTarget:YES];
    }
   
       return result;
}


@end
