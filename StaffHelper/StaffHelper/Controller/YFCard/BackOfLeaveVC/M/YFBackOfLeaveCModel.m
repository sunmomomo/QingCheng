//
//  YFBackOfLeaveCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBackOfLeaveCModel.h"

#import "YFDateService.h"

#import "YFBackOfLeaveCell.h"

static NSString *yFBackOfLeaveCell = @"YFBackOfLeaveCell";

@implementation YFBackOfLeaveCModel

- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFBackOfLeaveCell;
        self.cellClass = [YFBackOfLeaveCell class];
        self.cellHeight = Width320(142);
        self.edgeInsets = UIEdgeInsetsMake(0,0, 0, 0);
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    [baseCell setSelectionStyle:UITableViewCellSelectionStyleNone];
}

- (void)bindCell:(YFBackOfLeaveCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    baseCell.desLabel.text = [NSString stringWithFormat:@"从今天%@起提前销假 已请假%@天",self.todayString,self.leaveDays];
    if (self.checkValid)
    {
        self.cellHeight = Width320(142);
        
        baseCell.originValidDateDesLabel.hidden = NO;
        baseCell.originValidDateLabel.hidden = NO;
        baseCell.backOfLeaveDateDesLabel.hidden = NO;
        baseCell.backOfLeaveDateLabel.hidden = NO;
        
    }
    else
    {
        baseCell.originValidDateDesLabel.hidden = YES;
        baseCell.originValidDateLabel.hidden = YES;
        baseCell.backOfLeaveDateDesLabel.hidden = YES;
        baseCell.backOfLeaveDateLabel.hidden = YES;

        self.cellHeight = baseCell.desLabel.bottom +  Width320(16);
    }
    baseCell.originValidDateDesLabel.text = @"原有效期";
    baseCell.originValidDateLabel.text = self.originValidDateString;
    
    baseCell.backOfLeaveDateDesLabel.text = @"销假后有效期";
    baseCell.backOfLeaveDateLabel.text = self.backOfLeaveDateString;
    
}

- (NSString *)todayString
{
    if (!_todayString)
    {
        _todayString = [YFDateService getTodayDate:@"yyyy-MM-dd"];
    }
    return _todayString;
}

@end
