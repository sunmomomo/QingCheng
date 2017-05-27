//
//  YFHomeLineChartDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/1/9.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFHomeLineChartDataModel.h"

#import "YFStaticsModel.h"
#import "YFDateService.h"

#import "YFHomeLineChartModel.h"
#import "YFAppConfig.h"

@implementation YFHomeLineChartDataModel
{
    NSMutableArray *_dateArray;
}
- (void)getResponseDatashowLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
    _dateArray = [NSMutableArray array];
    
    // 最近7 天
    for (NSInteger i = 6; i >= 0; i --)
    {
        NSString *string = [YFDateService getDateFromDays:-i formating:nil];
        [_dateArray addObject:string];
    }
//    // 最近30 天
//    for (NSInteger i = 29; i >= 0; i --)
//    {
//        NSString *string = [YFDateService getDateFromDays:-i formating:nil];
//        [_dateArray addObject:string];
//    }

    
    NSMutableArray *dataArray = [NSMutableArray array];
    
   
    [dataArray addObject:[self modelWithDic:nil index:0]];
    [dataArray addObject:[self modelWithDic:nil index:1]];
    [dataArray addObject:[self modelWithDic:nil index:2]];
    [dataArray addObject:[self modelWithDic:nil index:3]];

    
    self.dataArray = dataArray;
    
    
    if (successBlock)
    {
        successBlock();
    }
}


-(YFHomeLineChartModel *)modelWithDic:(NSDictionary *)dic index:(NSUInteger)index
{
    YFHomeLineChartModel *lineChartModel = [YFHomeLineChartModel defaultWithDic:dic];
    lineChartModel.chartDesStr = @"最近7天新增注册";
    if (index == 0) {
        lineChartModel.defaultColor = YFFirstChartDeColor;
    }else if (index == 1){
        lineChartModel.defaultColor = YFSecondChartDeColor;
    }else {
        lineChartModel.defaultColor = YFThreeChartDeColor;
    }
    YFStaticsModel *model = [YFStaticsModel defaultWithDic:nil];
    model.count = @"198";
    // 填满 没有数据的 地方
    [model fullEmptyArrayWithDateArray:_dateArray];
    lineChartModel.chartStaticModel = model;
    
    return lineChartModel;
}


- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}



@end
