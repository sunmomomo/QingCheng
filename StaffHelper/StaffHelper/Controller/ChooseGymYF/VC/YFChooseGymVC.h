//
//  YFChooseGymVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFChooseGymVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)Gym *gym;

@property(nonatomic, copy)void(^chooseGymBlock)(NSDictionary*);

@end
