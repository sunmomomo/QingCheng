//
//  UserDetailInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/23.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

@interface UserDetailInfo : NSObject

@property(nonatomic,strong)User *user;

@property(nonatomic,assign)NSInteger orderNumber;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)requestOrder:(void(^)(BOOL success,NSString *error))result;

@end
