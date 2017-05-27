//
//  YFStudentStateCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentStateCell.h"
#import "UIView+masonryExtesionYF.h"
#import "YFAppConfig.h"

@implementation YFStudentStateCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        [self.contentView addSubview:self.sellersLabel];
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
        
        [self.contentView addSubview:self.phoneButton];
        [self.contentView addSubview:self.grayView];
        
        [self.grayView addSubview:self.grayFirstLabel];
        [self.grayView addSubview:self.graySecondLabel];
        [self.grayView addSubview:self.grayThreeabel];

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
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(19.0, 14, 48, 48)];
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

- (UILabel *)sellersLabel
{
    if (_sellersLabel == nil)
    {
        _sellersLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.phoneLabel.bottom + 5.5, MSW -  self.phoneButton.width - 16 - self.nameLabel.left - 5.5, 15.5)];
        _sellersLabel.textColor = YFCellSubTitleColor;
        _sellersLabel.font = FontSizeFY(12);
    }
    return _sellersLabel;
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

- (UIButton *)phoneButton
{
    if (!_phoneButton)
    {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _phoneButton.frame = CGRectMake(MSW - 16 - 65, self.stateLabel.bottom + 16.0, 65, 23);
        
        _phoneButton.layer.cornerRadius = 2.0;
        _phoneButton.layer.borderColor = RGB_YF(27, 27, 27).CGColor;
        _phoneButton.layer.borderWidth = 0.5;
        [_phoneButton setTitleColor:RGB_YF(40, 40, 40) forState:UIControlStateNormal];
        
        [_phoneButton setTitle:@"联系TA" forState:UIControlStateNormal];
        [_phoneButton.titleLabel setFont:FontSizeFY(13.0)];
        
        [_phoneButton addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _phoneButton;
}

- (UIView *)grayView
{
    if (!_grayView)
    {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.phoneButton.bottom + 16, MSW - self.nameLabel.left + 4, 74.0f)];
        _grayView.backgroundColor = RGB_YF(244, 244, 244);
        _grayView.layer.cornerRadius = 4.0f;
    }
    return _grayView;
}

- (UILabel *)grayFirstLabel
{
    if (!_grayFirstLabel)
    {
        
        _grayFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, 6, YFMaxSize.width, 20)];
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

- (UILabel *)grayThreeabel
{
    if (!_grayThreeabel)
    {
        _grayThreeabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, self.graySecondLabel.bottom, self.graySecondLabel.width, 20)];
        [self setGrayLabelSet:_grayThreeabel];
    }
    return _grayThreeabel;
}


- (void)setGrayLabelSet:(UILabel *)label
{
    label.textColor = RGB_YF(66, 66, 66);
    label.font = YFGRAYLabelFont;
    label.backgroundColor = [UIColor clearColor];
    label.numberOfLines = 0;
}

- (void)phoneAction:(UIButton *)button
{
    if (self.phoneActionBlock)
    {
        self.phoneActionBlock();
    }
}

@end
