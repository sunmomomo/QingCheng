//
//  YFCardCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCardCModel.h"

#import "YFCardCell.h"

#import "YFCardKindVC.h"

#import "YYModel.h"

static NSString *yFCardCell = @"YFCardCell";

@interface YFCardCModel ()<YYModel>

@end

@implementation YFCardCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFCardCell;
        self.cellClass = [YFCardCell class];
        self.edgeInsets = UIEdgeInsetsMake(0,15, 0, 0);
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
    YFCardCell *cell = (YFCardCell *)self.weakCell;

    cell.nameLabel.text = self.name;
    
    [self setSelectState];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    YFCardKindVC *cardVC = (YFCardKindVC *)self.weakCell.currentVC;
    [cardVC setCardModel:self];
    [self setSelectState];

    if (cardVC.sureBlock) {
        cardVC.sureBlock();
    }
}


- (void)setSelectState
{
    YFCardCell *cell = (YFCardCell *)self.weakCell;
    
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

+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"cardId":@"id"};
}

- (NSDictionary *)paramOfCard
{
    if (self.card_tpl_type)
    {
        return @{@"card_tpl_type":self.card_tpl_type};
    }
    
    if (self.cardId)
    {
        return @{@"card_tpl_id":self.cardId};
    }
    
    return @{};
}


@end
