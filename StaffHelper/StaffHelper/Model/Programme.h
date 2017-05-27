//
//  Programme.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "Coach.h"

typedef enum : NSUInteger {
    ProgrammeStyleCompleted,
    ProgrammeStyleIncompleted,
    ProgrammeStyleRest,
    ProgrammeStyleRestandCompleted
} ProgrammeStyle;

@interface Programme : NSObject

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSArray *orders;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,assign)NSInteger total;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,assign)NSInteger programmeId;

@property(nonatomic,assign)ProgrammeStyle style;

@property(nonatomic,strong)UIColor *completedColor;

-(NSString *)ordersDescription;

@end
