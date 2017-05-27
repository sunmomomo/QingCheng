//
//  CoachEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Coach.h"

@interface CoachEditController : MOViewController

@property(nonatomic,copy)void(^editFinish)();

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Coach *coach;

@end
