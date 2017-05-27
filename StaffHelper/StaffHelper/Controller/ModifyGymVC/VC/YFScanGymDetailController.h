//
//  YFScanGymDetailController.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/4/18.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

/**
 * 没有权限 只能查看 场馆信息
 */

@interface YFScanGymDetailController : YFBaseRefreshTBExtensionVC

// Copy 的gym,用来修改操作
@property(nonatomic, strong)Gym *gym;

@end
