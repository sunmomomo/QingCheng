//
//  YFOutRandDaysCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFOutRandDaysCModel.h"

#import "YFOutRandDaysCell.h"

static NSString *yFOutRandDaysCell = @"YFOutRandDaysCell";

#import "YFOutRankDaysVC.h"

@implementation YFOutRandDaysCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFOutRandDaysCell;
        self.cellClass = [YFOutRandDaysCell class];
        self.cellHeight = 46;
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);
        
        weakTypesYF
        [self setButtonActionBlock:^(UIButton *button) {
            [weakS setButtonAction:button];
        }];

    }
    return self;
}
-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}




- (void)setSelectState
{
    YFOutRandDaysCell *cell = (YFOutRandDaysCell *)self.weakCell;
    
    if (!self.isSelected)
    {
        cell.nameLabel.textColor = YFCellTitleColor;
        cell.leftButton.selected = NO;
        cell.rightButton.selected = NO;
    }else
    {
        
        if (cell.leftButton.selected == NO && cell.rightButton.selected == NO) {
            cell.leftButton.selected = YES;
        }
        
        cell.nameLabel.textColor = YFSelectedButtonColor;
    }
    [self setBorderWidthToButton:cell.leftButton];
    [self setBorderWidthToButton:cell.rightButton];
    
    cell.buttonActionBlock = self.buttonActionBlock;
}

- (void)setBorderWidthToButton:(UIButton *)button
{
    if (button.isSelected) {
        button.layer.borderColor = YFSelectedButtonColor.CGColor;
    }else
    {
        button.layer.borderColor = RGB_YF(187, 187, 187).CGColor;
    }
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFOutRandDaysCell *cell = (YFOutRandDaysCell *)self.weakCell;
    
    cell.nameLabel.text = self.valueStr;
    
    
    [self setSelectState];
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
   
}

- (void)setButtonAction:(UIButton *)button
{
    
    
    YFOutRandDaysCell *cell = (YFOutRandDaysCell *)self.weakCell;

    button.selected = YES;
    if ([button isEqual:cell.leftButton]) {
        cell.rightButton.selected = NO;
    }else
    {
        cell.leftButton.selected = NO;
    }
    self.isSelected = YES;
    [self setSelectState];
    
    YFOutRankDaysVC *rankVC = (YFOutRankDaysVC *)self.weakCell.currentVC;
    rankVC.selelctModel = self;
}

- (NSDictionary *)param
{
    YFOutRandDaysCell *cell = (YFOutRandDaysCell *)self.weakCell;

    if (cell.leftButton.selected == YES)
    {// 从高到低，倒序
        return @{@"order_by":[NSString stringWithFormat:@"-%@",self.keyStr]};
    }else if (cell.leftButton.selected == NO && cell.rightButton.selected == NO)// 都没选中默认 左边
    {
        return @{@"order_by":[NSString stringWithFormat:@"-%@",self.keyStr]};
    }
    else
    {
        return @{@"order_by":self.keyStr};
    }
}


@end
