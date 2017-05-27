//
//  CoachListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Coach.h"

@interface CoachListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *coaches;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requsetWithGym:(Gym*)gym andSearchStr:(NSString*)searchStr;

-(void)createCoach:(Coach *)coach withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)editCoach:(Coach*)coach withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteCoach:(Coach*)coach withGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestDataWithCourseType:(CourseType)type andIsAdd:(BOOL)isAdd andGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestReportDataWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

@end
