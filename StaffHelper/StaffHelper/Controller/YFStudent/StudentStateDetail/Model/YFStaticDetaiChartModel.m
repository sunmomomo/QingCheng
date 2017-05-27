//
//  YFStaticDetaiChartModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStaticDetaiChartModel.h"
#import "YFStaticDetaiChartCell.h"

static NSString *yFStaticDetaiChartCell = @"YFStaticDetaiChartCell";


@implementation YFStaticDetaiChartModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFStaticDetaiChartCell;
        self.cellClass = [YFStaticDetaiChartCell class];
        self.cellHeight = 242;
        
        self.staModel = [YFStaticsModel defaultWithDic:jsonDic];
        
    }
    return self;
}
-(void)setCell:(YFBaseCell *)baseCell toObjectFY:(NSObject *)object
{
    baseCell.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray
{
    [self.staModel fullEmptyArrayWithDateArray:dateArray];
}


- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFStaticDetaiChartCell *cell = (YFStaticDetaiChartCell *)baseCell;
    
    if ([cell.chartView.staticModel isEqual:self.staModel])
    {
        return;
    }else
    {
    }
    
    
    NSString *countItmesStr;
    if (self.staModel.arrayModels.count == 7)
    {
        countItmesStr = @"7";
        [cell creatCharViewWithDateCount:7 defaultColor:self.defaultColor];
    }else
    {
        countItmesStr = @"30";
        [cell creatCharViewWithDateCount:30 defaultColor:self.defaultColor];
    }
    cell.chartView.defaultColor = self.defaultColor;

    cell.chartView.desLabel.text = [NSString stringWithFormat:@"最近%@天%@共计",countItmesStr,self.desValueStr];


    cell.chartView.staticModel = self.staModel;
    [cell setContentOffsetWithXX:cell.chartView.beginSelelctOffsetIndex];
    [cell setDefaultView];
}

@end
