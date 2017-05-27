//
//  AdminController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Staff.h"

@interface AdminController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Staff *admin;

@property(nonatomic,copy)void(^editFinish)();

@end
