//
//  ProgrammeInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Programme.h"

@interface ProgrammeInfo : NSObject

@property(nonatomic,strong)NSDate *startDate;

@property(nonatomic,strong)NSDate *endDate;

@property(nonatomic,assign)BOOL havePrivate;

@property(nonatomic,strong)NSMutableArray *programmes;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(instancetype)initWithDate:(NSDate*)date;

-(void)requestDataResult:(void(^)(BOOL success,NSString*error))result;

-(void)requestWeekDataWithDate:(NSDate *)date result:(void(^)(BOOL success,NSString*error))result;

-(NSArray *)getShowDataWithGym:(Gym*)gym;

-(void)requestEventInfoResult:(void(^)(BOOL success,NSString*error))result;

-(BOOL)havePrivateWithGym:(Gym*)gym;

@end
