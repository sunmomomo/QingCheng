//
//  YFStudentListCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentListCell.h"
#import "UIView+masonryExtesionYF.h"
#import "YFAppConfig.h"

@implementation YFStudentListCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sexImageView];
        [self.contentView addSubview:self.stateImageView];
        [self.contentView addSubview:self.stateLabel];
        [self.contentView addSubview:self.arrowImageView];
//
//        
        _headImageView.backgroundColor = YFMainBackColor;
//        _nameLabel.backgroundColor = YFMainBackColor;
//        _phoneLabel.backgroundColor = YFMainBackColor;
        self.arrowImageView.backgroundColor = YFMainBackColor;
        
        [self.sexImageView setSizeYF:CGSizeMake(14.0, 13.0)];
        [self.sexImageView setEqualCenterYOffset:0.0 toView:self.nameLabel];
        
        [self.sexImageView setLeftYF:7.0 toViewRight:self.nameLabel];
        
    }
    return self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
   
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19.0, 14, 47.5, 47.5)];
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
        _nameLabel.font = FontCellTitleFY;
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

-(UIImageView *)stateImageView
{
    if (_stateImageView == nil)
    {
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 86, self.nameLabel.top + self.nameLabel.height / 2.0 - 3, 7.5, 7.5)];
        
    }
    return _stateImageView;
}

-(UILabel *)stateLabel
{
    if (_stateLabel == nil)
    {
        _stateLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateImageView.right + 6, self.stateImageView.top + self.stateImageView.height /2 - 9, 47, 18)];
        _stateLabel.textColor = YFCellSubTitleColor;
        _stateLabel.font = FontSizeFY(12.0);
    }
    return _stateLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 26.5, 31.5, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}


@end
