//
//  CourseEditController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Course.h"

@interface CourseEditController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)void(^editFinish)();

@end
