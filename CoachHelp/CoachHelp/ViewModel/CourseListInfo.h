//
//  CourseListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

@interface CourseListInfo : NSObject

@property(nonatomic,strong)NSArray *courses;

@property(nonatomic,strong)NSArray *groups;

@property(nonatomic,strong)NSArray *privates;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestGroupDataWithGym:(Gym *)gym;

-(void)requestPrivateDataWithGym:(Gym*)gym;

-(void)requestAllDataWithGym:(Gym*)gym;

-(void)createCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)editCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)changeGymWithCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)requestWithCourseType:(CourseType)type andIsAdd:(BOOL)isAdd andGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestReportDataWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

@end
