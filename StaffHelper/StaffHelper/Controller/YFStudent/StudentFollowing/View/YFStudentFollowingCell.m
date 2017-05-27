//
//  YFStudentFollowingCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFollowingCell.h"
#import "YFAppConfig.h"

@implementation YFStudentFollowingCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.stateImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.valueLabel];
    }
    return self;
}




-(UIImageView *)stateImageView
{
    if (_stateImageView == nil)
    {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18.0, 28.0 - 3, 7.5, 7.5)];
        
    }
    return _stateImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateImageView.right + 10, 0, 100, 56.0)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontCellTitleFY;
    }
    return _nameLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 26.5, 22.0, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

-(UILabel *)valueLabel
{
    if (_valueLabel == nil)
    {
        CGFloat width = 100;
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.arrowImageView.left - 6 - width, 0, width, 56)];
        _valueLabel.textColor = YFCellSubTitleColor;
        _valueLabel.font = FontSizeFY(13.0);
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}


@end
