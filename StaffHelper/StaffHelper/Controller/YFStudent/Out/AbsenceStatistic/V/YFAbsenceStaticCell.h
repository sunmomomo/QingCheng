//
//  YFAbsenceStaticCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFAbsenceStaticCell : YFBaseCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UIImageView *sexImageView;


@property(nonatomic, strong)UIButton *phoneButton;

@property(nonatomic, strong)UIView *grayView;
@property(nonatomic, strong)UILabel *grayFirstLabel;
@property(nonatomic, strong)UILabel *graySecondLabel;
@property(nonatomic, strong)UILabel *grayThreeabel;

@property(nonatomic, strong)UILabel *grayFirstTimeLabel;
@property(nonatomic, strong)UILabel *grayFirstTimeUinitLabel;
@property(nonatomic, strong)UILabel *grayDaysLabel;


@property(nonatomic, copy)void(^phoneActionBlock)();


@end
