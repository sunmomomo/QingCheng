//
//  YFCardStateVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFCardStateModel.h"

@interface YFCardStateVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, strong)YFCardStateModel *cardStateModel;

@property(nonatomic,copy)void(^sureBlock)();

// 是否是余额不足 页面
@property(nonatomic ,assign)BOOL isNotSuffient;

@end
