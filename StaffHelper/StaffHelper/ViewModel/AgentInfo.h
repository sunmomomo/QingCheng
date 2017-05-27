//
//  AgentInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

typedef enum : NSUInteger {
    AgentTypeRest = 0,
    AgentTypeGroup = 1,
    AgentTypePrivate = 2,
} AgentType;

@interface AgentInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,assign)AgentType type;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requestWithDate:(NSDate *)date andStudent:(Student*)student;

@end
