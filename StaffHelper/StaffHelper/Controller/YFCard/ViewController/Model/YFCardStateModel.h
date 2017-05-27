//
//  YFCardStateModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFCardStateModel : YFBaseCModel

@property(nonatomic, assign)BOOL isSelected;

@property(nonatomic, copy)NSString *name;

@property(nonatomic, assign)CardState cardState;


- (NSDictionary *)paramOfState;

@end
