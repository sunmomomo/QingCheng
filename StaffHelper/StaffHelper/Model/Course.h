//
//  Course.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreData/CoreData.h>

#import "CoursePlan.h"

#import "Coach.h"

#import "CardKind.h"

#import "Yard.h"

#import "Gym.h"

#import "CourseRate.h"

#import "CourseMeassure.h"

typedef enum : NSUInteger {
    CourseTypeGroup = 1,
    CourseTypePrivate = 2,
    CourseTypeCheckin = 3,// 签到，课程里没有这个分类
    CourseTypeNone = 0,
} CourseType;

@interface Course : NSObject<NSCoding>

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)NSInteger courseId;

@property(nonatomic,assign)NSInteger during;

@property(nonatomic,assign)NSInteger capacity;

@property(nonatomic,assign)CourseType type;

@property(nonatomic,strong)NSMutableArray *coursePlans;

@property(nonatomic,copy)NSString *coursePlanStart;

@property(nonatomic,copy)NSString *coursePlanEnd;

@property(nonatomic,strong)NSMutableArray *coaches;

@property(nonatomic,strong)NSMutableArray *cardKinds;

@property(nonatomic,strong)NSMutableArray *yards;

@property(nonatomic,assign)BOOL wayOK;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)NSInteger minNumber;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,assign)NSInteger courseNum;

@property(nonatomic,strong)NSMutableArray *covers;

@property(nonatomic,strong)CourseRate *rate;

@property(nonatomic,strong)CourseMeassure *meassure;

@property(nonatomic,copy)NSURL *summaryURL;

@property(nonatomic,copy)NSString *htmlData;

@property(nonatomic,assign)BOOL customCover;

-(instancetype)initNewCourse;

@end
