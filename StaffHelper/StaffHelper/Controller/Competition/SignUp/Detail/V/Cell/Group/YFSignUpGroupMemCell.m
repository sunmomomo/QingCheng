//
//  YFSignUpGroupMemCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupMemCell.h"
#import "UIView+masonryExtesionYF.h"

@implementation YFSignUpGroupMemCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sexImageView];
        //
        //
        _headImageView.backgroundColor = YFMainBackColor;
        //        _nameLabel.backgroundColor = YFMainBackColor;
        //        _phoneLabel.backgroundColor = YFMainBackColor;
        
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
        _headImageView.layer.cornerRadius = 23.5;
        
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, 18.0, 50, 20)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontDetailTitleFY;
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 5.5, 120, 15.5)];
        _phoneLabel.textColor = YFCellSubGrayTitleColor;
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

@end
