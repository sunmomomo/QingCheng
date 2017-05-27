//
//  YFSearchStuListDataModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFSearchStuListDataModel.h"

#define API @"/api/staffs/%ld/users/"
#import "YFAppConfig.h"
#import "YFHttpService.h"
#import "YFStudentListModel.h"

@implementation YFSearchStuListDataModel
{
    YFHttpService *_requestService;
}
- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"1" forKey:@"show_all"];
    
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
    
    [para setParameter:self.searchStr forKey:@"q"];
    
    
  
    
    NSString *urlString = [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];
    
    weakTypesYF
    
    [[NSUserDefaults standardUserDefaults]setInteger:[BRANDID integerValue] forKey:@"stu_brand_id"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if (_requestService)
    {
        [_requestService yf_cancel];
    }
    
    _requestService = [YFHttpService instance];
    
    [_requestService GET:urlString parameters:para.data serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            [weakS resultDic:reModel.dataModel.dic];
           
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
        
        DebugLogYF(@"errorCode:%@",@(error.code));
    }];
}


-(void)resultDic:(NSDictionary *)dic
{
    self.allMemNum = [dic[@"total_count"] guardStringYF];
    
    NSArray *dataArray =  dic[@"users"];
    
    dataArray = [dataArray guardArrayYF];
    
    NSMutableArray *allSearchDataArray = [NSMutableArray array];;
    
    for (NSDictionary *dic in dataArray) {
        YFStudentListModel *model = [[YFStudentListModel alloc] initWithDictionary:dic];
        
        [allSearchDataArray addObject:model];
    }
    self.allSearchDataArray = allSearchDataArray;
    
}


@end
