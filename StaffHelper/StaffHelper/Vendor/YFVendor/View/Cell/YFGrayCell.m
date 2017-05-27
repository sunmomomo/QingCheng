//
//  YFGrayCell.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFGrayCell.h"
#import "YFAppConfig.h"

@implementation YFGrayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor = YFGrayViewColor;
        self.backgroundColor = YFGrayViewColor;

    }
    return self;
}



@end
