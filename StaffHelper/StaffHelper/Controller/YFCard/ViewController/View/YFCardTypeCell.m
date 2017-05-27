//
//  YFCardTypeCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardTypeCell.h"

#import "YFAppConfig.h"

@implementation YFCardTypeCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.nameLabel];
    }
    return self;
}


- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(16.0, 0.0, Width320(100) - 32, XFrom5To6YF(40))];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14.0);
    }
    return _nameLabel;
}




@end
