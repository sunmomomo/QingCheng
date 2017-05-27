//
//  YFCompetitionModule.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface YFCompetitionModule : NSObject


/**
 * 赛事列表
 */
+ (UIViewController *)contestListVC;

/**
 * 报名表 个人列表
 */
+ (UIViewController *)signUpListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id;

/**
 * 报名表 个人详情
 */
+ (UIViewController *)signUpDetailVCOrderId:(NSNumber *)orderId;

/**
 * 选择 报名人  dicArray 传入 @[@{@"id":@(3)}]
 */
+ (UIViewController *)signUpChoosePerListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id chooseidNumSet:(NSSet *)chooseidNumSet completion:(void(^)(NSMutableArray *,id))chooseBlock;

/**
 * 增加分组
 */
+ (UIViewController *)signUpAddGroupListVCWithGym:(NSNumber *)gym_id comeptitionId:(NSNumber *)comeptition_id completion:(void(^)(id))addBlock;

/**
 * 选择场馆
 */
+ (UIViewController *)chooseGymVCCompletion:(void(^)(NSDictionary*))gymBlock;

@end
