//
//  YFStudnetChooseStatusVC.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFChooseGenderCModel.h"

@interface YFStudnetChooseStatusVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, copy)NSString *status;

@property(nonatomic, strong)YFChooseGenderCModel *selectModel;

@property(nonatomic,copy)void(^sureBlock)();

- (void)setSelectStatus:(NSString *)status;

@end
