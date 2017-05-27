//
//  Coach.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Enum.h"

#import "Gym.h"

#import "CourseRate.h"

#import "CountryChooseTextField.h"

typedef enum : NSUInteger {
    CoachDistributeTypeNone,
    CoachDistributeTypeNormal,
} CoachDistributeType;

@interface Coach : NSObject<NSCoding>

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,assign)NSInteger coachId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,strong)CountryPhone *country;

@property(nonatomic,copy)NSURL *iconUrl;

@property(nonatomic,copy)NSString *avatar;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)NSInteger courseCount;

@property(nonatomic,assign)NSInteger serviceCount;

@property(nonatomic,assign)float rateScore;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,strong)CourseRate *rate;

@property(nonatomic,assign)CoachDistributeType type;

@property(nonatomic,strong)NSArray *users;

@end
