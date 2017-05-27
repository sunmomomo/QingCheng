//
//  YFSmsListViewModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/16.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsListViewModel.h"

#import "YFSmsListCModel.h"

#define API @"/api/staffs/%ld/group/messages/"

#import "NSMutableDictionary+YFExtension.h"

@implementation YFSmsListViewModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self paraWithGym:gym];

    [para setInteger:self.page forKey:@"page"];
    
    [para.data setNotNilObje_FY:self.status toKey:@"status"];
    
    [para.data setObje_FY:@"-created_at" toKey:@"order_by"];
    
    [para.data setStringLengthNotZero_FY:self.searhStr toKey:@"q"];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,[NSString stringWithFormat:API,StaffId]];

    weakTypesYF
    [YFHttpService getList:urlString parameters:para.data modelClass:[YFSmsListCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {
        
        arrayModel.exArrayKey = @"group_messages";
        
        weakS.dataArray = arrayModel.listArray;
        weakS.arrayModel = arrayModel;
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

@end
