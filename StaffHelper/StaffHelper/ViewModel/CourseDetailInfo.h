//
//  CourseDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

@interface CourseDetailInfo : NSObject

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)NSMutableArray *covers;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

@end
