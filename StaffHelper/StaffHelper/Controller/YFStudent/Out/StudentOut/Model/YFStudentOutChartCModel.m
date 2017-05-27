//
//  YFStudentOutChartCModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutChartCModel.h"

#import "YFStudentOutChartCell.h"

static NSString *yFStudentOutChartCell = @"YFStudentOutChartCell";

@implementation YFStudentOutChartCModel



- (instancetype)initWithYYModelDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithYYModelDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStudentOutChartCell;
        self.cellClass = [YFStudentOutChartCell class];
        self.cellHeight = YFStudentOutChartCellHeight;
        
    }
    return self;
}

- (void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStudentOutChartCell *cell = (YFStudentOutChartCell *)baseCell;
 
    
    if ([cell.chartView.staticModel isEqual:self.staticsModel])
    {
        return;
    }else
    {
    }

    NSString *countItmesStr;
    if (self.staticsModel.arrayModels.count == 7)
    {
        countItmesStr = @"7";
        [cell creatCharViewWithDateCount:7 defaultColor:nil];
    }else
    {
        countItmesStr = @"30";
        [cell creatCharViewWithDateCount:30 defaultColor:nil];
    }

    cell.chartView.staticModel = self.staticsModel;
    
    [cell setContentOffsetWithXX:cell.chartView.beginSelelctOffsetIndex];
    [cell setDefaultView];
    
}


@end
