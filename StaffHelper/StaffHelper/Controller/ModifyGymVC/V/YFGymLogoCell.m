//
//  YFGymLogoCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGymLogoCell.h"

#import "UILabel+cell.h"

#import "UIImageView+circle.h"

@implementation YFGymLogoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        
        
    }
    return self;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel =[UILabel cellTitleLabelWithFrame:CGRectMake(15, 31, 100, 21)];
    }
    return _nameLabel;
}


- (UIImageView *)headImageView
{
    if (!_headImageView)
    {
        _headImageView = [UIImageView circleBorderWithFrame:CGRectMake(MSW - 75, 12, 60, 60)];
    }
    return _headImageView;
}

@end
