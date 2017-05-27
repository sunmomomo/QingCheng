//
//  YFSignUpListDeleteCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListDeleteCell.h"

#import "UIView+masonryExtesionYF.h"


@interface YFSignUpListDeleteCell ()

@property(nonatomic, strong)UIButton *selectButton;

@end


@implementation YFSignUpListDeleteCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sexImageView];
        
        
        [self.contentView addSubview:self.selectButton];
        
        
        [self.sexImageView setSizeYF:CGSizeMake(14.0, 13.0)];
        [self.sexImageView setEqualCenterYOffset:0.0 toView:self.nameLabel];
        
        [self.sexImageView setLeftYF:7.0 toViewRight:self.nameLabel];
        
        
    }
    return self;
}




- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(50, 15, 48, 48)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = 24;
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, self.headImageView.top + 1, 50, 21)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(15.0);
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 3, MSW - self.nameLabel.left - 15, 18)];
        _phoneLabel.textColor = RGB_YF(136, 136, 136);
        _phoneLabel.font = FontCellTitleValueFY;
    }
    return _phoneLabel;
}


-(UIImageView *)sexImageView
{
    if (_sexImageView == nil)
    {
        _sexImageView = [[UIImageView alloc] init];
        //        _sexImageView.clipsToBounds = YES;
        //        _sexImageView.layer.cornerRadius = 23.5;
    }
    return _sexImageView;
}

- (UIButton *)selectButton
{
    if (!_selectButton)
    {
        UIButton *iv = [[UIButton alloc] initWithFrame:CGRectMake(15, 29, 20, 20)];
        
        [iv setImage:ImageWithNameYF(@"deleteSignMem") forState:UIControlStateNormal];
        
        [iv addTarget:self action:@selector(deleteAction:) forControlEvents:UIControlEventTouchUpInside];
        
        _selectButton = iv;
    }
    return _selectButton;
}

- (void)deleteAction:(UIButton *)sender
{
    if (self.deletActionBlock)
    {
        self.deletActionBlock(self.weakModel);
    }
}


@end
