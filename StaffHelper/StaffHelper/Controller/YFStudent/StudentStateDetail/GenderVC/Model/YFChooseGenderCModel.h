//
//  YFChooseGenderCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFChooseGenderCModel : YFBaseCModel

@property(nonatomic, assign)BOOL isSelected;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, copy)NSString *gender;

- (NSDictionary *)paramOfState;

- (NSDictionary *)paramOfStatus;

@end
