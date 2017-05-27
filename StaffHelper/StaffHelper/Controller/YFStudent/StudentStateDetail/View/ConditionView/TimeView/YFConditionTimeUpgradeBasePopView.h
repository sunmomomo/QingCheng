//
//  YFConditionTimeUpgradeBasePopView.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFConditionPopView.h"

#import "YFStudentChooseLatestTimeVC.h"

@interface YFConditionTimeUpgradeBasePopView : YFConditionPopView

@property(nonatomic, strong)YFStudentChooseLatestTimeVC *timeVC;

- (void)settingTimeVC;



@end
