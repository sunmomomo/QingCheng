//
//  YFMesNotiSettingDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFMesNotiSettingDataModel.h"

#define API @"/api/staffs/%ld/configs/"

#import "YFHttpService.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFAutomicRemindCModel.h"

///api/staffs/1/configs/?keys=notify_balance_cards

@implementation YFMesNotiSettingDataModel



- (void)getSuffientShopsNotiSettingshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    [para setParameter:@"notify_balance_cards" forKey:@"keys"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        
        if (reModel.isSuccess)
        {
            //            weakS.suffinetCardCount = [reModel.dataModel.dic[@"count"] guardStringYF];
            YFRespoDataModel *dataModel =(YFRespoDataModel *)baseModel.dataModel;
            
            NSArray *array = [dataModel.dic[@"configs"] guardArrayYF];
            

            for (NSDictionary *dic in array) {
                
                weakS.model = [YFAutomicRemindCModel defaultWithYYModelDic:dic];
            }
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


- (void)putSuffientShopsNotiSettingshowLoadingOn:(UIView *)superView gym:(Gym *)gym value:(NSString *)value successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
//    [para setParameter:BRANDID forKey:@"brand_id"];
//    
//    if (gym) {
//        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
//    }else
//    {
//        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
//    }
    
    NSMutableDictionary *dic = [NSMutableDictionary dictionary];
    
    [dic setObje_FY:self.model.re_id toKey:@"id"];
    [dic setObje_FY:value toKey:@"value"];
    
    [para setParameter:@[dic] forKey:@"configs"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] PUT:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        if (reModel.isSuccess)
        {
            weakS.model.value = value;
            
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


@end
