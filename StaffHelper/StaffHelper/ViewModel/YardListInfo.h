//
//  YardListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Yard.h"

@interface YardListInfo : NSObject

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)NSArray *allYards;

@property(nonatomic,strong)NSArray *privateYards;

@property(nonatomic,strong)NSArray *groupYards;

-(void)requestWithGym:(Gym*)gym;

-(void)addYard:(Yard*)yard result:(void(^)(BOOL success,NSString *error))result;

-(void)changeYard:(Yard*)yard result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteYard:(Yard*)yard result:(void(^)(BOOL success,NSString *error))result;

-(void)requestDataWithCourseType:(CourseType)type andIsAdd:(BOOL)isAdd andGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

@end
