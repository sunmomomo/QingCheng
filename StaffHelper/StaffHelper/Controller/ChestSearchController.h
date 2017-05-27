//
//  ChestSearchController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Chest.h"

@interface ChestSearchController : MOViewController

@property(nonatomic,strong)Chest *chest;

@property(nonatomic,copy)void(^chooseChestFinish)(Chest *chest);

@end
