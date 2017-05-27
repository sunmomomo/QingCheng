//
//  MyGymInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface MyGymInfo : NSObject

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,copy)void(^request)(BOOL success);

-(void)requestData;

@end
