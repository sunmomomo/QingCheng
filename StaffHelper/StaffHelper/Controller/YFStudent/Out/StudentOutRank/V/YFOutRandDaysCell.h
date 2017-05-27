//
//  YFOutRandDaysCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFOutRandDaysCell : YFBaseCell

@property(nonatomic, copy)void(^buttonActionBlock)(UIButton*);


@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UIButton *leftButton;
@property(nonatomic, strong)UIButton *rightButton;

@end
