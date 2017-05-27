//
//  GuideWayController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Course.h"

@interface GuideWayController : MOViewController

@property(nonatomic,copy)void(^setFinish)();

@property(nonatomic,strong)Course *course;

@end
