//
//  YFMediator+WebViewAction.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFMediator.h"

#import "YFCompetionHeader.h"


@interface YFMediator (WebViewAction)

/**
 * url webView Url
  completion 回调给 webView的block
 */
- (YFReturnValue)performActionWithWebUrl:(NSURL *)url params:(NSDictionary *)params completion:(void(^)(NSDictionary *info))completion;

@end
