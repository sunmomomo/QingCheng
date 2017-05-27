//
//  ReportInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Report.h"

#import "Gym.h"

@interface ReportInfo : NSObject

@property(nonatomic,strong)Report *weekReport;

@property(nonatomic,strong)Report *todayReport;

@property(nonatomic,strong)Report *monthReport;

@property(nonatomic,strong)Gym *gym;

@end
