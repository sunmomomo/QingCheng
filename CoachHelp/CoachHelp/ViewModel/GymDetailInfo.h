//
//  GymDetailInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/30.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "Course.h"

@interface GymDetailInfo : NSObject

@property(nonatomic,strong)NSMutableArray *groupCourses;

@property(nonatomic,strong)NSMutableArray *privateCourses;

@property(nonatomic,assign)NSInteger privateCount;

@property(nonatomic,assign)NSInteger groupCount;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)editGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)quitGymResult:(void(^)(BOOL success,NSString *error))result;

@end
