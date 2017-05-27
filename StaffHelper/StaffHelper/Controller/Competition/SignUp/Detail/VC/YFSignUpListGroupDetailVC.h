//
//  YFSignUpListGroupDetailVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFSignUpViewModel.h"

@interface YFSignUpListGroupDetailVC : YFBaseRefreshTBExtensionVC


@property(nonatomic, copy)NSNumber *gym_id;

@property(nonatomic, copy)NSNumber *teams_id;

@property(nonatomic, copy)NSNumber *comeptition_id;

@property(nonatomic, strong)YFSignUpViewModel *viewModel;


@end
