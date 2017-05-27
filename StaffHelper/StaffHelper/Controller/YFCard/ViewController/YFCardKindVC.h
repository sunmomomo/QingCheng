//
//  YFCardKindVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFCardTypeModel.h"

#import "YFCardCModel.h"

#import "Gym.h"

@interface YFCardKindVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, strong)Gym *gym;

@property(nonatomic, strong)UITableView *firstTableView;

@property(nonatomic, strong)YFCardTypeModel *cardTypeModel;

@property(nonatomic, strong)YFCardCModel *cardModel;

@property(nonatomic,copy)void(^sureBlock)();

// 是否是余额不足 页面
@property(nonatomic ,assign)BOOL isNotSuffient;

@end
