//
//  YFGymModule.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFGymModule : NSObject


/**
 *  修改 场馆信息
 */
+ (UIViewController *)modifyGymVCWithGym:(Gym *)gym modifySuccessBlock:(void(^)(id))modifySuccessBlock;

/**
 *  查看
 */
+ (UIViewController *)scanGymVCWithGym:(Gym *)gym;

@end
