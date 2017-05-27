//
//  User.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ChatUserGroup : NSObject

@property(nonatomic,copy)NSString *iconURL;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *groupId;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,assign)NSInteger userCount;

@end

@interface UserGroup : NSObject

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,copy)NSString *header;

@end

@interface GymPosition : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger gymId;

@end

@interface User : NSObject

@property(nonatomic,copy)NSString *head;

@property(nonatomic,copy)NSString *username;

@property(nonatomic,assign)NSInteger userId;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,strong)NSMutableArray *positions;

@property(nonatomic,assign)SexType sex;

@end
