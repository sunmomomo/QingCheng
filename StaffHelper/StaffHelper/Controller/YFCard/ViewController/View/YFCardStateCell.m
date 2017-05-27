//
//  YFCardStateCell.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardStateCell.h"

#import "YFAppConfig.h"

@implementation YFCardStateCell


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
        _nameLabel = [[UILabel alloc] initWithFrame:CGRectMake(15.0, 0.0, self.arrowImageView.left - 5 - 15.0, XFrom5To6YF(40))];
        _nameLabel.textColor = YFCellTitleColor;
        _nameLabel.font = FontSizeFY(14.0);
    }
    return _nameLabel;
}

-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake(MSW  - XFrom6YF(14.0) - 12, (XFrom5To6YF(40) - 9) / 2.0, 12, 9)];
        _arrowImageView.image = [UIImage imageNamed:@"FillSelected"];
    }
    return _arrowImageView;
}



@end
