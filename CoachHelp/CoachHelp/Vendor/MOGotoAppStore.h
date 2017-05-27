//
//  MOGotoAppStore.h
//  MOApp
//
//  Created by 馍馍帝👿 on 15/4/2.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MOGotoAppStore : NSObject

/**
 *通过appid跳转AppStore
 @param AppId 应用唯一标示
 */
+ (void)openAppStore:(NSString *)AppId;
@end
