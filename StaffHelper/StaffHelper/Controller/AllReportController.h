//
//  AllReportController.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "AllReportInfo.h"

@interface AllReportController : MOViewController

@property(nonatomic,assign)ReportInfoType type;

@property(nonatomic,assign)BOOL isGym;

@property(nonatomic,strong)Gym *gym;

@end
