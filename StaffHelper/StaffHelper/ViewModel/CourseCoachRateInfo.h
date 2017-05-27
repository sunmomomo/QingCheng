//
//  CourseCoachRateInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/3.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Coach.h"

@interface CourseCoachRateInfo : NSObject

@property(nonatomic,strong)NSMutableArray *coaches;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCourse:(Course*)course andGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

@end
