//
//  YFLastestTimeCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFLastestTimeCell.h"
#import "YFAppConfig.h"

@implementation YFLastestTimeCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}

- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, self.arrowImageView.left - 10, 46)];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14);
    }
    return _nameLabel;
}


-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW - XFrom6YF(14.0) - 17, 18.5, 12, 9)];
        _arrowImageView.image = [UIImage imageNamed:@"FillSelected"];
    }
    return _arrowImageView;
}



@end
