//
//  NSObject+TBYFDelegate.h
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "YFTBBaseDatasource.h"
#import "YFTBBaseDelegate.h"
#import "YFTBSectionsDelegate.h"
#import "YFTBSectionsDataSource.h"


#import "YFBaseVC.h"

@interface NSObject (TBYFDelegate)

/**
 * 第一步 实现 这个Block
 [self setDataArray:^NSMutableArray *{
 return weakS.baseDataArray;// 数据源
 }]
 */
@property(nonatomic,weak)DataArrayBLock dataArrayYF;
@property(nonatomic,weak)YFBaseVC* currentVCYF;


@property(nonatomic,strong)YFTBBaseDatasource *dataSourceSiTBYF;
@property(nonatomic,strong)YFTBBaseDelegate *delegateSiTBYF;

@property(nonatomic,strong)YFTBBaseDatasource *dataSourceSectionsTBYF;
@property(nonatomic,strong)YFTBBaseDelegate *delegateSectionsTBYF;

@end
