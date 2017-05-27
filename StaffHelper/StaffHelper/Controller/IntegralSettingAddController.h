//
//  IntegralSettingAddController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "IntegralSetting.h"

@interface IntegralSettingAddController : MOViewController

@property(nonatomic,assign)BOOL isRecharge;

@property(nonatomic,strong)NSMutableArray *settings;

@property(nonatomic,copy)void(^setFinish)(IntegralCardSetting *cardSetting);

@end
