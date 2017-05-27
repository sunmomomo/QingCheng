//
//  CustomReportController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

#import "ORDetailInfo.h"

#import "ReportFilter.h"

#import "Student.h"

@interface CustomReportController : MOViewController

@property(nonatomic,assign)ReportInfoType type;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)ReportFilter *filter;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,copy)void(^customFinish)(ReportFilter* filter);

@end
