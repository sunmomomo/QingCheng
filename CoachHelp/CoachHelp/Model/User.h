//
//  User.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property(nonatomic,copy)NSString *username;

@property(nonatomic,copy)NSString *province;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *district;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,copy)NSString *wechat;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,strong)NSMutableArray *intro;

@property(nonatomic,copy)NSString *shortIntro;

@property(nonatomic,assign)NSInteger coachId;

@property(nonatomic,assign)NSInteger userId;

@property(nonatomic,assign)NSInteger totalCount;

@property(nonatomic,strong)NSArray *tags;

@property(nonatomic,assign)double courseScore;

@property(nonatomic,assign)double coachScore;

@property(nonatomic,copy)NSString *head;

@property(nonatomic,copy)NSURL *iconURL;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,strong)NSMutableArray *positions;

@end

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

