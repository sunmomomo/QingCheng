//
//  YFSignUpDetailCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFSignUpTagView.h"

@interface YFSignUpDetailCell : YFBaseCell

@property(nonatomic, strong)UILabel *signUpTimeLabel;
@property(nonatomic, strong)UILabel *signUpPayLabel;
@property(nonatomic, strong)YFSignUpTagView *signUpTagView;

@end
