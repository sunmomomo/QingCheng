//
//  YFStudentTransCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTransCell.h"

#import "UIView+masonryExtesionYF.h"
#import "YFAppConfig.h"

@implementation YFStudentTransCell


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
        
        [self.contentView addSubview:self.grayView];
        
        [self.grayView addSubview:self.grayFirstLabel];
        [self.grayView addSubview:self.graySecondLabel];
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
        _phoneLabel.font = FontSizeFY(12);
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
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 26.5, self.stateImageView.center.y - 6, 7.5, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"cellarrow"];
    }
    return _arrowImageView;
}

- (UIView *)grayView
{
    if (!_grayView)
    {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.phoneLabel.bottom + 16, MSW - self.nameLabel.left + 4, 74.0f)];
        _grayView.backgroundColor = RGB_YF(244, 244, 244);
        _grayView.layer.cornerRadius = 4.0f;
        }
    return _grayView;
}

- (UILabel *)grayFirstLabel
{
    if (!_grayFirstLabel)
    {
        _grayFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, 6, self.arrowImageView.right - self.grayView.left - 7.5, 20)];
        [self setGrayLabelSet:_grayFirstLabel];
    }
    return _grayFirstLabel;
}

- (UILabel *)graySecondLabel
{
    if (!_graySecondLabel)
    {
        _graySecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, self.grayFirstLabel.bottom, self.grayFirstLabel.width, 20)];
        [self setGrayLabelSet:_graySecondLabel];
    }
    return _graySecondLabel;
}


- (void)setGrayLabelSet:(UILabel *)label
{
    label.textColor = RGB_YF(66, 66, 66);
    label.font = FontSizeFY(12.0);
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
}

@end
