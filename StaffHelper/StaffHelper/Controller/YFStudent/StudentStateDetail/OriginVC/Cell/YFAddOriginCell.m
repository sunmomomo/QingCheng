//
//  YFAddOriginCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFAddOriginCell.h"
#import "YFAppConfig.h"

@implementation YFAddOriginCell


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.arrowImageView];
    }
    return self;
}




-(UIImageView *)arrowImageView
{
    if (_arrowImageView == nil)
    {
        _arrowImageView = [[UIImageView alloc] initWithFrame:CGRectMake( 18, (39.0 - XFrom6YF(12.0)) / 2.0, 83, 13.5)];
        _arrowImageView.image = [UIImage imageNamed:@"AddOriginYF"];
    }
    return _arrowImageView;
}


@end
