//
//  GymProInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/2/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GymPay.h"

@interface GymProInfo : NSObject

@property(nonatomic,strong)NSMutableArray *pays;

@property(nonatomic,copy)NSURL *payURL;

@property(nonatomic,copy)NSString *systemEnd;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)proGymWithGymPay:(GymPay*)pay result:(void(^)(BOOL success,NSString *error))result;

-(void)tryGymResult:(void(^)(BOOL success,NSString *error))result;

@end
