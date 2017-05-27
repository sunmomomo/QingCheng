//
//  CourseMeassureController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface CourseMeassureController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^chooseFinish)();

@end
