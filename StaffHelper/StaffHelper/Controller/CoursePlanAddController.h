//
//  CoursePlanAddController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Course.h"

#import "Coach.h"

@interface CoursePlanAddController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^addFinish)();

@end
