//
//  YFStudentOutTrendDesModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutTrendDesModel.h"

#import "YFStudentTodayTrendDesCell.h"

static NSString *yFStudentTodayTrendDesCell = @"YFStudentTodayTrendDesCell";


@implementation YFStudentOutTrendDesModel


- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentTodayTrendDesCell;
        self.cellClass = [YFStudentTodayTrendDesCell class];
        self.cellHeight = 46;
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentTodayTrendDesCell *cell = (YFStudentTodayTrendDesCell *)baseCell;
    cell.nameLabel.text = @"会员出勤趋势图";
    [cell.nameLabel changeHeight:46.0];
    [cell.contentView addSubview:cell.button];
    cell.valueLabel.hidden = YES;
    cell.arrowImageView.hidden = YES;
    cell.stateImageView.center = CGPointMake(cell.stateImageView.center.x, 23.0);
    [cell.button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)buttonAction:(UIButton *)button
{
    if (self.selectBlock) {
        self.selectBlock(self);
    }
}

- (void)setDesStrToButton:(NSString *)str
{
    YFStudentTodayTrendDesCell *cell = (YFStudentTodayTrendDesCell *)self.weakCell;
    
    [cell.button setTitle:str forState:UIControlStateNormal];

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    
}

@end
