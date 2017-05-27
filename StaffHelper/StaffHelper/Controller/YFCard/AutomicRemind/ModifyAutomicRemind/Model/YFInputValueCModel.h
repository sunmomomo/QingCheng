//
//  YFInputValueCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseInputValueCModel.h"

@interface YFInputValueCModel : YFBaseInputValueCModel

@property(nonatomic, copy)NSString *conditionName;

@property(nonatomic, strong)UIColor *conditionTextColor;

@property(nonatomic, copy)void (^changeValueTYF)(NSString *);

@end
