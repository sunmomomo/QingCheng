//
//  YFStudentRecommendVC.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFStudentFilterRePeoModel.h"

@interface YFStudentRecommendVC : YFBaseRefreshTBExtensionVC

@property(nonatomic,strong)YFStudentFilterRePeoModel *selectModel;

@property(nonatomic, copy)void(^selectBlock)();

@property(nonatomic,strong)Gym *gym;


@end
