//
//  YFOutRandCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRandCell.h"

#import "YFAppConfig.h"

#import "UIView+masonryExtesionYF.h"


@implementation YFOutRandCell
{
    UIView *_lineView;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.headImageView];
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.phoneLabel];
        
        [self.contentView addSubview:self.sexImageView];
        
        _headImageView.backgroundColor = YFMainBackColor;
        
        [self.sexImageView setSizeYF:CGSizeMake(14.0, 13.0)];
        [self.sexImageView setEqualCenterYOffset:0.0 toView:self.nameLabel];
        
        [self.sexImageView setLeftYF:7.0 toViewRight:self.nameLabel];
        
        [self.contentView addSubview:self.rightView];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(Width320(209), Width320(18), OnePX, Width320(28))];
        _lineView = lineView;
        lineView.backgroundColor = YFGrayViewColor;
        [self.contentView addSubview:lineView];
        
        [self.contentView addSubview:self.firstView];
        [self.contentView addSubview:self.secondView];
        [self.contentView addSubview:self.thirdView];
        
    }
    return self;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:YFRectMake(56, 12, 40, 40)];
        _headImageView.clipsToBounds = YES;
        _headImageView.layer.cornerRadius = _headImageView.width / 2.0;
    }
    return _headImageView;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:YFRectMake(111, 15, 50, 20)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(XFrom5YF(14));
    }
    return _nameLabel;
}

-(UILabel *)phoneLabel
{
    if (_phoneLabel == nil)
    {
        _phoneLabel = [[UILabel alloc] initWithFrame:YFRectMake(111, 35, 120, 15.5)];
        _phoneLabel.textColor = YFCellSubTitleColor;
        _phoneLabel.font = FontSizeFY(XFrom5YF(12.0));
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

- (YFThreeLabel *)rightView
{
    if (_rightView == nil) {
        _rightView = [[YFThreeLabel alloc] initWithFrame:YFRectMake(7, 15, 50, 30)];
        [_rightView setBigStyle];
        [_rightView setBigTextColor];
    }
    return _rightView;
}


- (YFThreeLabel *)firstView
{
    if (_firstView == nil) {
        _firstView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(_lineView.left + 10, Width320(15), Width320(32), Width320(30))];
        [_firstView setSmallStyle];
        
        _firstView.rightTopLabel.text = @"次";
        _firstView.desDownLabel.text = @"签到";
    }
    return _firstView;
}
- (YFThreeLabel *)secondView
{
    if (_secondView == nil) {
        _secondView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(self.firstView.right, Width320(15), Width320(32), Width320(30))];
        [_secondView setSmallStyle];
        _secondView.rightTopLabel.text = @"节";
        _secondView.desDownLabel.text = @"团课";
    }
    return _secondView;
}

- (YFThreeLabel *)thirdView
{
    if (_thirdView == nil) {
        _thirdView = [[YFThreeLabel alloc] initWithFrame:CGRectMake(self.secondView.right, Width320(15), Width320(32), Width320(30))];
        [_thirdView setSmallStyle];
        _thirdView.rightTopLabel.text = @"节";
        _thirdView.desDownLabel.text = @"私教";
        
    }
    return _thirdView;
}

@end
