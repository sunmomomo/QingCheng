//
//  YFSignUpListBaseVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFSignUpViewModel.h"

@interface YFSignUpListBaseVC : YFBaseRefreshTBExtensionVC<UITextFieldDelegate>

@property(nonatomic, strong)UITextField *searchBar;

@property(nonatomic, strong)UIView *tHeadView;

@property(nonatomic, strong)YFSignUpViewModel *viewModel;

@property(nonatomic, strong)UILabel *peoPayNumLabel;

@property(nonatomic, copy)NSNumber *gym_id;

@end
