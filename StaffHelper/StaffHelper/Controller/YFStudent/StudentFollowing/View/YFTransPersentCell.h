//
//  YFTransPersentCell.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

@interface YFTransPersentCell : YFBaseCell

@property(nonatomic, strong)UILabel *nameLabel;

@property(nonatomic, strong)UIImageView *headImageView;

@property(nonatomic, strong)UILabel *persertFirstLabel;
@property(nonatomic, strong)UILabel *persertSecondLabel;
@property(nonatomic, strong)UILabel *persertThirdLabel;

@property(nonatomic, strong)UILabel *persertFirstCountLabel;
@property(nonatomic, strong)UILabel *persertSecondCountLabel;
@property(nonatomic, strong)UILabel *persertThirdCountLabel;


@property(nonatomic, strong)UIView *lineTwoLevelView;

- (void)setTwoLevel;
@end
