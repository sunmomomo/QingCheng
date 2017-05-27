//
//  YFSmsListVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFSmsListVC : YFBaseRefreshTBExtensionVC

/**
 * status=1 已发送, 2 草稿,nil 是全部
 */
@property(nonatomic, copy)NSString *status;

/**
 * 搜索 关键字
 */
@property(nonatomic, copy)NSString *searchStr;

@property(nonatomic, strong)Gym *gym;


@end
