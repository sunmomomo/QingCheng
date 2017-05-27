//
//  CardListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

#import "Student.h"

#import "YFCardSuffientModel.h"

@interface CardListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *cards;

@property(nonatomic,assign)NSInteger totalCount;

@property(nonatomic,copy)void(^requestFinish)(BOOL success,NSString *error);

// 是否是余额不足 页面
@property(nonatomic ,assign)BOOL isNotSuffient;

@property(nonatomic ,copy)NSString *suffinetCardCount;


@property(nonatomic, strong)YFCardSuffientModel *remindDaysModel;
@property(nonatomic, strong)YFCardSuffientModel *balancePayModel;
@property(nonatomic, strong)YFCardSuffientModel *remandTimesModel;


-(void)requestDataWithGym:(Gym*)gym andCardKindId:(NSInteger)cardKindId andState:(CardState)state andSearch:(NSString *)search;

// 根据 会员卡种类和类型 筛选
-(void)requestDataWithGym:(Gym *)gym contionParam:(NSDictionary *)contionParam andState:(CardState)state andSearch:(NSString *)search;

- (void)getCardConutshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


-(void)update;

- (void)getGetSuffientSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)getPutSuffientSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym param:(NSDictionary *)dicParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
