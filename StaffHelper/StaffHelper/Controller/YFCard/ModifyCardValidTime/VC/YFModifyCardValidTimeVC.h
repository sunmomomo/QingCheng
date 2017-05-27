//
//  YFModifyCardValidTimeVC.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFModifyCardValidTimeVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, assign)BOOL isValidtTime;

@property(nonatomic, copy)NSString *start;
@property(nonatomic, copy)NSString *end;

@property(nonatomic, assign)long cardId;

@property(nonatomic, strong)Gym *gym;

@property(nonatomic, assign)BOOL isCanTurnOffDateSwitch;

@end
