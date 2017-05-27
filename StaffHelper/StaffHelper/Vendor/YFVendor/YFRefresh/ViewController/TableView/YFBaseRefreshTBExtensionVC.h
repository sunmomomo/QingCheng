//
//  YFBaseRefreshTBExtensionVC.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/16.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseRefreshTBVC.h"
#import "YFTBBaseDatasource.h"
#import "YFTBBaseDelegate.h"

@interface YFBaseRefreshTBExtensionVC : YFBaseRefreshTBVC

@property(nonatomic,strong)YFTBBaseDatasource *dataSourceTB;
@property(nonatomic,strong)YFTBBaseDelegate *delegateTB;


@end
