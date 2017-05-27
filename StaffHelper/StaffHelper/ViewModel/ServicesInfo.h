//
//  ServicesInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface ServicesInfo : NSObject

@property(nonatomic,strong)void(^callBackSuccess)();

@property(nonatomic,strong)void(^callBackFailure)();

@property(nonatomic,strong)NSArray *services;

+(instancetype)shareInfo;

-(void)requestSuccess:(void(^)())success Failure:(void(^)())failure;

@end
