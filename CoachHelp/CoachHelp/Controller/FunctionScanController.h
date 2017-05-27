//
//  FunctionScanController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface FunctionScanController : MOViewController

@property(nonatomic,copy)void(^scanSuccess)();

@property(nonatomic,copy)NSString *url;

@property(nonatomic,copy)NSString *module;

@end
