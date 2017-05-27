//
//  YFStudentTransCell.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFStudentTransCell : YFBaseCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;


@property(nonatomic, strong)UIImageView *sexImageView;

@property(nonatomic, strong)UIImageView *stateImageView;
@property(nonatomic, strong)UILabel *stateLabel;
@property(nonatomic, strong)UIImageView *arrowImageView;


@property(nonatomic, strong)UIView *grayView;
@property(nonatomic, strong)UILabel *grayFirstLabel;
@property(nonatomic, strong)UILabel *graySecondLabel;

@end
