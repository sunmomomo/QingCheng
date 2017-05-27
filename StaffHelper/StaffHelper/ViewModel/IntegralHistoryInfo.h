//
//  IntegralHistoryInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IntegralHistory.h"

@interface IntegralHistoryInfo : NSObject

@property(nonatomic,strong)NSMutableArray *histories;

@property(nonatomic,assign)float integral;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithStudent:(Student*)student result:(void(^)(BOOL success,NSString *error))result;

-(void)requestHistoriesWithStudent:(Student*)student result:(void(^)(BOOL success,NSString *error))result;

-(void)changeIntegral:(float)integral withStudent:(Student*)student andSummary:(NSString *)summary result:(void(^)(BOOL success,NSString *error))result;

@end
