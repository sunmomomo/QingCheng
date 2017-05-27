//
//  CourseListController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

#import "Course.h"

@interface CourseListController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)CourseType courseType;

@end
