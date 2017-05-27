//
//  CheckinNotificationInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

@interface CheckinNotificationInfo : NSObject

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic, assign)NSInteger recieveNotifiCount;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requsetDataResult:(void(^)(BOOL success,NSString *error))result;

-(void)editNotificationSettingWithGym:(Gym *)gym result:(void(^)(BOOL success,NSString *error))result;

@end
