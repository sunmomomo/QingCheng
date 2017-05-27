//
//  YFStudnetChooseGenderVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFChooseGenderCModel.h"

@interface YFStudnetChooseGenderVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, copy)NSString *gender;

@property(nonatomic, strong)YFChooseGenderCModel *selectModel;

@property(nonatomic,copy)void(^sureBlock)();

@end
