//
//  AgentInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface AgentInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,assign)AgentType type;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestReult:(void(^)(BOOL success,NSString *error))result;

@end
