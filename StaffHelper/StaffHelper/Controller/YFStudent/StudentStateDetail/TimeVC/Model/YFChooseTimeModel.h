//
//  YFChooseTimeModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"
#import "YFStudentChooseTimeCell.h"


@interface YFChooseTimeModel : YFBaseCModel

@property(nonatomic, copy)NSString *timeDesStr;

@property(nonatomic, copy)NSString *timeStr;

@property(nonatomic, strong)UIColor *desColor;

@end
