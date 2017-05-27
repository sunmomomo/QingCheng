//
//  YFAutomicRemindShopDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/2/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFAutomicRemindShopDataModel.h"

#import "YFHttpService.h"

#import "YFRespoDataArrayYYModel.h"

#import "NSMutableDictionary+YFExtension.h"

#import "NSMutableArray+YFExtension.h"

#import "YFAutomicRemindCModel.h"


#define CardSuffientShopsConfig @"/api/staffs/%ld/shops/configs/"

@implementation YFAutomicRemindShopDataModel


- (void)getSuffientShopsSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else if(AppGym)
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
//    value_card_remind 储值卡
//    times_card_remind 次卡
//    time_card_remind 期限卡
    
    [para setParameter:@"value_card_remind,times_card_remind,time_card_remind,value_card_remind_enable,times_card_remind_enable,time_card_remind_enable" forKey:@"keys"];
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CardSuffientShopsConfig,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        NSMutableArray *dataArray = [NSMutableArray array];;
        
        if (reModel.isSuccess)
        {
            //            weakS.suffinetCardCount = [reModel.dataModel.dic[@"count"] guardStringYF];
            YFRespoDataModel *dataModel =(YFRespoDataModel *)baseModel.dataModel;

            NSArray *array = [dataModel.dic[@"configs"] guardArrayYF];
            
            self.webSetingUrl = [dataModel.dic[@"edit_url"] guardStringYF];;
            
        
            
            for (NSDictionary *dic in array) {
                
                NSString *key = dic[@"key"];
                
                YFAutomicRemindCModel *model = [YFAutomicRemindCModel defaultWithYYModelDic:dic];

                if ([key isEqualToString:@"value_card_remind"])
                {
                    self.remindPayModel = [self modelWithName:@"储值卡" desName:@"余额少于多少元时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@元",model.value] isOpen:YES model:model];
                }else if([key isEqualToString:@"times_card_remind"])
                {
                    self.timesModel = [self modelWithName:@"次卡" desName:@"余额少于多少次时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@次",model.value] isOpen:YES model:model];
                }else if ([key isEqualToString:@"time_card_remind"])
                {
                    self.timeModel = [self modelWithName:@"会员卡有效期" desName:@"有效期少于多少天时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@天",model.value] isOpen:YES model:model];
                }else if ([key isEqualToString:@"value_card_remind_enable"])
                {
                    self.remindPayEnableModel = [self modelWithName:@"储值卡" desName:@"余额少于多少元时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@元",model.value] isOpen:YES model:model];
                }else if ([key isEqualToString:@"times_card_remind_enable"])
                {
                    self.timesEnableModel = [self modelWithName:@"次卡" desName:@"余额少于多少次时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@次",model.value] isOpen:YES model:model];

                }else if ([key isEqualToString:@"time_card_remind_enable"])
                {
                    self.timeEnableModel = [self modelWithName:@"次卡" desName:@"余额少于多少次时会员将收到提醒短信？" value:[NSString stringWithFormat:@"< %@次",model.value] isOpen:YES model:model];

                }
            }
            self.remindPayModel.isOpen = self.remindPayEnableModel.value.boolValue;
            self.remindPayModel.valueSwitchId = self.remindPayEnableModel.re_id;
            
            self.timesModel.isOpen = self.timesEnableModel.value.boolValue;
            self.timesModel.valueSwitchId = self.timesEnableModel.re_id;
            
            self.timeModel.isOpen = self.timeEnableModel.value.boolValue;
            self.timeModel.valueSwitchId = self.timeEnableModel.re_id;

        
            [dataArray addObjectYF:self.remindPayModel];
            [dataArray addObjectYF:self.timesModel];
            [dataArray addObjectYF:self.timeModel];
            
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


- (void)putSuffientShopsSettingStudentshowLoadingOn:(UIView *)superView gym:(Gym *)gym param:(NSDictionary *)param successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:BRANDID forKey:@"brand_id"];
    
    if (gym) {
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
    }else if(AppGym)
    {
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
    }
    
    if (param) {
    [para.data addEntriesFromDictionary:param];
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:CardSuffientShopsConfig,StaffId]];
    
    
    [[YFHttpService instance] PUT:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        if (reModel.isSuccess)
        {

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

- (void)reloaData
{
    NSMutableArray *dataArray = [NSMutableArray array];;

    self.remindPayModel.isOpen = self.remindPayEnableModel.value.boolValue;
    self.timesModel.isOpen = self.timesEnableModel.value.boolValue;
    self.timeModel.isOpen = self.timeEnableModel.value.boolValue;

    [dataArray addObjectYF:self.remindPayModel];
    [dataArray addObjectYF:self.timesModel];
    [dataArray addObjectYF:self.timeModel];

    self.dataArray = dataArray;

}


- (YFAutomicRemindCModel *)modelWithName:(NSString *)name desName:(NSString *)desName value:(NSString *)value isOpen:(BOOL )open model:(YFAutomicRemindCModel *)model
{
//    YFAutomicRemindCModel *model = [YFAutomicRemindCModel defaultWithYYModelDic:dic];
    model.title = name;
    model.desName = desName;
    model.valueString = value;
    model.isOpen = open;
    
    return model;
}


@end
