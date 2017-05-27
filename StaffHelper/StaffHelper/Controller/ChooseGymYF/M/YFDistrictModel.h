//
//  YFDistrictModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"


@interface YFDistrictModel : YFBaseCModel

@property(nonatomic, copy)NSString *code;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, strong)YFDistrictModel *city;
//
@property(nonatomic, strong)YFDistrictModel *province;

@end
