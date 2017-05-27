//
//  YFCardTypeModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardTypeModel.h"

#import "YFCardTypeCell.h"

#import "YFCardKindVC.h"

static NSString *yFCardTypeCell = @"YFCardTypeCell";

@implementation YFCardTypeModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFCardTypeCell;
        self.cellClass = [YFCardTypeCell class];
        self.cellHeight = XFrom5To6YF(40);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}


- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFCardTypeCell *cell = (YFCardTypeCell *)self.weakCell;

    cell.nameLabel.text = self.name;
    
    [self setSelectState];
}

- (void)setSelectState
{
    YFCardTypeCell *cell = (YFCardTypeCell *)self.weakCell;
    
    
    if (!self.isSelected)
    {
        cell.nameLabel.textColor = YFCellTitleColor;
        cell.contentView.backgroundColor = RGB_YF(244, 244, 244);
    }else
    {
        cell.nameLabel.textColor = YFSelectedButtonColor;
        cell.contentView.backgroundColor = [UIColor whiteColor];
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    YFCardKindVC *cardVC = (YFCardKindVC *)self.weakCell.currentVC;
    [cardVC setCardTypeModel:self];
    [self setSelectState];
}


@end
