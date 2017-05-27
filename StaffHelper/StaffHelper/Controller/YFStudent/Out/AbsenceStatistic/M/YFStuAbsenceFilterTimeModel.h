//
//  YFStuAbsenceFilterTimeModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStuAbsenceFilterTimeModel : YFBaseCModel

@property(nonatomic,assign)BOOL isSelected;

@property(nonatomic,copy)NSString *name;

@property(nonatomic, strong)NSDictionary *param;

@end
