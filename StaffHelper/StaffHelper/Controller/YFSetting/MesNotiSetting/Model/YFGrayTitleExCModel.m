//
//  YFGrayTitleExCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGrayTitleExCModel.h"

#import "YFGrayTitleExCell.h"

#import "UIView+masonryExtesionYF.h"


static NSString *yFGrayTitleExCell = @"YFGrayTitleExCell";

@implementation YFGrayTitleExCModel


- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    YFGrayTitleExCell *cell = (YFGrayTitleExCell *)baseCell;
    cell.nameLabel.numberOfLines = 0;
    [cell.nameLabel setxYF:15];
    [cell.nameLabel setyYF:0];
    [cell.nameLabel setTrailingYF:-15.0];
    [cell.nameLabel setBottomYF:-10.0];
    
    [cell.nameLabel layoutIfNeeded];
    
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.backGroungColor) {
        baseCell.contentView.backgroundColor = self.backGroungColor;
        baseCell.backgroundColor = self.backGroungColor;
    }
}



- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if ([baseCell isKindOfClass:[YFGrayTitleExCell class]])
    {
        YFGrayTitleExCell *cell = (YFGrayTitleExCell*)baseCell;
        
        cell.nameLabel.text = self.title;
    }
}


+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight title:(NSString *)title
{
    YFGrayTitleExCModel *model = [[YFGrayTitleExCModel alloc] initWithDictionary:nil];
    model.cellHeight = cellHeight;
    model.cellIdentifier = yFGrayTitleExCell;
    model.cellClass = [YFGrayTitleExCell class];
    model.title = title;
    return model;
}

@end
