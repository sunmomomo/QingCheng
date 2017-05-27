//
//  YFPayStyleModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFPayStyleModel : YFBaseCModel

@property(nonatomic, strong)UIColor *desColor;

@property(nonatomic, strong)UIColor *desValueColor;

@property(nonatomic, copy)NSString *des;
@property(nonatomic, copy)NSString *desValue;

@property(nonatomic, copy)NSString *desSubValue;

@property(nonatomic, assign)BOOL isShowSubValue;

@end
