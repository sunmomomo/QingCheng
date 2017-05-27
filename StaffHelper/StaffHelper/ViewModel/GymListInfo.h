//
//  GymListInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface GymListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)NSMutableArray *powerGyms;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

+(instancetype)shareInfo;

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestWithBrand:(Brand*)brand result:(void (^)(BOOL success,NSString *error))result;

-(NSArray *)getLocalGymsWithGyms:(NSArray *)gyms;

-(NSArray *)getHavePowerGymsWithGyms:(NSArray *)gyms;

@end
