//
//  ChatListModel.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChatHeader.h"

#import "User.h"

@interface ChatListModel : NSObject

@property(nonatomic,assign)ChatListModelType type;

@property(nonatomic,strong)User *user;

@property(nonatomic,strong)ChatUserGroup *group;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,copy)NSString *shopName;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,copy)NSString *identifier;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger unreadCount;

@property(nonatomic,assign)NSInteger notificationId;

@property(nonatomic,strong)TIMConversation *conversation;

@end
