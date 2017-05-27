//
//  CoursePlanWayController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CoursePlanBatch.h"

@interface CoursePlanWayController : MOViewController

@property(nonatomic,copy)void(^setFinish)(CoursePlanBatch *batch);

@property(nonatomic,copy)void(^setPlanFinish)(CoursePlan *plan);

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,strong)CoursePlan *plan;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL isAdd;

@end
