//
//  YFAbsenceStaticCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAbsenceStaticCell.h"

#import "UIView+masonryExtesionYF.h"


@implementation YFAbsenceStaticCell


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
        
        [self.contentView addSubview:self.phoneButton];
        [self.contentView addSubview:self.grayView];
        
        [self.grayView addSubview:self.grayFirstLabel];
        [self.grayView addSubview:self.grayFirstTimeLabel];
        [self.grayView addSubview:self.graySecondLabel];
        [self.grayView addSubview:self.grayThreeabel];
        [self.grayView addSubview:self.grayFirstTimeUinitLabel];
        [self.grayView addSubview:self.grayDaysLabel];
        
    }
    return self;
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
        _phoneLabel.font = FontSizeFY(XFrom5To6YF(12.0));
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


- (UIButton *)phoneButton
{
    if (!_phoneButton)
    {
        _phoneButton = [UIButton buttonWithType:UIButtonTypeCustom];
        
        _phoneButton.frame = CGRectMake(MSW - 16 - 65, self.nameLabel.top + 3.0, 65, 23);
        
        _phoneButton.layer.cornerRadius = 2.0;
        _phoneButton.layer.borderColor = RGB_YF(27, 27, 27).CGColor;
        _phoneButton.layer.borderWidth = 0.5;
        [_phoneButton setTitleColor:RGB_YF(40, 40, 40) forState:UIControlStateNormal];
        
        [_phoneButton setTitle:@"联系TA" forState:UIControlStateNormal];
        [_phoneButton.titleLabel setFont:FontSizeFY(XFrom5To6YF(12.0))];
        
        [_phoneButton addTarget:self action:@selector(phoneAction:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _phoneButton;
}

- (UIView *)grayView
{
    if (!_grayView)
    {
        _grayView = [[UIView alloc] initWithFrame:CGRectMake(self.nameLabel.left, self.phoneLabel.bottom + 10, MSW - self.nameLabel.left + 4, 79.0f)];
        _grayView.backgroundColor = RGB_YF(244, 244, 244);
        _grayView.layer.cornerRadius = 4.0f;
    }
    return _grayView;
}

- (UILabel *)grayFirstLabel
{
    if (!_grayFirstLabel)
    {
        _grayFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, 6, 70, 20)];
        _grayFirstLabel.font = FontSizeFY(XFrom5To6YF(10));
        _grayFirstLabel.textColor = RGB_YF(153, 153, 153);
    }
    return _grayFirstLabel;
}

- (UILabel *)grayFirstTimeLabel
{
    if (_grayFirstTimeLabel == nil)
    {
        _grayFirstTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.grayView.width - 50 - 20, 6, 50, 20)];
        _grayFirstTimeLabel.font = FontSizeFY(XFrom5To6YF(10));
        _grayFirstTimeLabel.textColor = RGB_YF(153, 153, 153);
        _grayFirstTimeLabel.text = @"缺勤时长";
        _grayFirstTimeLabel.textAlignment = NSTextAlignmentRight;
    }

    return _grayFirstTimeLabel;
}

- (UILabel *)grayFirstTimeUinitLabel
{
    if (_grayFirstTimeUinitLabel == nil)
    {
        _grayFirstTimeUinitLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.grayView.width - 17 - 20, self.graySecondLabel.top, 15, self.graySecondLabel.height)];
        _grayFirstTimeUinitLabel.font = FontSizeFY(XFrom5To6YF(12));
        _grayFirstTimeUinitLabel.textColor = RGB_YF(102, 102, 102);
        _grayFirstTimeUinitLabel.text = @"天";
        _grayFirstTimeUinitLabel.textAlignment = NSTextAlignmentRight;
    }
    
    return _grayFirstTimeUinitLabel;
}

- (UILabel *)grayDaysLabel
{
    if (_grayDaysLabel == nil)
    {
        _grayDaysLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.grayView.width - 70 - 18 - 20, self.grayFirstLabel.bottom, 70, 25)];
        _grayDaysLabel.font = FontSizeFY(XFrom5To6YF(18));
        _grayDaysLabel.textColor = RGB_YF(102, 102, 102);
        _grayDaysLabel.text = @"天";
        _grayDaysLabel.textAlignment = NSTextAlignmentRight;
//        _grayDaysLabel.backgroundColor = [UIColor redColor];
    }
    
    return _grayDaysLabel;
}

- (UILabel *)graySecondLabel
{
    if (!_graySecondLabel)
    {
        _graySecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, self.grayFirstLabel.bottom + 3, self.grayDaysLabel.left - 8, 20)];
        
        [self setGrayLabelSet:_graySecondLabel];
    }
    return _graySecondLabel;
}

- (UILabel *)grayThreeabel
{
    if (!_grayThreeabel)
    {
        _grayThreeabel = [[UILabel alloc] initWithFrame:CGRectMake(7.5, self.graySecondLabel.bottom + 1, self.graySecondLabel.width, 20)];
        [self setGrayLabelSet:_grayThreeabel];
    }
    return _grayThreeabel;
}


- (void)setGrayLabelSet:(UILabel *)label
{
    label.textColor = RGB_YF(102, 102, 102);
    label.font = FontSizeFY(XFrom5To6YF(12.0));
    label.backgroundColor = [UIColor clearColor];
    
}

- (void)phoneAction:(UIButton *)button
{
    if (self.phoneActionBlock)
    {
        self.phoneActionBlock();
    }
}


@end
