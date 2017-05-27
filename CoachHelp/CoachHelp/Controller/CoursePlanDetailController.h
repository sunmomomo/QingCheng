//
//  CoursePlanDetailController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CoursePlanBatch.h"

@interface CoursePlanDetailController : MOViewController

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,copy)void(^editFinish)();

@end
