//
//  Work.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface Work : NSObject

@property(nonatomic,assign)NSInteger workId;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *job;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,copy)NSString *performance;

@property(nonatomic,copy)NSString *comRemark;

@property(nonatomic,copy)NSString *startTime;

@property(nonatomic,copy)NSString *endTime;

@property(nonatomic,assign)NSInteger group_user;

@property(nonatomic,assign)NSInteger group_course;

@property(nonatomic,assign)NSInteger private_user;

@property(nonatomic,assign)NSInteger private_course;

@property(nonatomic,assign)NSInteger sale;

@property(nonatomic,assign)BOOL isVerified;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)NSString *descriptions;

@property(nonatomic,assign)BOOL isHide;

@property(nonatomic,assign)BOOL showGroup;

@property(nonatomic,assign)BOOL showPrivate;

@property(nonatomic,assign)BOOL showSale;

//@property(nonatomic,strong)NSArray *classes;

//@property(nonatomic,strong)NSArray *stuRemarks;

@end
