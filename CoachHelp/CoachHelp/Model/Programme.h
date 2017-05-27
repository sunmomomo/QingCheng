//
//  Programme.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

typedef enum : NSUInteger {
    ProgrammeStyleNormal,
    ProgrammeStyleRest,
} ProgrammeStyle;

@interface Programme : NSObject

@property(nonatomic,assign)CourseType courseType;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)NSString *shopName;

@property(nonatomic,strong)NSArray *orders;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,assign)NSInteger total;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,assign)NSInteger programmeId;

@property(nonatomic,assign)ProgrammeStyle style;

@property(nonatomic,strong)UIColor *completedColor;

@property(nonatomic,copy)NSString *clash;

@property(nonatomic,assign)BOOL completed;

@property(nonatomic,assign)NSInteger sameTimeProgramme;

@property(nonatomic,assign)NSInteger preTimeProgramme;

-(BOOL)haveClashWithProgramme:(Programme*)programme;

-(NSString *)ordersDescription;

@end
