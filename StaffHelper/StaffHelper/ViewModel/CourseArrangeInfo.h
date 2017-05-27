//
//  CourseArrangeInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "Course.h"

#import "Coach.h"

@interface CourseArrangeInfo : NSObject

@property(nonatomic,copy)void(^privateFinish)(BOOL success);

@property(nonatomic,copy)void(^groupFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)NSArray *groups;

@property(nonatomic,strong)NSArray *privates;

@property(nonatomic,copy)NSURL *groupURL;

@property(nonatomic,copy)NSURL *privateURL;

-(void)requestDataWithGym:(Gym*)gym;

-(void)requestDataWithCourseType:(CourseType)courseType result:(void(^)(BOOL success,NSString *error))result;

@end
