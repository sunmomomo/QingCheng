//
//  YFWebViewBaseAction.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YFWebViewBaseAction : NSObject


- (UIViewController *)vcWithParam:(NSDictionary *)dic;


- (UIWebView *)webViewWithParam:(NSDictionary *)dic;

@end
