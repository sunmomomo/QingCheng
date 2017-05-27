//
//  YFDesTitleCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFDesTitleCModel.h"

#import "YFDesTitleCell.h"

#import "UILabel+AutoSize.h"

static NSString *yFDesTitleCell = @"YFDesTitleCell";


@implementation YFDesTitleCModel

- (void)cellSettingYF
{
    self.cellHeight = 80;
    self.cellIdentifier = yFDesTitleCell;
    self.cellClass = [YFDesTitleCell class];
    self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFDesTitleCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.desLabel.text = self.desStr;
    if (self.title)
    {
        baseCell.nameLabel.text = self.title;
        baseCell.nameLabel.textColor = YFCellTitleColor;
    }else
    {
        baseCell.nameLabel.text = self.emptyTitleStr;
        baseCell.nameLabel.textColor = baseCell.desLabel.textColor;
    }
    
    [baseCell.nameLabel autoHeightWithMaxSize:CGSizeMake(MSW - 30, 100000)];
    
    self.cellHeight = 60 + baseCell.nameLabel.height;
}

- (NSString *)emptyTitleStr
{
    if (!_emptyTitleStr) {
        _emptyTitleStr = @"未填写";
    }
    return _emptyTitleStr;
}

@end
