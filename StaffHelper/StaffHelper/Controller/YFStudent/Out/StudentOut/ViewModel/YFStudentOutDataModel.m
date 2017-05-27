//
//  YFStudentOutDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFStudentOutDataModel.h"
#import "YFStudentOutDataModel.h"

#import "YFStudentOutChartCModel.h"

#import "YFDateService.h"

#import "YFStudentOutDownModel.h"

#import "YFStudentOutTrendDesModel.h"

#import "YFGrayCellModel.h"

#import "YFHttpService.h"

#import "YFRespoDataArrayYYModel.h"

#import "YFOutRandCModel.h"

#import "YFRequestHeader.h"


//http://127.0.0.1:9000?brand_id=2&shop_id=4&start=2016-01-01&end=2016-12-31&order_by=-group

#import "YFAbsenceStaticCModel.h"

#import "YFRespoStudentFollowDataModel.h"

@implementation YFStudentOutDataModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:self.gym];
    
    [para setParameter:[YFDateService getDateFromDays:-6 formating:nil]  forKey:@"start"];
    [para setParameter:[YFDateService getDateFromDays:0 formating:nil]  forKey:@"end"];
    
    
    NSMutableArray *dateArray;
    //
    
    if (conditonParam.count)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:conditonParam];
        
        dateArray = [dic objectForKey:@"DateArray"];
        if (dateArray) {
            [dic removeObjectForKey:@"DateArray"];
        }
        
        NSDictionary *dateParamDic = [dic objectForKey:@"DataParam"];
        
        if (dateParamDic)
        {
            [dic removeObjectForKey:@"DataParam"];
        }
        
        
        [para.data setValuesForKeysWithDictionary:dic];
        [para.data setValuesForKeysWithDictionary:dateParamDic];
    }
    // 默认 七天
    if (!dateArray.count)
    {
        dateArray = [NSMutableArray array];
        
        for (NSInteger i = 6; i >= 0; i --)
        {
            NSString *string = [YFDateService getDateFromDays:-i formating:nil];
            [dateArray addObject:string];
        }
    }
    DebugLogParamYF(@"%@",para.data);

    NSString *urlString;

    urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kStaffsUsersAttendanceGlanceRequestYF,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoStudentFollowDataModel *dataMOdel = (YFRespoStudentFollowDataModel *)reModel.dataModel;
        
        DebugLogYF(@"%@",dataMOdel.dic);
        if (reModel.isSuccess)
        {
            YFStudentOutChartCModel *chartModel = [YFStudentOutChartCModel defaultWithYYModelDic:nil];
            
            chartModel.staticsModel = [YFStaticsModel defaultWithYYModelDic:nil];
            [chartModel.staticsModel resultArray:dataMOdel.dic[@"attendances"]];
            
//            chartModel.staticsModel.arrayModels = [NSMutableArray array];
            
            [chartModel.staticsModel fullEmptyArrayWithDateArray:dateArray];
            
            NSMutableArray *dataArray = [NSMutableArray array];
            
            [dataArray addObject:chartModel];
            
            [dataArray addObject:[YFGrayCellModel defaultWithCellHeght:XFrom5To6YF(20)]];
            
            weakS.dataArray = dataArray;
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock();
        }
        //        [YFAppService showAlertMessageWithError:error];
    }];
}

- (void)getAbsenceResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:self.gym];

    [para setInteger:self.page forKey:@"page"];
    if (conditonParam) {
        [para.data setValuesForKeysWithDictionary:conditonParam];
    }

    DebugLogParamYF(@"%@",para.data);
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kStaffsUsersAbsenceRequestYF,StaffId]];

    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayYYModel class] modelClass:[YFAbsenceStaticCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        weakS.dataModel = dataMOdel;
        dataMOdel.arrayKey = @"attendances";
        
        if (reModel.isSuccess)
        {
            weakS.dataArray = dataMOdel.listArray;
           
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

- (void)getOutRankResponseDatashowLoadingOn:(UIView *)superView conditonParam:(NSDictionary *)conditonParam successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:self.gym];
    
       
    [para setInteger:self.page forKey:@"page"];
    if (conditonParam) {
        [para.data setValuesForKeysWithDictionary:conditonParam];
    }
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:kStaffsUsersAttendanceRequestYF,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayYYModel class] modelClass:[YFOutRandCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        weakS.dataModel = dataMOdel;
        dataMOdel.arrayKey = @"attendances";
        
        if (reModel.isSuccess)
        {
            weakS.dataArray = dataMOdel.listArray;
            
            if (successBlock) {
                successBlock();
            }
        }else
        {
            if (failBlock) {
                failBlock();
            }
        }
    } failure:^(NSError * _Nonnull error) {
        if (failBlock) {
            failBlock();
        }
        DebugLogParamYF(@"%@",error);

    }];
}


@end
