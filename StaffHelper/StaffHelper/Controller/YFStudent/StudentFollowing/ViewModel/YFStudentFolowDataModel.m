//
//  YFStudentFolowDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFolowDataModel.h"
#import "YFHttpService.h"
#import "YFAppConfig.h"
#import "YFAppService.h"
#import "YFRespoStudentFollowDataModel.h"
#import "YFThreeChartModel.h"
#import "YFDateService.h"

#import "YFStudentTodayTrendDesModel.h"
#import "YFStudentTodayModel.h"
#import "YFStudentTransDesModel.h"
#import "YFTransPersentModel.h"

#import "YFGrayCellModel.h"

#define API @"/api/staffs/%ld/users/track/glance/"

#define StaticsAPI @"/api/staffs/%ld/users/stat/"

#define TransAPI @"/api/staffs/%ld/users/conver/stat/"



@implementation YFStudentFolowDataModel

-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    
    self.gym = gym;
    
    Parameters *para = [self paraWithGym:gym];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];

    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoStudentFollowDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoStudentFollowDataModel *dataMOdel = (YFRespoStudentFollowDataModel *)reModel.dataModel;
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.allDataModel = dataMOdel;
        if (reModel.isSuccess)
        {
            
            if (successBlock) {
                successBlock();
            }        }else
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

-(void)getResponseStaticsDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    
    self.gym = gym;
    
    Parameters *para = [self paraWithGym:gym];
    
    
    [para setParameter:[YFDateService getDateFromDays:-6 formating:nil]  forKey:@"start"];
    [para setParameter:[YFDateService getDateFromDays:0 formating:nil]  forKey:@"end"];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    for (NSInteger i = 6; i >= 0; i --)
    {
        NSString *string = [YFDateService getDateFromDays:-i formating:nil];
        [dateArray addObject:string];
    }
    DebugLogYF(@"---:%@",dateArray);
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:StaticsAPI,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoStudentFollowDataModel *dataMOdel = (YFRespoStudentFollowDataModel *)reModel.dataModel;
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.chartSevenDataModel = dataMOdel;
        if (reModel.isSuccess)
        {
            NSMutableArray *arrayToday = [NSMutableArray array];
            
            YFStudentTodayTrendDesModel *trendModel = [YFStudentTodayTrendDesModel defaultWithDic:nil];
            [arrayToday addObject:trendModel];
            
            YFThreeChartModel *threeChartModel = [YFThreeChartModel defaultWithDic:dataMOdel.dic];
            [threeChartModel fullEmptyArrayWithDateArray:dateArray];
            [arrayToday addObject:threeChartModel];
            
            weakS.arrayToday = arrayToday;
            
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


-(void)getResponseTransPersentsDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    
    self.gym = gym;
    
    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:[YFDateService getDateFromDays:-6 formating:nil]  forKey:@"start"];
    [para setParameter:[YFDateService getDateFromDays:0 formating:nil]  forKey:@"end"];
    
    NSMutableArray *dateArray = [NSMutableArray array];
    
    for (NSInteger i = 6; i >= 0; i --)
    {
        NSString *string = [YFDateService getDateFromDays:-i formating:nil];
        [dateArray addObject:string];
    }
    DebugLogYF(@"---:%@",dateArray);
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:TransAPI,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoStudentFollowDataModel *dataMOdel = (YFRespoStudentFollowDataModel *)reModel.dataModel;
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.transPerdataModel = dataMOdel;
        if (reModel.isSuccess)
        {
            NSMutableArray *arrayToday = [NSMutableArray array];
            
            YFStudentTransDesModel *transModel = [YFStudentTransDesModel defaultWithDic:nil];
            [arrayToday addObject:transModel];
            
            YFTransPersentModel *tranSperModel = [YFTransPersentModel defaultWithDic:dataMOdel.dic];
           
            [arrayToday addObject:tranSperModel];
            
            self.arrayTransPersent = arrayToday;
            
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

-(Parameters *)paraWithGym:(Gym *)gym
{
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    return para;
}


@end
