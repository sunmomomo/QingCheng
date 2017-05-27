//
//  YFAutomicRemindCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAutomicRemindCell.h"

#import "YFAppConfig.h"

@implementation YFAutomicRemindCell
{
    CGFloat _xxGap;
    CGFloat _cellHeight;
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _xxGap = IPhone4_5_6_6P(10, 10, 16, 16);
        _cellHeight = IPhone4_5_6_6P(66, 66, XFrom5To6YF(66), XFrom5To6YF(66));
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.valueLabel];

    }
    return self;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(_xxGap, IPhone4_5_6_6P(18, 18, XFrom5To6YF(18.0), XFrom5To6YF(18.0)), Width320(150), XFrom5To6YF(15))];
        _nameLabel.textColor = YFCellTitleColor;
    
        _nameLabel.font = FontSizeFY(XFrom5To6YF(14));
    }
    return _nameLabel;
}
- (UILabel *)desLabel
{
    if (_desLabel == nil)
    {
        _desLabel = [[UILabel alloc] initWithFrame:CGRectMake(_xxGap, self.nameLabel.bottom + 4, MSW - 2 - self.valueLabel.width - _xxGap, XFrom5To6YF(15))];
        _desLabel.textColor = RGB_YF(153, 153, 153);
        
        _desLabel.font = FontSizeFY(IPhone4_5_6_6P(12, 12, XFrom5To6YF(12), XFrom5To6YF(12)));
    }
    return _desLabel;
}

- (UILabel *)valueLabel
{
    if (_valueLabel == nil)
    {
        CGFloat width = IPhone4_5_6_6P(58, 58, 70, 70);
        _valueLabel = [[UILabel alloc] initWithFrame:CGRectMake(MSW - XFrom5To6YF(width) - _xxGap, 0, XFrom5To6YF(width), _cellHeight)];
        _valueLabel.textColor = RGB_YF(13, 177, 75);
        _valueLabel.font = FontSizeFY(IPhone4_5_6_6P(13, 13, 14, 14));
        _valueLabel.textAlignment = NSTextAlignmentRight;
    }
    return _valueLabel;
}

@end
