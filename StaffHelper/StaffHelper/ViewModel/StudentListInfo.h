//
//  StudentListInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "Gym.h"

#import "Seller.h"
#import "YFFilterOtherModel.h"

@interface StudentListInfo : NSObject

// 判断是否不需要 读取本地数据，YES 不读取，NO 可读取
@property(nonatomic, assign)   BOOL isCannotReadContent;


@property(nonatomic,strong)NSMutableArray *students;
// 按字母 排序
@property(nonatomic,strong)NSMutableArray *showArray;
// 按时间 排序
@property(nonatomic,strong)NSMutableArray *showTimeArray;

// 按字母 未分配 排序
@property(nonatomic,strong)NSMutableArray *showNoSellerArray;
// 按时间 未分配 排序
@property(nonatomic,strong)NSMutableArray *showNoSellerTimeArray;

// 按字母 未分配 排序
@property(nonatomic,strong)NSMutableArray *showNoCoachArray;
// 按时间 未分配 排序
@property(nonatomic,strong)NSMutableArray *showNoCoachTimeArray;

// 会员个数
@property(nonatomic,assign)NSUInteger studentCount;

@property(nonatomic,assign)NSUInteger studentNoSellerCount;

@property(nonatomic,assign)NSUInteger studentNoCoachCount;


@property(nonatomic,strong)NSMutableArray *headArray;

@property(nonatomic,copy)NSString *searchStr;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)void(^callBackSuccess)();

@property(nonatomic,strong)void(^callBackFailure)();

@property(nonatomic,copy)void(^request)(BOOL success);

+(instancetype)shareInfo;
/**
 * 请求场馆下 的所有会员
 */
-(void)requestAllDataWithGym:(Gym *)gym success:(void(^)())success Failure:(void(^)())failure;

-(void)reloadAllDataWithGym:(Gym *)gym success:(void (^)())success Failure:(void (^)())failure;

-(void)requestCardStudentWithGym:(Gym *)gym andIsEdit:(BOOL)isEdit success:(void(^)())success Failure:(void(^)())failure;

-(void)requestChestStudentWithGym:(Gym *)gym success:(void(^)())success Failure:(void(^)())failure;

-(void)requestWithSeller:(Seller*)seller andGym:(Gym*)gym success:(void(^)())success Failure:(void(^)())failure;

-(void)requestWithCoach:(Coach*)coach andGym:(Gym*)gym success:(void(^)())success Failure:(void(^)())failure;

-(void)requestAddDataWithSeller:(Seller*)seller andGym:(Gym*)gym success:(void(^)())success Failure:(void(^)())failure;

-(void)requestAddDataWithCoach:(Coach*)coach andGym:(Gym*)gym success:(void(^)())success Failure:(void(^)())failure;

// 筛选 条件
@property(nonatomic, strong)YFFilterOtherModel *fiterOtherModel;

@end
