//
//  YFBaseRefreshTBVC.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseRefreshVC.h"
#import "MJRefresh.h"


@interface YFBaseRefreshTBVC : YFBaseRefreshVC<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic, strong)UITableView *baseTableView;


@end
