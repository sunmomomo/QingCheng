//
//  YFLastestTimeModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFLastestTimeModel.h"
#import "YFLastestTimeCell.h"
#import "YFStudentChooseLatestTimeVC.h"

#import "YFOutRankTimeVC.h"

static NSString *yFLastestTimeCell = @"YFLastestTimeCell";


@implementation YFLastestTimeModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFLastestTimeCell;
        self.cellClass = [YFLastestTimeCell class];
        self.cellHeight = 46;
        self.edgeInsets = UIEdgeInsetsMake(0, 15, 0, 0);

    }
    return self;
}

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFLastestTimeCell;
        self.cellClass = [YFLastestTimeCell class];
        self.cellHeight = 46;
    }
    return self;

}

-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}




- (void)setSelectState
{
    YFLastestTimeCell *cell = (YFLastestTimeCell *)self.weakCell;
    
    if (!self.isSelected)
    {
        cell.nameLabel.textColor = YFCellTitleColor;
        cell.arrowImageView.hidden = YES;
    }else
    {
        cell.arrowImageView.hidden = NO;
        cell.nameLabel.textColor = YFSelectedButtonColor;
    }
}

-(void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFLastestTimeCell *cell = (YFLastestTimeCell *)self.weakCell;
    
    if (self.dateStr.length)
    {
        cell.nameLabel.text = [NSString stringWithFormat:@"%@(%@)",self.valueStr,self.dateStr];

    }else
    {
        cell.nameLabel.text = self.valueStr;
    }
    
    [self setSelectState];
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath onVC:(YFBaseVC *)viewC
{
    if ([self.valueStr isEqualToString:@"自定义"]) {
        if (self.selectBlock) {
            self.selectBlock(self);
            return;
        }
    }
    
    self.isSelected = !self.isSelected;
    [self setSelectState];
    if ([viewC isKindOfClass:[YFStudentChooseLatestTimeVC class]])
    {
        YFStudentChooseLatestTimeVC *rightVC = (YFStudentChooseLatestTimeVC *)viewC;
        [rightVC setSelectModel:self];
    }else if ([YFOutRankTimeVC class])
    {
        YFOutRankTimeVC *rightVC = (YFOutRankTimeVC *)viewC;
        [rightVC setSelectModel:self];
    }
}




@end
