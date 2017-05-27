//
//  YFMesNotiSettingDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "YFAutomicRemindCModel.h"

@interface YFMesNotiSettingDataModel : YFDataBaseModel

@property(nonatomic, strong)YFAutomicRemindCModel *model;

- (void)getSuffientShopsNotiSettingshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)putSuffientShopsNotiSettingshowLoadingOn:(UIView *)superView gym:(Gym *)gym value:(NSString *)value successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

@end
