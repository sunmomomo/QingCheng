//
//  GuideCoachController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface GuideCoachController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^chooseFinish)();

@end
