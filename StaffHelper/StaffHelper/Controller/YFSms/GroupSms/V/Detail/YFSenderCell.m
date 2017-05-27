//
//  YFSenderCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSenderCell.h"

@implementation YFSenderCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameDesLabel];
        
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        //
    }
    return self;
}


- (UILabel *)nameDesLabel
{
    if (_nameDesLabel == nil)
    {
        _nameDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 60, 68)];
        _nameDesLabel.textColor = RGB_YF(187, 187, 187);
        _nameDesLabel.font = FontSizeFY(15.0);
        _nameDesLabel.text  = @"发件人";
    }
    return _nameDesLabel;
}


- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(94, 10, 48, 48)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = 23.5;
        
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, 17.0, 50, 20)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(15.0);
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 5.5, 120, 15.5)];
        _phoneLabel.textColor = YFCellSubTitleColor;
        _phoneLabel.font = FontCellSubTitleFY;
    }
    return _phoneLabel;
}


@end
