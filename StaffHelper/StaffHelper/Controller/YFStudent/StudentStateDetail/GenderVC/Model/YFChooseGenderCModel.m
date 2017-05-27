//
//  YFChooseGenderCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFChooseGenderCModel.h"

#import "YFCardStateCell.h"

#import "YFStudnetChooseGenderVC.h"

#import "YFStudnetChooseStatusVC.h"

static NSString *yFCardStateCell = @"YFGenderStateCell";

@implementation YFChooseGenderCModel


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
    
    
    if ([self.weakCell.currentVC isKindOfClass:[YFStudnetChooseStatusVC class]])
    {
        YFStudnetChooseStatusVC *cardVC = (YFStudnetChooseStatusVC *)self.weakCell.currentVC;
        [cardVC setSelectModel:self];
        [self setSelectState];
        
        if (cardVC.sureBlock) {
            cardVC.sureBlock();
        }
    }
    else if ([self.weakCell.currentVC isKindOfClass:[YFStudnetChooseGenderVC class]])
    {
        YFStudnetChooseGenderVC *cardVC = (YFStudnetChooseGenderVC *)self.weakCell.currentVC;
        [cardVC setSelectModel:self];
        [self setSelectState];
        
        if (cardVC.sureBlock) {
            cardVC.sureBlock();
        }

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
    if (self.gender.length) {
        return @{YFGenderKeyForParam:self.gender};
    }
    return @{};
}


- (NSDictionary *)paramOfStatus
{
    if (self.gender.length) {
        return @{YFStatusKeyForParam:self.gender};
    }
    return @{};
}


@end
