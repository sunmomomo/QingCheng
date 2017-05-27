//
//  Record.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

@interface Record : NSObject

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,copy)NSString *coachName;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *year;

@property(nonatomic,assign)BOOL showDate;

@property(nonatomic,assign)NSInteger recordId;

@property(nonatomic,copy)NSURL *url;

@end
