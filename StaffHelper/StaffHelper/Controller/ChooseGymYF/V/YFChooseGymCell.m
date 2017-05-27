//
//  YFChooseGymCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFChooseGymCell.h"

@implementation YFChooseGymCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.arrowImageView];
        [self.contentView addSubview:self.gotoDisLabel];
        
        _headImageView = [[UIImageView alloc]initWithFrame:CGRectMake(15, 15, 48, 48)];
        
        _headImageView.layer.cornerRadius = _headImageView.width/2;
        
        _headImageView.layer.masksToBounds = YES;
        
        _headImageView.layer.borderColor = [UIColorFromRGB(0x333333) colorWithAlphaComponent:0.12].CGColor;
        
        _headImageView.layer.borderWidth = 1;
        
        [self.contentView addSubview:_headImageView];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(78, 15, self.gotoDisLabel.left - 78.0 - 5, 21)];
        
        _titleLabel.textColor = YFCellTitleColor;
        
        _titleLabel.font = FontSizeFY(15.0);
        
        [self.contentView addSubview:_titleLabel];
        
        [self.contentView addSubview:self.detailLabel];
    }
    return self;
}

- (UILabel *)detailLabel
{
    if (!_detailLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(self.titleLabel.left, self.titleLabel.bottom + 3, self.titleLabel.width, 18)];
        
        label.font = FontCellTitleValueFY;
        
        label.textColor = YFCellSubGrayTitleColor;
        
        _detailLabel = label;
    }
    return _detailLabel;
}
-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - 22, 22, 7, 12)];
        _arrowImageView.image = [UIImage imageNamed:@"rightRedArrow"];
    }
    return _arrowImageView;
}

- (UILabel *)gotoDisLabel
{
    if (!_gotoDisLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(MSW - 96 - self.arrowImageView.width, 19, 81, 18)];
        
        label.font = FontCellTitleValueFY;
        
        label.textColor = RGB_YF(234, 97, 97);
        
        label.text = @"完善场馆信息";
        
        _gotoDisLabel = label;
    }
    return _gotoDisLabel;
}



@end
