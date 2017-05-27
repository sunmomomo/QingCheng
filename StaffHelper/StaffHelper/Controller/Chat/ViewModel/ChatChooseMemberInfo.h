//
//  ChatChooseMemberInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "ChatMemberGymModel.h"

@interface ChatChooseMemberInfo : NSObject

@property(nonatomic,strong)NSArray *gyms;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,strong)NSArray *groups;

@property(nonatomic,strong)NSMutableArray *heads;

@property(nonatomic,strong)RequestCallBack callBack;

-(void)requestResult:(RequestCallBack)result;

@end
