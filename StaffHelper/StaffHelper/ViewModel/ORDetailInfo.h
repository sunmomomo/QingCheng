//
//  ORDetailInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "OrderReport.h"

#import "SellReport.h"

#import "CheckinReport.h"

#import "Gym.h"

#import "ReportFilter.h"

#import "CourseReportCourse.h"

#import "CourseReportCardKind.h"

#import "CheckinReportCardKind.h"

#import "SellReportTrade.h"

#import "SellReportCardKind.h"

@interface ORDetailInfo : NSObject

@property(nonatomic,strong)NSMutableArray *reports;

@property(nonatomic,strong)NSMutableArray *showReports;

@property(nonatomic,assign)NSInteger courseCount;

@property(nonatomic,assign)NSInteger orderCount;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,assign)NSInteger cost;

@property(nonatomic,strong)NSArray *reportCardKinds;

@property(nonatomic,strong)NSArray *reportCourses;

@property(nonatomic,strong)NSArray *reportTrades;

@property(nonatomic,strong)NSMutableArray *users;

@property(nonatomic,strong)NSMutableArray *courses;

@property(nonatomic,strong)NSMutableArray *groups;

@property(nonatomic,strong)NSMutableArray *privates;

@property(nonatomic,strong)NSMutableArray *cardKinds;

@property(nonatomic,strong)NSMutableArray *prepaidCardKinds;

@property(nonatomic,strong)NSMutableArray *timeCardKinds;

@property(nonatomic,strong)NSMutableArray *countCardKinds;

@property(nonatomic,strong)NSMutableArray *onlineCardKinds;

@property(nonatomic,strong)NSMutableArray *sellers;

@property(nonatomic,strong)NSMutableArray *coaches;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithFilter:(ReportFilter*)filter andGym:(Gym *)gym result:(void(^)(BOOL success,NSString *error))result;

+(instancetype)exportExcelWithFilter:(ReportFilter*)filter gym:(Gym *)gym title:(NSString *)title email:(NSString *)email result:(void(^)(BOOL success,NSString *error))result;

-(void)filterWithFilter:(ReportFilter*)filter;

@end
