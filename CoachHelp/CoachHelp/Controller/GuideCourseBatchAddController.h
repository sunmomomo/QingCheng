//
//  GuideCourseBatchAddController.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

@interface GuideCourseBatchAddController : MOViewController

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)void(^addFinish)(CoursePlan *plan);

@end
