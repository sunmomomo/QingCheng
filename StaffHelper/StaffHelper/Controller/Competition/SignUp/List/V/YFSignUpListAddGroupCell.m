//
//  YFSignUpListAddGroupCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddGroupCell.h"

@implementation YFSignUpListAddGroupCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.addImageView];
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


- (UIImageView *)addImageView
{
    if (!_addImageView)
    {
        _addImageView = [[UIImageView alloc] initWithFrame:CGRectMake(15, 16, 18, 18)];
        _addImageView.image = [UIImage imageNamed:@"AddSmsPeo"];
    }
    return _addImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(41, 0, 100, 50)];
        _nameLabel.textColor = YFThreeChartDeColor;
        _nameLabel.font = FontSizeFY(15.0);
        _nameLabel.text =@"新建分组";
    }
    return _nameLabel;
}


@end
