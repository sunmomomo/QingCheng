//
//  YFOutRandDaysCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFOutRandDaysCModel : YFBaseCModel

@property(nonatomic, copy)void(^buttonActionBlock)(UIButton *);

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,copy)NSString *valueStr;

@property(nonatomic,copy)NSString *keyStr;

@property(nonatomic,strong)NSDictionary *param;

@end
