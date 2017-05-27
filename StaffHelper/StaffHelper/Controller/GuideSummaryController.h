//
//  GuideSummaryController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

@interface GuideSummaryController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)void(^fillFinish)(Gym *gym);

@end
