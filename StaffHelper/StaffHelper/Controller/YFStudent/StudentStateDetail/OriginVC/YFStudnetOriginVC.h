//
//  YFStudnetOriginVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"
#import "YFStudentFilterOriginModel.h"


@interface YFStudnetOriginVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)YFStudentFilterOriginModel *selectModel;

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic, copy)NSString *selectName;

// 是否是 筛选，筛选的话，接口不一样，分 全部数据，和筛选的数据
@property(nonatomic, assign)BOOL isFilter;


//  YES 可以添加新来源，NO 可以选择全部
@property(nonatomic,assign)BOOL isCanAdd;

/**
 * 根据 Name 选择，为空 则没有选择项
 */
- (void)setChooseName:(NSString *)name;

@end
