//
//  YFSmsDetailVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

#import "YFSmsListCModel.h"

@interface YFSmsDetailVC : YFBaseRefreshTBExtensionVC

@property(nonatomic, strong)NSString *message_id;

@property(nonatomic, assign)YFSmsType smsType;

@property(nonatomic, strong)Gym *gym;

@end
