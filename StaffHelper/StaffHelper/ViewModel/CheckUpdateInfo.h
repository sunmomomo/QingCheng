//
//  CheckUpdateInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/7.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CheckUpdateInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,BOOL shouldUpdate,BOOL mustUpdate,NSURL *updateURL);

+(void)checkUpdateResult:(void(^)(BOOL success,BOOL shouldUpdate,BOOL mustUpdate,NSURL *updateURL))result;

@end
