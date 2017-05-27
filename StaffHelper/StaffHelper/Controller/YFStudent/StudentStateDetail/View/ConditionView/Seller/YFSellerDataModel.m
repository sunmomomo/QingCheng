//
//  YFSellerDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSellerDataModel.h"
#import "YFAppConfig.h"
#import "YFHttpService.h"
#import "YFRespoDataArrayModel.h"
#import "YFSellerModel.h"

#define API @"/api/staffs/%ld/filter/sellers/"

@implementation YFSellerDataModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym isHaveAllSeller:(BOOL)isHaveAllSeller successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    
    self.gym = gym;
    
    Parameters *para = [self paraWithGym:gym];
    
    [para setInteger:self.page forKey:@"page"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFSellerModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        
        if (dataMOdel.current_page.integerValue == 1)
        {
            
            YFSellerModel *noSellModel = [YFSellerModel defaultWithDic:nil];
            noSellModel.isNoSelle = YES;
            
            [dataMOdel.listArray insertObject:noSellModel atIndex:0];
           
            if (isHaveAllSeller)
            {
                YFSellerModel *allModel = [YFSellerModel defaultWithDic:nil];
                allModel.isALl = YES;
                allModel.isSelected = YES;
                weakS.allModel = allModel;
                [dataMOdel.listArray insertObject:allModel atIndex:0];
            }else
            {
                noSellModel.username = @"未分配";
            }

            
            
        }

        
        DebugLogYF(@"%@",dataMOdel.dic);
        weakS.dataMOdel = dataMOdel;
        if (reModel.isSuccess)
        {
            self.showDataArray = dataMOdel.listArray;
           
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
