//
//  MyPlanInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Plan.h"

@interface MyPlanInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gymPlans;

@property(nonatomic,strong)NSMutableArray *studyPlans;

@property(nonatomic,strong)NSMutableArray *customPlans;

@property(nonatomic,strong)NSMutableArray *allPlans;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestDataResult:(void(^)(BOOL success,NSString *error))result;

@end
