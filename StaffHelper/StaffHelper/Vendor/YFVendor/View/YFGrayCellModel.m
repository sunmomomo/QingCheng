//
//  YFGrayCellModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFGrayCellModel.h"
#import "YFGrayCell.h"
#import "YFAppConfig.h"
#import "YFGrayTitleCell.h"

static NSString *yFGrayCell = @"YFGrayCell";

static NSString *yfGrayTitleCell = @"YFGrayTitleCell";


@implementation YFGrayCellModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFGrayCell;
        self.cellClass = [YFGrayCell class];
        self.cellHeight = XFrom6YF(327.0f - 74) + 74;
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
    if (self.backGroungColor) {
        baseCell.contentView.backgroundColor = self.backGroungColor;
        baseCell.backgroundColor = self.backGroungColor;
    }
}

+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight
{
    YFGrayCellModel *model = [[YFGrayCellModel alloc] initWithDictionary:nil];
    model.cellHeight = cellHeight;
    return model;
}

+ (instancetype)defaultWithCellHeght:(CGFloat )cellHeight title:(NSString *)title
{
    YFGrayCellModel *model = [[YFGrayCellModel alloc] initWithDictionary:nil];
    model.cellHeight = cellHeight;
    model.cellIdentifier = yfGrayTitleCell;
    model.cellClass = [YFGrayTitleCell class];
    model.title = title;
    return model;
}


- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    if ([baseCell isKindOfClass:[YFGrayTitleCell class]])
    {
        YFGrayTitleCell *cell = (YFGrayTitleCell*)baseCell;
        
        cell.nameLabel.text = self.title;
    }
}

@end
