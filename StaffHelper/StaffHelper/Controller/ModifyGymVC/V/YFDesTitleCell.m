//
//  YFDesTitleCell.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesTitleCell.h"

#import "UILabel+cell.h"


@implementation YFDesTitleCell



- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.desLabel];
        [self.contentView addSubview:self.nameLabel];
        
        
    }
    return self;
}


- (UILabel *)desLabel
{
    if (_desLabel == nil)
    {
        _desLabel =[UILabel cellDesLabelWithFrame:CGRectMake(15, 15, 100, 18)];
    }
    return _desLabel;
}



- (UILabel *)nameLabel
{
    if (_nameLabel == nil)
    {
        _nameLabel =[UILabel cellTitleLabelWithFrame:CGRectMake(15, 38, MSW - 30, 21)];
    }
    return _nameLabel;
}

@end
