//
//  YFStudentFilterRePeoCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFilterRePeoCell.h"
#import "YFAppConfig.h"
#import "UIView+masonryExtesionYF.h"

@implementation YFStudentFilterRePeoCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.nameReDesLabel];
        [self.contentView addSubview:self.arrowImageView];
        //
        //
        _headImageView.backgroundColor = YFMainBackColor;
//        _nameLabel.backgroundColor = YFMainBackColor;
        //        _phoneLabel.backgroundColor = YFMainBackColor;
//        self.arrowImageView.backgroundColor = YFMainBackColor;
//        
        [self.nameReDesLabel setSizeYF:CGSizeMake(100.0, 13.0)];
        [self.nameReDesLabel setEqualCenterYOffset:0.0 toView:self.nameLabel];
        
        [self.nameReDesLabel setLeftYF:7.0 toViewRight:self.nameLabel];
        
        [self.contentView addSubview:self.allNameLabel];
    }
    return self;
}




- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(33.0, 14.5, 38, 38)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = 19.0;
        
    }
    return _headImageView;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, 17.0, 50, 20)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14.0);
    }
    return _nameLabel;
}

-(UILabel *)allNameLabel
{
    if (_allNameLabel == nil)
    {
        _allNameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.headImageView.right + 15, self.headImageView.center.y - 10, 50, 20)];
        _allNameLabel.textColor = YFCellTitleColor;
        _allNameLabel.font = FontSizeFY(15.0);
    }
    return _allNameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.nameLabel.bottom + 2, 120, 15)];
        _phoneLabel.textColor = YFCellSubTitleColor;
        _phoneLabel.font = FontCellSubTitleFY;
    }
    return _phoneLabel;
}

-(UILabel *)nameReDesLabel
{
    if (_nameReDesLabel == nil)
    {
        _nameReDesLabel = [[UILabel alloc] init];
        _nameReDesLabel.font = FontSizeFY(12.5);
        _nameReDesLabel.textColor = RGB_YF(145, 145, 145);
    }
    return _nameReDesLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW * StudentRightShowScale - XFrom6YF(14.0) - 12, 27.5, 12, 9)];
        _arrowImageView.image = [UIImage imageNamed:@"FillSelected"];
    }
    return _arrowImageView;
}


@end
