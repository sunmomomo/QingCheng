//
//  StaffEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Staff.h"

@interface StaffEditController : MOViewController

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Staff *staff;

@property(nonatomic,copy)void(^editFinish)();

@end
