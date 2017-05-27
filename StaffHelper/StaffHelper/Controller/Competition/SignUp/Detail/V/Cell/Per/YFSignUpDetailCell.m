//
//  YFSignUpDetailCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpDetailCell.h"

@interface YFSignUpDetailCell ()

@property(nonatomic, strong)UILabel *desLabel;

@property(nonatomic, strong)UILabel *desGroupLabel;


@end

@implementation YFSignUpDetailCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.signUpTimeLabel];
        [self.contentView addSubview:self.signUpPayLabel];
        [self.contentView addSubview:self.desGroupLabel];
        [self.contentView addSubview:self.signUpTagView];
        
    }
    return self;
}





- (UILabel *)desLabel
{
    if (!_desLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, 14, MSW - 30 , 22)];

        label.textColor = YFCellTitleColor;
        
        label.font = BoldFontSizeFY(16.0);
        
        label.text = @"报名信息";
        
        _desLabel = label;
    }
    return _desLabel;
}


-(UILabel *)signUpTimeLabel
{
    if (_signUpTimeLabel == nil)
    {
        _signUpTimeLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, self.desLabel.bottom + 8, MSW - 30 , 21)];
        _signUpTimeLabel.textColor = YFCellSubGrayTitleColor;
        _signUpTimeLabel.font = FontDetailTitleFY;
    }
    return _signUpTimeLabel;
}

-(UILabel *)signUpPayLabel
{
    if (_signUpPayLabel == nil)
    {
        _signUpPayLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.signUpTimeLabel.left, self.signUpTimeLabel.bottom + 8, self.signUpTimeLabel.width , 21)];
        _signUpPayLabel.textColor = YFCellSubGrayTitleColor;
        _signUpPayLabel.font = FontDetailTitleFY;
    }
    return _signUpPayLabel;
}


- (UILabel *)desGroupLabel
{
    if (!_desGroupLabel)
    {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(15, self.signUpPayLabel.bottom + 8, 75, 22)];
        
        label.textColor = YFCellSubGrayTitleColor;
        
        label.font = FontDetailTitleFY;
        
        label.text = @"所在分组:";
        
        _desGroupLabel = label;
    }
    return _desGroupLabel;
}


- (YFSignUpTagView *)signUpTagView
{
    if (!_signUpTagView)
    {
        _signUpTagView = [[YFSignUpTagView alloc] initWithFrame:CGRectMake(self.desGroupLabel.right, self.desGroupLabel.top - 6, MSW - self.desGroupLabel.right - 15, 0)];
        _signUpTagView.colorTagNomalBg = [UIColor whiteColor];
        _signUpTagView.fontTag = FontSizeFY(12);
        _signUpTagView.colorTextTag = YFCellSubGrayTitleColor;
        _signUpTagView.tagHeight = 24.0;
        _signUpTagView.beginxx = 0;
    }
    return _signUpTagView;
}


@end
