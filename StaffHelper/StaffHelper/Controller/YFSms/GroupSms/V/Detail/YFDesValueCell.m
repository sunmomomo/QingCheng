//
//  YFDesValueCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesValueCell.h"

@implementation YFDesValueCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameDesLabel];
        
        [self.contentView addSubview:self.nameAllLabel];//
    }
    return self;
}

- (UILabel *)nameDesLabel
{
    if (_nameDesLabel == nil)
    {
        _nameDesLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 15.0, 70, 20)];
        _nameDesLabel.textColor = RGB_YF(187, 187, 187);
        _nameDesLabel.font = FontSizeFY(15.0);
    }
    return _nameDesLabel;
}



- (UILabel *)nameAllLabel
{
    if (_nameAllLabel == nil)
    {
        _nameAllLabel = [[UILabel alloc] initWithFrame:CGRectMake(self.nameDesLabel.right + 2, 16.0, MSW - self.nameDesLabel.right - 15.0, 20)];
        _nameAllLabel.textColor = YFCellTitleColor;
        _nameAllLabel.font = FontSizeFY(15.0);
    }
    return _nameAllLabel;
}


@end
