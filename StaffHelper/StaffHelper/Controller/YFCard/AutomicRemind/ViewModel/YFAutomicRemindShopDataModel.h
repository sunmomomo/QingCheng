//
//  YFAutomicRemindShopDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"

#import "YFAutomicRemindCModel.h"

@interface YFAutomicRemindShopDataModel : YFDataBaseModel

@property(nonatomic, strong)NSMutableArray *dataArray;

@property(nonatomic, copy)NSString *webSetingUrl;

@property(nonatomic, strong)YFAutomicRemindCModel *remindPayModel;
@property(nonatomic, strong)YFAutomicRemindCModel *timesModel;
@property(nonatomic, strong)YFAutomicRemindCModel *timeModel;
@property(nonatomic, strong)YFAutomicRemindCModel *remindPayEnableModel;
@property(nonatomic, strong)YFAutomicRemindCModel *timesEnableModel;
@property(nonatomic, strong)YFAutomicRemindCModel *timeEnableModel;


- (void)getSuffientShopsSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;


- (void)putSuffientShopsSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym param:(NSDictionary *)param successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;

- (void)reloaData;

@end
