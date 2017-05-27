//
//  YFTagColloectionViewCell.h
//  YFTagView
//
//  Created by FYWCQ on 17/3/18.
//  Copyright © 2017年 YFWCQ. All rights reserved.
//

#import "YFBaseCViewCell.h"

@interface YFTagColloectionViewCell : YFBaseCViewCell

@property(nonatomic, weak)Student *tagModel;


@property(nonatomic, strong)UIButton *deleteButton;

@property(nonatomic, strong)UILabel *tagNameLabel;

@end
