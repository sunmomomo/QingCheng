//
//  CourseRateInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CourseRate.h"

@interface CourseRateInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)NSMutableArray *gyms;

-(void)requestWithCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

@end
