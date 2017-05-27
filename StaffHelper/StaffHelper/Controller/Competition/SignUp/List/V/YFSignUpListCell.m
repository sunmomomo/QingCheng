//
//  YFSignUpListCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/24.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListCell.h"
#import "UIView+masonryExtesionYF.h"


@implementation YFSignUpListCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sexImageView];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.signUpTimeLabel];
        [self.contentView addSubview:self.signUpPayLabel];
        [self.contentView addSubview:self.signUpTagView];

        
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
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 15, 48, 48)];
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
        _nameLabel.font = FontDetailTitleFY;
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

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 22, 20, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}


-(UILabel *)signUpTimeLabel
{
    if (_signUpTimeLabel == nil)
    {
        _signUpTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.phoneLabel.bottom + 3, self.phoneLabel.width , 18)];
        _signUpTimeLabel.textColor = RGB_YF(136, 136, 136);
        _signUpTimeLabel.font = FontCellTitleValueFY;
    }
    return _signUpTimeLabel;
}

-(UILabel *)signUpPayLabel
{
    if (_signUpPayLabel == nil)
    {
        _signUpPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.signUpTimeLabel.bottom + 3, self.phoneLabel.width , 18)];
        _signUpPayLabel.textColor = RGB_YF(136, 136, 136);
        _signUpPayLabel.font = FontCellTitleValueFY;
    }
    return _signUpPayLabel;
}


- (YFSignUpTagView *)signUpTagView
{
    if (!_signUpTagView)
    {
        _signUpTagView = [[YFSignUpTagView alloc] initWithFrame:CGRectMake(self.nameLabel.left - 5, self.signUpPayLabel.bottom + 3, self.signUpPayLabel.width, 0)];
        _signUpTagView.colorTagNomalBg = [UIColor whiteColor];
        _signUpTagView.fontTag = FontSizeFY(12);
        _signUpTagView.colorTextTag = YFCellSubGrayTitleColor;
        _signUpTagView.tagHeight = 24.0;
        _signUpTagView.beginxx = 0;
        _signUpTagView.userInteractionEnabled = NO;
    }
    return _signUpTagView;
}



@end
