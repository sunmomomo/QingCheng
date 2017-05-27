//
//  YFCreateNewSmsVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFSmsListCModel.h"

@interface YFCreateNewSmsVC : YFBaseVC

@property(nonatomic,strong)Gym *gym;

/**
 * 编辑模式下的 Model
 */
@property(nonatomic, strong)YFSmsListCModel *editModel;

@end
