//
//  GymListController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface GymListController : MOViewController

@property(nonatomic,strong)Brand *brand;

+(GymListController *)sharedController;

@end
