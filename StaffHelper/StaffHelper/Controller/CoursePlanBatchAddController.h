//
//  CoursePlanBatchAddController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Course.h"

@interface CoursePlanBatchAddController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)CoursePlan *plan;

@property(nonatomic,assign)NSInteger index;

@property(nonatomic,copy)void(^addFinish)(CoursePlan *plan);

@end
