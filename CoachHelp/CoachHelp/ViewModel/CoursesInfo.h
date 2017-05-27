//
//  CoursesInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/15.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

#import "Gym.h"

#import "Student.h"

@interface CoursesInfo : NSObject

@property(nonatomic,strong)NSMutableArray *courses;

@property(nonatomic,strong)NSMutableArray *users;

@property(nonatomic,copy)void(^request)(BOOL success);

-(instancetype)initWithGym:(Gym*)gym;

@end
