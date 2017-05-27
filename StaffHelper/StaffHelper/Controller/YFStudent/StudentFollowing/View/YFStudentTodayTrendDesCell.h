//
//  YFStudentTodayTrendDesCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFButton.h"

@interface YFStudentTodayTrendDesCell : YFBaseCell

@property(nonatomic, strong)UIImageView *stateImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UIImageView *arrowImageView;

@property(nonatomic, strong)UILabel *valueLabel;

@property(nonatomic, strong)YFButton *button;

@end
