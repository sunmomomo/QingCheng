//
//  YFGrayTitleExCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGrayTitleExCell.h"

#import "UIView+masonryExtesionYF.h"


@implementation YFGrayTitleExCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        
        self.contentView.backgroundColor = YFGrayViewColor;
        self.backgroundColor = YFGrayViewColor;
    }
    return self;
}
- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] init];
        
        _nameLabel.textColor = RGB_YF(151, 151, 151);
        _nameLabel.font = AllFont(12);
    }
    return _nameLabel;
}

@end
