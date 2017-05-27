//
//  YFDesSwitchCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseInputValueCModel.h"

@interface YFDesSwitchCModel : YFBaseInputValueCModel

@property(nonatomic, assign)BOOL isCanTurnOffDateSwitch;


@property(nonatomic, copy)NSString *des;

@property(nonatomic, strong)UIColor *desTextColor;

@property(nonatomic, assign)BOOL on;

@end
