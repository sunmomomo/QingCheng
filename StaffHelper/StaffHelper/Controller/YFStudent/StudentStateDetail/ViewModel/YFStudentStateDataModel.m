//
//  YFStudentStateDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentStateDataModel.h"
#import "YFAppConfig.h"
#import "YFHttpService.h"
#import "YFRespoDataArrayModel.h"
#import "YFStudentStateModel.h"
#import "YFDateService.h"
#import "YFRespoStudentFollowDataModel.h"
#import "YFGrayCellModel.h"
#import "YFStaticDetaiChartModel.h"
#import "YFStudentTransDesModel.h"
#import "YFTransPersentModel.h"
#import "YFStudentTransCModel.h"

#define API @"/api/staffs/%ld/status/users/"

#define TodayAPI @"/api/staffs/%ld/status/users/new/"

#define StatAPI @"/api/staffs/%ld/users/stat/"

#define TransAPI @"/api/staffs/%ld/users/conver/stat/"

#define NewCreatAPI @"/api/staffs/%ld/users/new/create/"

#define NewFollowingAPI @"/api/staffs/%ld/users/new/follow/"

#define NewMemberAPI @"/api/staffs/%ld/users/new/member/"




@implementation YFStudentStateDataModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    
    self.gym = gym;
    
    Parameters *para = [self paraWithGym:gym];
    
    
    
