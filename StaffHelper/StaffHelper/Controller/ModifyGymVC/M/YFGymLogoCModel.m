//
//  YFGymLogoCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGymLogoCModel.h"

#import "YFGymLogoCell.h"

static NSString *yFGymLogoCell = @"YFGymLogoCell";


@implementation YFGymLogoCModel

- (void)cellSettingYF
{
    self.cellHeight = 84;
    self.cellIdentifier = yFGymLogoCell;
    self.cellClass = [YFGymLogoCell class];
    self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFGymLogoCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.nameLabel.text = self.title;
    
    [baseCell.headImageView sd_setImageWithURL:self.imageUrl];
    
}

@end
