//
//  YFBaseRefreshTBExtensionVC.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"


@interface YFBaseRefreshTBExtensionVC ()


@end

@implementation YFBaseRefreshTBExtensionVC


-(void)setScrollViewDelegateFY
{
    self.delegateTB = [self delegateTBYF];
    self.dataSourceTB = [self dataSourceTBYF];
    self.baseTableView.delegate = self.delegateTB;
    self.baseTableView.dataSource = self.dataSourceTB;
}

//#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
    return [YFTBBaseDatasource tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    } currentVC:self];
}

-(YFTBBaseDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBBaseDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}


@end
