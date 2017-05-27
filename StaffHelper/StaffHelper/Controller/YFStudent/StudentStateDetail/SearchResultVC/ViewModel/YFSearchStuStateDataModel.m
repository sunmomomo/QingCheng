//
//  YFSearchStuStateDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchStuStateDataModel.h"
#import "YFHttpService.h"
#import "YFRespoDataArrayModel.h"
#import "YFAppConfig.h"
#import "YFStudentStateModel.h"

#define API @"/api/staffs/%ld/status/users/"

#define TodayAPI @"/api/staffs/%ld/status/users/new/"


@implementation YFSearchStuStateDataModel
{
    YFHttpService *_requestService;
}
- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    if (!StaffId) {
        if (failBlock) {
            failBlock();
        }
    }
    self.gym = gym;
    Parameters *para = [self paraWithGym:gym];
    
    [para setParameter:self.status forKey:@"status"];
    [para setParameter:self.searchStr forKey:@"q"];

    NSString *urlString;
    if (!self.isToday) {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    }else{
    urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:TodayAPI,StaffId]];
    }
    
    weakTypesYF
    
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFStudentStateModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        if ([_requestService isEqual:baseModel.httpService] == NO) {
            return ;
        }
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        
        YFRespoDataArrayModel *dataMOdel = (YFRespoDataArrayModel *)reModel.dataModel;
        
        
        weakS.allMemNum = [dataMOdel.dic[@"total_count"] guardStringYF];

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
    
    [para setInteger:1 forKey:@"show_all"];
    
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
