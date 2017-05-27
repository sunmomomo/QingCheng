//
//  YFSignUpListAddCell.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCell.h"

#import "YFSignUpTagView.h"

@interface YFSignUpListAddCell : YFBaseCell

@property(nonatomic, strong)UIImageView *headImageView;
@property(nonatomic, strong)UILabel *nameLabel;
@property(nonatomic, strong)UILabel *phoneLabel;
@property(nonatomic, strong)UIImageView *sexImageView;

@property(nonatomic, strong)YFSignUpTagView *signUpTagView;

@property(nonatomic, copy)void(^deleteBlock)(id);

@property(nonatomic, weak)id weakModel;

- (void)setSelectStateYF;
- (void)setUnselectStateYF;

- (void)setDeleteStateYF;

- (void)setCannnotSelectStateYF;

@end
