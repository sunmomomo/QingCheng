//
//  CoursePlan.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Coach.h"

#import "Yard.h"

#import "CardKind.h"

#import "OnlinePay.h"

@class Course;

@interface CoursePlan : NSObject<NSCoding>

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Course *course;

@property(nonatomic,assign)NSInteger planId;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *week;

@property(nonatomic,strong)NSArray *yards;

@property(nonatomic,strong)NSArray *cardKinds;

@property(nonatomic,strong)NSArray *onlinePays;

@property(nonatomic,strong)NSArray *plans;

@property(nonatomic,assign)BOOL isFree;

@property(nonatomic,assign)BOOL hasOrder;

@property(nonatomic,strong)NSMutableArray *weeks;

@property(nonatomic,assign)BOOL canEdit;

@property(nonatomic,assign)BOOL autoFill;

-(NSArray*)compareWithPlan:(CoursePlan*)plan;

@end
