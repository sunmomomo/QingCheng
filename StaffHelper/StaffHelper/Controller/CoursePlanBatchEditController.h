//
//  CoursePlanBatchEditController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "CoursePlanBatch.h"

#import "CoursePlanBatchesInfo.h"

@interface CoursePlanBatchEditController : MOViewController

@property(nonatomic,copy)void(^editFinish)(BOOL success);

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,strong)CoursePlanBatchesInfo *info;

@end
