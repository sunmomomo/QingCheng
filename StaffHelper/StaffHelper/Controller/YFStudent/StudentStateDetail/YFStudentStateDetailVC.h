//
//  YFStudentStateDetailVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFFilterOtherModel.h"

#import "NSObject+firterModel.h"


@interface YFStudentStateDetailVC : YFBaseRefreshTBExtensionVC

/**
 * 0 1 2
 */
@property(nonatomic,copy)NSString *status;

@property(nonatomic ,strong)NSArray *buttonTitlesArray;

@property(nonatomic ,strong)NSArray *classsArray;

@property(nonatomic ,copy)void(^buttonActionBlock)(NSUInteger);

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL isCanSearch;

// 是否 是 会员转化 高优先级
@property(nonatomic,assign)BOOL isTransPersent;


@property(nonatomic, copy)NSString *emptyStr;



/**
 * 正常图片
 */
@property(nonatomic, strong)NSMutableArray *nomalDownImageArray;

@property(nonatomic, strong)NSMutableArray *nomalUpImageArray;



/**
 * 选中图片
 */
@property(nonatomic, strong)NSMutableArray *selectDownImageArray;

/**
 * 选中图片
 */
@property(nonatomic, strong)NSMutableArray *selectUpImageArray;

@property(nonatomic, copy)void(^clickWithIndex)(NSUInteger);

- (void)refreshTableListDataForFilter;
@end
