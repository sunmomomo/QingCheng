//
//  YFChooseGymViewModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/6.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFChooseGymViewModel.h"

#define ChoooseGymAPI @"/api/staffs/%ld/services/"

#import "YFRespoSignPerArrayYYModel.h"

#import "YFHttpService+Extension.h"

#import "YFChooseGymCModel.h"

@implementation YFChooseGymViewModel


- (void)getResponseDatashowLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock

{
    Parameters *para = [self parameteYF];
    NSString *urlString =  [NSString stringWithFormat:ChoooseGymAPI,StaffId];
    
    urlString = [NSString stringWithFormat:@"%@%@",ROOT,urlString];;
    
    weakTypesYF
    
    [YFHttpService getList:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {

        arrayModel.exArrayKey = @"services";
        [weakS relultArray:arrayModel.listArray];
        
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

- (void)relultArray:(NSArray *)array
{
    self.dataArray = [NSMutableArray array];
    
    for (NSDictionary *dic in array)
    {
        YFChooseGymCModel *model = [YFChooseGymCModel defaultWithYYModelDic:nil];
        
        Gym *gym = [[Gym alloc]init];

        [gym resultJson:dic];
     
        model.gym = gym;
        
        [self.dataArray addObject:model];
    }
}

@end
