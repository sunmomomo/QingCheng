//
//  YFAutomicRemindCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFAutomicRemindCModel : YFBaseCModel

@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *desName;
@property(nonatomic, copy)NSString *valueString;

@property(nonatomic, assign)BOOL isOpen;

@property(nonatomic, assign)BOOL editable;
@property(nonatomic, assign)BOOL readable;

@property(nonatomic, copy)NSString *value;

@property(nonatomic, copy)NSString *group_name;
@property(nonatomic, copy)NSString *priority;
@property(nonatomic, copy)NSString *shop_id;
@property(nonatomic, copy)NSString *key;
@property(nonatomic, copy)NSString *valueSwitchId;
@property(nonatomic, copy)NSString *re_id;


@end
