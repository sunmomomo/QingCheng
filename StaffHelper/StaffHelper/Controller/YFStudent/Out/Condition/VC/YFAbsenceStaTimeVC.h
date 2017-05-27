//
//  YFAbsenceStaTimeVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSliderPopViewVC.h"

#import "YFStuAbsenceFilterTimeModel.h"

@interface YFAbsenceStaTimeVC : YFSliderPopViewVC

@property(nonatomic, copy)NSString *selectTitle;

@property(nonatomic, copy)void(^selectBlock)(id);

@property(nonatomic, strong)YFStuAbsenceFilterTimeModel *filterTimeModel;

@end
