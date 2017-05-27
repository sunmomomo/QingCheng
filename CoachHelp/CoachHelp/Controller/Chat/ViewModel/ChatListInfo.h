//
//  ChatListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "ChatListModel.h"

typedef void(^UsersCallBack)(BOOL success,NSString*error,NSArray*users);

@interface ChatListInfo : NSObject

@property(nonatomic,strong)ChatUserGroup *group;

@property(nonatomic,copy)NSString *chatId;

@property(nonatomic,strong)NSMutableArray *systemArray;

@property(nonatomic,strong)NSMutableArray *chatArray;

@property(nonatomic,assign)NSInteger unReadNumber;

@property(nonatomic,strong)RequestCallBack callBack;

@property(nonatomic,strong)UsersCallBack usercb;

-(void)createChatWithUsers:(NSArray *)users result:(UsersCallBack)result;

-(void)requestSystemResult:(RequestCallBack)result;

-(void)requestChatResult:(RequestCallBack)result;

+(void)setDeleteModelIdWithType:(ChatListModelType)type andNotificationId:(NSInteger)notificationId;

-(void)readAllResult:(RequestCallBack)result;

@end
