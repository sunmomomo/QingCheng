//
//  ReportFilterController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

#import "ReportFilter.h"

#import "Student.h"

#import "ORDetailInfo.h"

@interface ReportFilterController : MOViewController

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)ReportFilter *filter;

@property(nonatomic,strong)ORDetailInfo *info;

@property(nonatomic,copy)void(^customFinish)(ReportFilter* filter);

@property(nonatomic,copy)NSString *maxDate;

@property(nonatomic,copy)NSString *minDate;

@end
