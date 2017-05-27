//
//  YFGrayTitleCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFGrayTitleCell.h"
#import "YFAppConfig.h"
#import "UIView+masonryExtesionYF.h"

@implementation YFGrayTitleCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        
        [_nameLabel setxYF:18];
        [_nameLabel setyYF:0];
        [_nameLabel setWidthYF:200];
        [_nameLabel setBottomYF:0.0];
        
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
        _nameLabel.font = [UIFont systemFontOfSize:13];
    }
    return _nameLabel;
}

@end
