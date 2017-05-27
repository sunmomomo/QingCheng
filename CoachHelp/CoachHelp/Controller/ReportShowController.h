//
//  ReportShowController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "Gym.h"

#import "ORDetailInfo.h"

typedef enum : NSUInteger {
    ReportTypeWeek,
    ReportTypeDay,
    ReportTypeMonth,
    ReportTypeOther,
} ReportType;

@interface ReportShowController : MOViewController

@property(nonatomic,assign)ReportType type;

@property(nonatomic,assign)BOOL isGym;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)ReportFilter *filter;

@property(nonatomic,copy)NSString *maxDate;

@property(nonatomic,copy)NSString *minDate;

@end
