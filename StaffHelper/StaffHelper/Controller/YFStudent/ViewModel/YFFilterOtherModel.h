//
//  YFFilterOtherModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>




@interface YFFilterOtherModel : NSObject

/**
 *是否可以 筛选 销售
 */
@property(nonatomic, assign)BOOL isCanFilterSeller;

/**
 *是否可以 筛选 生日
 */
@property(nonatomic, assign)BOOL isCanFilterBirthday;

/**
 * 重置时 是否选择 今天，默认不选择 NO
 */
@property(nonatomic, assign)BOOL isShouldChooseTodayWhenClear;

@property(nonatomic, copy)NSString *status;
// 注册时间
@property(nonatomic, copy)NSString *startTime;
@property(nonatomic, copy)NSString *endTime;
@property(nonatomic, assign)YFIsRegisterTimeType timeType;


@property(nonatomic, copy)NSString *startBirthDayTime;
@property(nonatomic, copy)NSString *endBirthDayTime;

@property(nonatomic, copy)NSString *recoPeopleStrs;

@property(nonatomic, copy)NSString *originStrs;

//#warning 测试 会员跟进 中的单选 需要 传
//@property(nonatomic, copy)NSString *originName;

// 销售
@property(nonatomic, copy)NSString *seller_id;

@property(nonatomic,strong)NSMutableDictionary *allRecoDic;

@property(nonatomic,strong)NSMutableDictionary *allOrigDic;

@property(nonatomic, copy)NSString *gender;

/**
 * 是否 复制了 条件 (getParamWithDic:)
 */
@property(nonatomic, assign)BOOL isCopyParam;

- (instancetype)modelCopy;

- (instancetype)modelCopyAllConditon;

- (BOOL)isEmptyYF;

- (NSMutableDictionary *)paramWithDictionary:(NSMutableDictionary *)para;

- (NSMutableDictionary *)paramWithSingleDictionary:(NSMutableDictionary *)para;


/**
 * 多选 筛选 条件
 */
- (NSMutableDictionary *)paramDicYF;

/**
 * 单选 筛选 条件
 */
- (NSMutableDictionary *)paramDicSingleChooseYF;
- (NSMutableDictionary *)paramExtionDicSingleChooseYF;
/**
 *  从字典中 解析 筛选 条件
 */
- (void)getParamWithDic:(NSDictionary *)paramDic;

@end
