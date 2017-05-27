//
//  GuideAddBatchController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Course.h"

@interface GuideAddBatchController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^addFinish)(CoursePlan *plan);

@end
