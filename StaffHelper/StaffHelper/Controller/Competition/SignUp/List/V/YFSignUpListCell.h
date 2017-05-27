//
//  YFSignUpListCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFSignUpTagView.h"

@interface YFSignUpListCell : YFBaseCell


@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UIImageView *sexImageView;
@property(nonatomic, strong)UIImageView *arrowImageView;


@property(nonatomic, strong)UILabel *signUpTimeLabel;
@property(nonatomic, strong)UILabel *signUpPayLabel;
@property(nonatomic, strong)YFSignUpTagView *signUpTagView;

@end
