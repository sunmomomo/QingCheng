//
//  CardKindListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

@interface CardKindListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *cardKinds;

@property(nonatomic,strong)NSMutableArray *prepaidCardKinds;

@property(nonatomic,strong)NSMutableArray *timeCardKinds;

@property(nonatomic,strong)NSMutableArray *countCardKinds;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(NSArray*)getShowArrayWithGym:(Gym*)gym;

-(NSArray*)getShowArrayWithType:(CardKindType)type;

-(NSArray *)getShowArrayWithSingle:(BOOL)single andType:(CardKindType)type;

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestCardCreateCardKindsWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestReportCardKindsWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestCheckinReportCardKindsWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

-(void)requestCourseWayCardKindsWithCourseType:(CourseType)courseType andIsEdit:(BOOL)isEdit andGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;

@end
