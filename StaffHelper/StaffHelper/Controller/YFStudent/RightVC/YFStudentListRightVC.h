//
//  YFStudentListRightVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//


#import "YFBaseRefreshTBExtensionVC.h"

#import "YFFilterOtherModel.h"

#import "YFStudentFilterOriginModel.h"



@class YFStudentFilterRePeoModel;
@interface YFStudentListRightVC : YFBaseRefreshTBExtensionVC

// 来源 选中 Model 用来实现 单选
@property(nonatomic,strong)YFStudentFilterOriginModel *selectModel;
// 推荐人 选中 Model 用来实现 单选
@property(nonatomic,strong)YFStudentFilterRePeoModel *selectReModel;

/**
 *是否可以 筛选 生日
 */
@property(nonatomic, assign)BOOL isCanFilterBirthday;
/**
 *是否可以 筛选 销售
 */
@property(nonatomic, assign)BOOL isCanFilterSeller;

/**
 * 重置时 是否选择 今天，默认不选择 NO
 */
@property(nonatomic, assign)BOOL isShouldChooseTodayWhenClear;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)YFFilterOtherModel *filterModel;

@property(nonatomic,copy)void(^sureBlock)();

@property(nonatomic,strong)NSMutableDictionary *allRecoDic;

@property(nonatomic,strong)NSMutableDictionary *allOrigDic;

/**
 * ""或 nil 全部，"0"是未分配销售， 具体 id 是某个销售的分配
 */
@property(nonatomic, copy)NSString *seller_id;

// 是否是 筛选，筛选的话，接口不一样，分 全部数据，和筛选的数据
@property(nonatomic, assign)BOOL isFilter;

@end
