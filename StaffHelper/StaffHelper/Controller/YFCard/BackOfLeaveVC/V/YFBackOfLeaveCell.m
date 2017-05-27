//
//  YFBackOfLeaveCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBackOfLeaveCell.h"

@implementation YFBackOfLeaveCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.originValidDateDesLabel];
        [self.contentView addSubview:self.originValidDateLabel];
        [self.contentView addSubview:self.backOfLeaveDateDesLabel];
        [self.contentView addSubview:self.backOfLeaveDateLabel];
    }
    return self;
}


- (UILabel *)desLabel
{
    if (!_desLabel)
    {
        _desLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Width320(16), MSW - Width320(16) * 2, Height320(17))];
        
        _desLabel.textColor = RGBCOLOR(51, 51, 51);
        
        _desLabel.font = FontScale320SizeFY(14);
    }
    return _desLabel;
}

- (UILabel *)originValidDateDesLabel
{
    if (!_originValidDateDesLabel)
    {
        _originValidDateDesLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.desLabel.bottom + Width320(12), MSW - Width320(16) * 2, Height320(17))];
        
        _originValidDateDesLabel.textColor = RGBCOLOR(153, 153, 153);
        
        _originValidDateDesLabel.font = FontScale320SizeFY(12);
    }
    return _originValidDateDesLabel;
}

- (UILabel *)originValidDateLabel
{
    if (!_originValidDateLabel)
    {
        _originValidDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.originValidDateDesLabel.bottom, MSW - Width320(16) * 2, Height320(18))];
        
        _originValidDateLabel.textColor = YFCellTitleColor;
        
        _originValidDateLabel.font = FontScale320SizeFY(14);
    }
    return _originValidDateLabel;
}

- (UILabel *)backOfLeaveDateDesLabel
{
    if (!_backOfLeaveDateDesLabel)
    {
        _backOfLeaveDateDesLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.originValidDateLabel.bottom + Width320(12), MSW - Width320(16) * 2, Height320(17))];
        
        _backOfLeaveDateDesLabel.textColor = RGBCOLOR(153, 153, 153);
        
        _backOfLeaveDateDesLabel.font = FontScale320SizeFY(12);
    }
    return _backOfLeaveDateDesLabel;
}


- (UILabel *)backOfLeaveDateLabel
{
    if (!_backOfLeaveDateLabel)
    {
        _backOfLeaveDateLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), self.backOfLeaveDateDesLabel.bottom, MSW - Width320(16) * 2, Height320(17))];
        
        _backOfLeaveDateLabel.textColor = YFCellTitleColor;
        
        _backOfLeaveDateLabel.font = FontScale320SizeFY(14);
    }
    return _backOfLeaveDateLabel;
}



@end