//    [para setInteger:self.page forKey:@"page"];

    [para setInteger:1 forKey:@"show_all"];
    
    [para setParameter:[YFDateService getDateFromDays:0 formating:nil]  forKey:@"start"];
    [para setParameter:[YFDateService getDateFromDays:0 formating:nil]  forKey:@"end"];
    
    NSMutableArray *dateArray;
    //
    
    if (self.allConditionParam.count)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.allConditionParam];
        
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
        if ([para.data objectForKey:@"start"] == NO)// 下拉 页面 时间筛选
        {
        [para.data setValuesForKeysWithDictionary:dateParamDic];
        }
        
    }
    // 默认 七天
    if (!dateArray)
    {
        dateArray = [NSMutableArray array];
        
        for (NSInteger i = 0; i >= 0; i --)
        {
            NSString *string = [YFDateService getDateFromDays:-i formating:nil];
            [dateArray addObject:string];
        }
    }
    
    NSString *urlString;
    
        if ([self.status isEqualToString:YFIsNewRe])
        {
            urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:NewCreatAPI,StaffId]];
        }
        else if ([self.status isEqualToString:YFIsFollowing])
        {
            urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:NewFollowingAPI,StaffId]];
        }
       else if ([self.status isEqualToString:YFIsMember])
       {
           urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:NewMemberAPI,StaffId]];
       }
    
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFStudentStateModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        
        weakS.allMemNum = [dataMOdel.dic[@"total_count"] guardStringYF];
        
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.dataMOdel = dataMOdel;
        if (reModel.isSuccess)
        {
//            
//            YFStudentStateModel *stateModel = [YFStudentStateModel defaultWithDic:nil];
//            
//            [dataMOdel.listArray addObject:stateModel];
//            [dataMOdel.listArray addObject:stateModel];
//            [dataMOdel.listArray addObject:stateModel];
//            [dataMOdel.listArray addObject:stateModel];
//            [dataMOdel.listArray addObject:stateModel];
            
            
            weakS.showDataArray = dataMOdel.listArray;
//            NSMutableArray *arrayToday = [NSMutableArray array];
//            
//            YFStudentTodayTrendDesModel *trendModel = [YFStudentTodayTrendDesModel defaultWithDic:nil];
//            [arrayToday addObject:trendModel];
//            
//            YFThreeChartModel *threeChartModel = [YFThreeChartModel defaultWithDic:dataMOdel.dic];
//            [arrayToday addObject:threeChartModel];
//            
//            
//            YFStudentTransDesModel *transModel = [YFStudentTransDesModel defaultWithDic:nil];
//            [arrayToday addObject:transModel];
//            
//            YFTransPersentModel *tranSperModel = [YFTransPersentModel defaultWithDic:nil];
//            tranSperModel.neRegisNum = threeChartModel.neCreateUsersModel.count.integerValue;
//            tranSperModel.neFollow = threeChartModel.neFollowingUsers.count.integerValue;
//            tranSperModel.neMem = threeChartModel.neMemberUsers.count.integerValue;
//            [arrayToday addObject:tranSperModel];
//            
        
//            self.arrayToday = arrayToday;
        
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

- (void)getResponseDataStaticshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
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
    
    [para setParameter:self.status  forKey:@"status"];

    
    NSMutableArray *dateArray;
//
    
    if (self.allConditionParamForStatic.count)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.allConditionParamForStatic];
        
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
    
    NSString *urlString;
    
  
    urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:StatAPI,StaffId]];
        
        //        YFStaticDetaiChartModel
        
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoStudentFollowDataModel *dataMOdel = (YFRespoStudentFollowDataModel *)reModel.dataModel;

        
        DebugLogParamYF(@"%@",dataMOdel.dic);
        if (reModel.isSuccess)
        {
            NSMutableArray *arrayToday = [NSMutableArray array];
            
            YFGrayCellModel *grayModel = [YFGrayCellModel defaultWithCellHeght:17.0];
            [arrayToday addObject:grayModel];
            
            NSDictionary *new_create_usersDic = [dataMOdel.dic objectForKey:@"new_create_users"];
            NSDictionary *new_following_usersDic = [dataMOdel.dic objectForKey:@"new_following_users"];
            NSDictionary *new_member_usersDic = [dataMOdel.dic objectForKey:@"new_member_users"];
            
            
            if ([weakS.status isEqualToString:YFIsNewRe])
            {
            weakS.subUpCModel = [YFFolloSubUpCModel defaultWithYYModelDic:new_create_usersDic];
            weakS.subUpCModel.defaultColor = YFFirstChartDeColor;
            }
            else if ([weakS.status isEqualToString:YFIsFollowing])
            {
            weakS.subUpCModel = [YFFolloSubUpCModel defaultWithYYModelDic:new_following_usersDic];
            weakS.subUpCModel.defaultColor = YFSecondChartDeColor;
            }
            else
            {
            weakS.subUpCModel = [YFFolloSubUpCModel defaultWithYYModelDic:new_member_usersDic];
            weakS.subUpCModel.defaultColor = YFThreeChartDeColor;
            }
            
            [weakS.subUpCModel.staticsModel fullEmptyArrayWithDateArray:dateArray];
            
            
            
//            YFStaticDetaiChartModel *newCreModel = [YFStaticDetaiChartModel defaultWithDic:new_create_usersDic];
//            newCreModel.desValueStr = @"新增注册";
//            newCreModel.cellIdentifier = @"YFStaticDetaiChartCell1";
//            newCreModel.defaultColor = YFFirstChartDeColor;
//            [newCreModel.staModel fullEmptyArrayWithDateArray:dateArray];
//
//            [arrayToday addObject:newCreModel];
//
//            [arrayToday addObject:grayModel];
//
//            YFStaticDetaiChartModel *newFolloModel = [YFStaticDetaiChartModel defaultWithDic:new_following_usersDic];
//            newFolloModel.desValueStr = @"跟进会员";
//            newFolloModel.cellIdentifier = @"YFStaticDetaiChartCell2";
//            newFolloModel.defaultColor = YFSecondChartDeColor;
//            [newFolloModel.staModel fullEmptyArrayWithDateArray:dateArray];
//            [arrayToday addObject:newFolloModel];
//
//            [arrayToday addObject:grayModel];
//
//            YFStaticDetaiChartModel *newMeModel = [YFStaticDetaiChartModel defaultWithDic:new_member_usersDic];
//            newMeModel.desValueStr = @"新增会员";
//
//            newMeModel.cellIdentifier = @"YFStaticDetaiChartCell3";
//
//            newMeModel.defaultColor = YFThreeChartDeColor;
//
//            [newMeModel.staModel fullEmptyArrayWithDateArray:dateArray];
//            [arrayToday addObject:newMeModel];
//
//            [arrayToday addObject:grayModel];
//            
//            weakS.showDataArray = arrayToday;
            
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
    
    NSMutableArray *dateArray ;
    
    NSString *start;
    NSString *end;
    
    if (self.allConditionParam.count)
    {
        NSMutableDictionary *dic = [NSMutableDictionary dictionaryWithDictionary:self.allConditionParam];
        
        dateArray = [dic objectForKey:@"DateArray"];
        if (dateArray) {
            [dic removeObjectForKey:@"DateArray"];
        }
        
        NSDictionary *dateParamDic = [dic objectForKey:@"DataParam"];
        
        if (dateParamDic)
        {
            [dic removeObjectForKey:@"DataParam"];
            
            start = dateParamDic[@"start"];
            end = dateParamDic[@"end"];
        }
        
        
        [para.data setValuesForKeysWithDictionary:dic];
        [para.data setValuesForKeysWithDictionary:dateParamDic];
    }
    // 默认 七天
    if (!dateArray)
    {
        dateArray = [NSMutableArray array];
        
        for (NSInteger i = 6; i >= 0; i --)
        {
            NSString *string = [YFDateService getDateFromDays:-i formating:nil];
            [dateArray addObject:string];
            
            if (i == 6)
            {
                end = string;
            }else if (i == 0)
            {
                start = string;
            }
        }
    }
    

    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:TransAPI,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFStudentTransCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.transPerdataModel = dataMOdel;
        if (reModel.isSuccess)
        {
            NSMutableArray *arrayToday = [NSMutableArray array];
            
            YFGrayCellModel *grayCellModel = [YFGrayCellModel defaultWithCellHeght:16];
            [arrayToday addObject:grayCellModel];
            
            YFTransPersentModel *tranSperModel = [YFTransPersentModel defaultWithDic:dataMOdel.dic];
            
            tranSperModel.dayCount = [YFDateService calcDaysCurrentToDateString:end startDate:start] + 1;
            tranSperModel.isTwoLevel = YES;
            
            weakS.tranSperModel = tranSperModel;
            
            weakS.tranSperModel.start = start;
            weakS.tranSperModel.end = end;
            
            [arrayToday addObject:tranSperModel];
            
            weakS.showDataArray = arrayToday;
            
            weakS.showStudentDataForTransArray = dataMOdel.listArray;
            
            
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
