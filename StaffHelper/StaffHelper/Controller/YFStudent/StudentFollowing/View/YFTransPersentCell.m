//
//  YFTransPersentCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFTransPersentCell.h"
#import "YFAppConfig.h"

@interface YFTransPersentCell ()


@end

@implementation YFTransPersentCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.headImageView];
        [self.headImageView addSubview:self.persertFirstLabel];
        [self.headImageView addSubview:self.persertFirstCountLabel];

        [self.headImageView addSubview:self.persertSecondLabel];
        [self.headImageView addSubview:self.persertSecondCountLabel];

        [self.headImageView addSubview:self.persertThirdLabel];
        [self.headImageView addSubview:self.persertThirdCountLabel];
    }
    return self;
}

- (UILabel *)nameLabel
{
    if (!_nameLabel)
    {
        CGFloat labelWidth = MSW;
        
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake((MSW - labelWidth) / 2.0, 17, labelWidth, 44)];
        _nameLabel.textAlignment = NSTextAlignmentCenter;
        _nameLabel.textColor = RGB_YF(136, 136, 136);
        _nameLabel.font = FontSizeFY(IPhone4_5_6_6PYF(13, 13, 14, 14));
    }
    return _nameLabel;
}

- (UIImageView *)headImageView
{
    if (_headImageView == nil)
    {
        _headImageView = [[UIImageView alloc] initWithFrame:CGRectMake(XFrom6YF(35.0), 74.0, XFrom6YF(303), XFrom6YF(230))];
        [_headImageView setImage:[UIImage imageNamed:@"transPersent"]];
    }
    return _headImageView;
}

- (UILabel *)persertFirstLabel
{
    if (!_persertFirstLabel)
    {
        
        _persertFirstLabel = [[UILabel alloc] initWithFrame:CGRectMake(0.0, XFrom6YF(61), XFrom6YF(50.0), XFrom6YF(14.0))];
        _persertFirstLabel.textAlignment = NSTextAlignmentCenter;
        _persertFirstLabel.textColor = RGB_YF(100, 181, 240);
        _persertFirstLabel.font = FontSizeFY(XFrom6YF(13.5));
    }
    return  _persertFirstLabel;
}

- (UILabel *)persertFirstCountLabel
{
    if (!_persertFirstCountLabel)
    {
        _persertFirstCountLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.headImageView.width -  XFrom6YF(150))/2.0 + 2, XFrom6YF(25), XFrom6YF(150), XFrom6YF(20.0))];
        _persertFirstCountLabel.textAlignment = NSTextAlignmentCenter;
        _persertFirstCountLabel.textColor = RGB_YF(100, 181, 240);
        _persertFirstCountLabel.font = FontSizeFY(XFrom6YF(15.0));
    }
    return  _persertFirstCountLabel;
}

- (UILabel *)persertSecondLabel
{
    if (!_persertSecondLabel) {
        _persertSecondLabel = [[UILabel alloc] initWithFrame:CGRectMake(XFrom6YF(15.0), XFrom6YF(155), XFrom6YF(50.0), XFrom6YF(14.0))];
        _persertSecondLabel.textAlignment = NSTextAlignmentCenter;
        _persertSecondLabel.textColor = RGB_YF(249, 137, 31);
        _persertSecondLabel.font = FontSizeFY(XFrom6YF(13.5));

    }
    return _persertSecondLabel;
}


- (UILabel *)persertSecondCountLabel
{
    if (!_persertSecondCountLabel) {
        _persertSecondCountLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.headImageView.width -  XFrom6YF(130))/2.0 + 2, XFrom6YF(103), XFrom6YF(130), XFrom6YF(20.0))];
        _persertSecondCountLabel.textAlignment = NSTextAlignmentCenter;
        _persertSecondCountLabel.textColor = RGB_YF(249, 137, 31);
        _persertSecondCountLabel.font = FontSizeFY(XFrom6YF(15.0));
    }
    return _persertSecondCountLabel;
}

- (UILabel *)persertThirdLabel
{
    if (!_persertThirdLabel) {
        _persertThirdLabel = [[UILabel alloc] initWithFrame:CGRectMake(XFrom6YF(258), XFrom6YF(110), XFrom6YF(50.0), XFrom6YF(14.0))];
        _persertThirdLabel.textAlignment = NSTextAlignmentCenter;
        _persertThirdLabel.textColor = RGB_YF(0, 173, 50);
        _persertThirdLabel.font = FontSizeFY(XFrom6YF(13.5));
    }
    return _persertThirdLabel;
}

- (UILabel *)persertThirdCountLabel
{
    if (!_persertThirdCountLabel) {
        _persertThirdCountLabel = [[UILabel alloc] initWithFrame:CGRectMake((self.headImageView.width -  XFrom6YF(100.0))/2.0 + 2, XFrom6YF(184), XFrom6YF(100), XFrom6YF(20.0))];
        _persertThirdCountLabel.textAlignment = NSTextAlignmentCenter;
        _persertThirdCountLabel.textColor = RGB_YF(0, 173, 50);
        _persertThirdCountLabel.font = FontSizeFY(XFrom6YF(15.0));
    }
    return _persertThirdCountLabel;
}

- (UIView *)lineTwoLevelView
{
    if (!_lineTwoLevelView)
    {
        _lineTwoLevelView = [[UIView alloc] initWithFrame:CGRectMake(MSW / 2.0 - 14.5, self.nameLabel.bottom + 7,29.0, 4.0)];
        
        _lineTwoLevelView.backgroundColor = YFLineViewColor;
    }
    return _lineTwoLevelView;
}

// 转化率 详情页
- (void)setTwoLevel
{
    self.headImageView.frame = CGRectMake(self.headImageView.mj_x, self.lineTwoLevelView.bottom + Width320(29), self.headImageView.width, self.headImageView.height);
    self.nameLabel.textColor = RGB_YF(34, 34, 34);
    [self.contentView addSubview:self.lineTwoLevelView];
}

@end
