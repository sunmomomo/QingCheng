//
//  YFStudentStateCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#define YFGRAYLabelFont FontSizeFY(12.0)

#define YFMaxSize CGSizeMake(MSW - 16 - 82 - 7.5, 10000)



@interface YFStudentStateCell : YFBaseCell


@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;

@property(nonatomic, strong)UILabel *sellersLabel;


@property(nonatomic, strong)UIImageView *sexImageView;

@property(nonatomic, strong)UIImageView *stateImageView;
@property(nonatomic, strong)UILabel *stateLabel;
@property(nonatomic, strong)UIImageView *arrowImageView;

@property(nonatomic, strong)UIButton *phoneButton;

@property(nonatomic, strong)UIView *grayView;
@property(nonatomic, strong)UILabel *grayFirstLabel;
@property(nonatomic, strong)UILabel *graySecondLabel;
@property(nonatomic, strong)UILabel *grayThreeabel;


@property(nonatomic, copy)void(^phoneActionBlock)();

@end
