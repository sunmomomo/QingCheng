//
//  YFStudentTodayTrendDesCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentTodayTrendDesCell.h"
#import "YFAppConfig.h"


@implementation YFStudentTodayTrendDesCell


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
        _stateImageView = [[UIImageView alloc] initWithFrame:CGRectMake(18.0, 28.0 - XFrom5To6YF(14.0) / 2.0, XFrom5To6YF(16.0), XFrom5To6YF(14.0))];
        _stateImageView.image = [UIImage imageNamed:@"dataCyltic"];
        
    }
    return _stateImageView;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.stateImageView.right + 10, 0, 160, 56.0)];
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

- (YFButton *)button
{
    if (!_button) {
        
        CGFloat buttonWidth = XFrom5To6YF(60.0);;
        CGFloat cellHeith = 46;
        
        
        CGFloat   labelWidth = XFrom5To6YF(49.0);
        CGFloat   labelHeight = cellHeith;
        
        CGFloat   imageWidth = XFrom5To6YF(11.0);
        CGFloat   imageHeight = XFrom5To6YF(7.0);
        
        CGFloat    labelx = (buttonWidth - labelWidth - imageWidth)/ 2.0;
        CGFloat   labely = 0;
        
        CGFloat   imagex = (buttonWidth - labelWidth - imageWidth)/ 2.0 + labelWidth;
        CGFloat   imagey = (cellHeith - imageHeight)/ 2.0;
        
        
        YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(MSW - buttonWidth - 18.0, 0, buttonWidth, cellHeith) imageFrame:CGRectMake(imagex, imagey, imageWidth, imageHeight) titleFrame:CGRectMake(labelx, labely, labelWidth, labelHeight)];
        button.titleLabel.textAlignment = NSTextAlignmentRight;
        [button setTitle:@"最近7天" forState:UIControlStateNormal];

        [button setImage:[UIImage imageNamed:@"AllDownArrow"] forState:UIControlStateNormal];

        
        [button.titleLabel setFont:FontSizeFY(13.0)];
        
        [button setTitleColor:YFCellSubTitleColor forState:UIControlStateNormal];
        
        _button = button;
    }
    return _button;
}

@end
