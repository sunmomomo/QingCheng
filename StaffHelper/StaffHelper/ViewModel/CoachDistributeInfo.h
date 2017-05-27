//
//  CoachDistributeInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoachDistributeInfo : NSObject

@property(nonatomic,strong)RequestCallBack callBack;

@property(nonatomic,strong)NSMutableArray *coaches;

-(void)requestWithGym:(Gym*)gym result:(RequestCallBack)result;

-(void)deleteUser:(Student *)user withCoach:(Coach*)coach withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)deleteUsers:(NSArray *)users withCoach:(Coach*)coach withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)changeUsers:(NSArray *)users withOriginalCoach:(Coach*)originalCoach withCoaches:(NSArray*)coaches withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)addUsers:(NSArray*)users withCoach:(Coach*)coach withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

@end
