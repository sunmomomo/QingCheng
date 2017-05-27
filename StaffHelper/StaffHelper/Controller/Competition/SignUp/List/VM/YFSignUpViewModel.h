//
//  YFSignUpViewModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "YFRespoDataArrayModel.h"

#import "YFSignUpDetailCModel.h"

#import "YFSignUpListBaseCModel.h"

#import "YFRespoSignPerArrayYYModel.h"

#import "YFSignUpGroupDetailModel.h"

@interface YFSignUpViewModel : YFDataBaseModel


@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic, assign)NSUInteger page;

@property(nonatomic, strong)YFRespoSignPerArrayYYModel *arrayModel;

@property(nonatomic, copy)NSNumber *competition_id;

@property(nonatomic, copy)NSNumber *gym_id;


@property(nonatomic, strong)YFSignUpDetailCModel *detailModel;

@property(nonatomic, strong)YFSignUpGroupDetailModel *groupDetailModel;


@property(nonatomic, copy)void(^addGroupBlock)(id);

// 增加 分组
@property(nonatomic, strong)NSDictionary *addTeamDic;

// 分组列表
@property(nonatomic, strong)NSMutableArray *groupModelDataArray;

- (void)getResponseDatashowLoadingOn:(UIView *)superView listModelClass:(Class)modelClass successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)getResponseDetailDatashowLoadingOn:(UIView *)superView   order_id:(NSNumber *)orderId successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


- (void)getResponseGroupListDatashowLoadingOn:(UIView *)superView   listModelClass:(Class)modelClass successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)getResponseGroupDetailDatashowLoadingOn:(UIView *)superView   teams_id:(NSNumber *)teams_id successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


- (void)postGroupName:(NSString *)groupName userIds:(NSArray *)idsArray showLoadingOn:(UIView *)superView  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


- (void)deleteGroupShowLoadingOn:(UIView *)superView teams_id:(NSNumber *)teams_id    successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


/**
 * 小组 添加移除 (user_ids 为 全量)
 */
- (void)putGroupName:(NSString *)groupName userIds:(NSArray *)idsArray teams_id:(NSNumber *)teams_id showLoadingOn:(UIView *)superView    successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
