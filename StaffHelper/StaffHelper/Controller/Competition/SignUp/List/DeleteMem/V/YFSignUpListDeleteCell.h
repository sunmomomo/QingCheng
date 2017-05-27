//
//  YFSignUpListDeleteCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFSignUpListDeleteCell : YFBaseCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UIImageView *sexImageView;

@property(nonatomic,copy)void(^deletActionBlock)(id);

@property(nonatomic, weak)id weakModel;

@end
