//
//  YFHomeLineChartModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/1/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseModel.h"
#import "YFStaticsModel.h"

@interface YFHomeLineChartModel : YFBaseModel

@property(nonatomic, copy)NSString *chartDesStr;

@property(nonatomic, copy)NSString *sellerCountDesStr;

@property(nonatomic, strong)UIColor *defaultColor;

@property(nonatomic, strong)YFStaticsModel *chartStaticModel;



@end
