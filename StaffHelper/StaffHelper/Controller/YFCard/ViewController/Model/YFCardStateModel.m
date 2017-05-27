//
//  YFCardStateModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardStateModel.h"

#import "YYModel.h"

#import "YFCardStateCell.h"

#import "YFCardStateVC.h"

static NSString *yFCardStateCell = @"YFCardStateCell";

@implementation YFCardStateModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFCardStateCell;
        self.cellClass = [YFCardStateCell class];
        self.cellHeight = XFrom5To6YF(40);
        self.edgeInsets = UIEdgeInsetsMake(0,15, 0, 0);

    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFCardStateCell *cell = (YFCardStateCell *)self.weakCell;
    
    cell.nameLabel.text = self.name;
    
    [self setSelectState];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
    YFCardStateVC *cardVC = (YFCardStateVC *)self.weakCell.currentVC;
    [cardVC setCardStateModel:self];
    [self setSelectState];
    
    if (cardVC.sureBlock) {
        cardVC.sureBlock();
    }
}


- (void)setSelectState
{
    YFCardStateCell *cell = (YFCardStateCell *)self.weakCell;
    
    if (!self.isSelected)
    {
        cell.arrowImageView.hidden = YES;
        cell.nameLabel.textColor = YFCellTitleColor;
    }else
    {
        cell.arrowImageView.hidden = NO;
        cell.nameLabel.textColor = YFSelectedButtonColor;
    }
}

- (NSDictionary *)paramOfState
{
    return @{@"state":[NSNumber numberWithInteger:self.cardState] };

}


@end
