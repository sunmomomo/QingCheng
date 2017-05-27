//
//  YFMediator.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFCompetionHeader.h"

@interface YFMediator : NSObject

+ (instancetype)sharedInstance;

// 远程App调用入口
- (YFReturnValue)performActionWithUrl:(NSURL *)url completion:(void(^)(NSDictionary *info))completion;
// 本地组件调用入口
- (YFReturnValue)performTarget:(NSString *)targetName action:(NSString *)actionName params:(NSDictionary *)params shouldCacheTarget:(BOOL)shouldCacheTarget;
- (void)releaseCachedTargetWithTargetName:(NSString *)targetName;


@end
