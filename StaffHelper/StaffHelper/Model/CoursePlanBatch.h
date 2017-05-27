//
//  CoursePlanBatch.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

#import "Coach.h"

#import "Yard.h"

#import "CardKind.h"

#import "CoursePlan.h"

#import "CoursePicture.h"

#import "OnlinePay.h"

@interface CoursePlanBatch : NSObject

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSArray *yards;

@property(nonatomic,strong)NSArray *cardKinds;

@property(nonatomic,strong)NSArray *onlinePays;

@property(nonatomic,strong)NSArray *plans;

@property(nonatomic,assign)NSInteger batchId;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,strong)NSMutableArray *pictures;

@property(nonatomic,copy)NSURL *courseURL;

@property(nonatomic,assign)BOOL isFree;

@property(nonatomic,assign)BOOL hasOrder;

@end
