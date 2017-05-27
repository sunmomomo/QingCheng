//
//  YFStudentRightDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentRightDataModel.h"
#import "YFHttpService.h"
#import "YFAppService.h"
#import "YFRespoDataArrayModel.h"
#import "YFStudentFilterRePeoModel.h"
#import "YFRespoDataOriginArrayModel.h"
#import "YFStudentFilterOriginModel.h"

#define API @"/api/staffs/%ld/users/recommends/"
#define APIOrigin @"/api/v2/staffs/%ld/users/origins/"
#define APIFilterOrigin @"/api/staffs/%ld/filter/origins/"
#define SearchRecomendsSelect @"/api/staffs/%ld/users/recommends/select/"



@implementation YFStudentRightDataModel


-(Parameters *)froGym:(Gym *)gym
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
        
    }
    
    
    return para;
}

-(void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self froGym:gym];
    [para setInteger:1 forKey:@"show_all"];
    [para setParameter:self.seller_id forKey:@"seller_id"];
    
    NSString *urlString ;
    if (_isFilter) {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    }else
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    }

weakTypesYF
    DebugLogYF(@"getResponseDatashowLoadingOn::::::::::::%@",para.data);
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFStudentFilterRePeoModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        YFRespoDataArrayModel *dataArrayModel =(YFRespoDataArrayModel *)reModel.dataModel;
        weakS.reArray = dataArrayModel.listArray;
        
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
    }];

    
    
    
}


-(void)getOriginResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self froGym:gym];
    [para setInteger:1 forKey:@"show_all"];
    
    NSString *urlString;
    
    if (_isFilter) {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:APIFilterOrigin,StaffId]];
        // 只有筛选的时候 带 seller_id
        [para setParameter:self.seller_id forKey:@"seller_id"];

    }else
    {
        urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:APIOrigin,StaffId]];
    }
    
    DebugLogYF(@"getOriginResponseDatashowLoadingOn:::::::::::%@",para.data);

    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataOriginArrayModel class] modelClass:[YFStudentFilterOriginModel
 class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        YFRespoDataOriginArrayModel *dataArrayModel =(YFRespoDataOriginArrayModel *)reModel.dataModel;
        weakS.oriArray = dataArrayModel.listArray;
        
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
    }];
}


-(void)getResponseSearchDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self froGym:gym];
    
    if (self.searchStr.length > 0)
    {
        [para setParameter:self.searchStr forKey:@"q"];
    }
    
    if (self.dataPage <= 0)
    {
        self.dataPage = 1;
    }
    [para setInteger:self.dataPage forKey:@"page"];
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:SearchRecomendsSelect,StaffId]];
    
    weakTypesYF
    [[YFHttpService instance] GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:[YFStudentFilterRePeoModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        YFRespoDataArrayModel *dataArrayModel =(YFRespoDataArrayModel *)reModel.dataModel;
        weakS.searchDataModel = dataArrayModel;
        
        
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
    }];
    
    
    
    
}

- (NSMutableArray *)oriArray
{
    if (!_oriArray) {
        _oriArray = [NSMutableArray array];
    }
    return _oriArray;
}


@end

