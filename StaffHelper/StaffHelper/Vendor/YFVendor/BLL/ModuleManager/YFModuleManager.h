//
//  YFModuleManager.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFModuleManager : NSObject

/**
 * 
 dataArray  多个 字典
 
 imageName: 图片名字
 title: 图片下标题
 isCanEnble: 可用不可用 @"0"不可 @"1"可
 
 actionBlock 传出 1 开始的tag 值 区分
 */

/*  例子
 //                NSDictionary *dic1 = @{@"title":@"销售分配",@"imageName":@"member_followHead1",@"isCanEnble":@"1"};
 //                NSDictionary *dic2 = @{@"title":@"销售分配",@"imageName":@"member_followHead2",@"isCanEnble":@"0"};
 //                NSDictionary *dic3 = @{@"title":@"销售分配",@"imageName":@"member_followHead3",@"isCanEnble":@"0"};
 //                NSDictionary *dic4 = @{@"title":@"销售分配",@"imageName":@"member_followHead4",@"isCanEnble":@"1"};
 //                NSDictionary *dic5 = @{@"title":@"销售分配",@"imageName":@"member_followHead5",@"isCanEnble":@"0"};
 //
 //                NSArray *array = @[dic1,dic2,dic3,dic4,dic5,dic1,dic4,dic5,dic2,dic3,dic4,dic5,dic1,dic4,dic5];
 //
 //                UIViewController *studentVC = [YFModuleManager memberFollowUpWithGym:AppGym dicArray:array actionBlock:^(NSUInteger tag) {
 //                    NSLog(@"%@",@(tag));
 //                }];
 */

// 会员跟进入口
+ (UIViewController *)memberFollowUpWithGym:(Gym *)gym dicArray:(NSArray *)dataArray actionBlock:(void(^)(NSUInteger))actionBlock;

+ (UIViewController *)chooseOriginWithOriginId:(NSString *)originId selectBlock:(void (^)(NSString*re_id,NSString*userName))selectBlock;

+ (UIViewController *)studentFollowingWithGym:(Gym *)gym;

/**
 * Tag = 1 新增注册
   Tag = 2 今日跟进
   Tag = 3 新增会员
 */
+ (void)studentNewMemberWithGym:(Gym *)gym tag:(NSUInteger)tag viewController:(void (^)(UIViewController *))vcBlock;

// 销售分配
+ (UIViewController *)belongSellerViewControllerWith:(Seller *)seller gym:(Gym *)gym;

//教练分配
+(UIViewController*)belongCoachViewControllerWith:(Coach*)coach gym:(Gym*)gym;

// 会员卡
+ (UIViewController *)cardListViewControllerGym:(Gym *)gym;
// 余额不足的 会员卡
+ (UIViewController *)cardListOfNotSuffientViewControllerGym:(Gym *)gym;


//选择会员
+ (UIViewController *)chooseStudentViewControllerGym:(Gym *)gym choosedArray:(NSMutableArray *)chooseArray isShowSelectView:(BOOL)isShow chooseBlock:(void(^)(NSMutableArray *))chooseBlock;

+ (UIViewController *)groupSmsViewControllerGym:(Gym *)gym;


@end
