//
//  YFOutRankDaysVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSliderPopViewVC.h"

#import "YFOutRandDaysCModel.h"

@interface YFOutRankDaysVC : YFSliderPopViewVC

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic, strong)YFOutRandDaysCModel *selelctModel;


@end
