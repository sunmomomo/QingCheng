//
//  YFStudentListCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFStudentListCell : YFBaseCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;

@property(nonatomic, strong)UIImageView *sexImageView;

@property(nonatomic, strong)UIImageView *stateImageView;
@property(nonatomic, strong)UILabel *stateLabel;
@property(nonatomic, strong)UIImageView *arrowImageView;

@end
