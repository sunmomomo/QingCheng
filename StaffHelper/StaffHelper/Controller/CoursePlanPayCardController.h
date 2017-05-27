//
//  CoursePlanPayCardController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/21.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CoursePlanBatch.h"

@interface CoursePlanPayCardController : MOViewController

@property(nonatomic,strong)CoursePlan *plan;

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,assign)BOOL isAdd;

@property(nonatomic,copy)void(^setFinish)(CoursePlanBatch *batch);

@property(nonatomic,copy)void(^setPlanFinish)(CoursePlan *plan);

@end
