//
//  ChatInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "ChatHeader.h"

@interface ChatInfo : NSObject

@property(nonatomic,strong)User *mine;

@property(nonatomic,strong)NSArray *chats;

@property(nonatomic,strong)RequestCallBack callBack;

-(void)requestWithModel:(ChatListModel *)model result:(RequestCallBack)result;

-(void)requestForwardWithModel:(ChatListModel *)model result:(RequestCallBack)result;

-(void)requestGroupDetailInfoWithModel:(ChatListModel*)model result:(RequestCallBack)result;

-(void)quitWithModel:(ChatListModel*)model result:(RequestCallBack)result;

-(void)changeName:(NSString *)name withModel:(ChatListModel*)model result:(RequestCallBack)result;

-(void)removeUsers:(NSArray*)users withModel:(ChatListModel*)model result:(RequestCallBack)result;

-(void)addUsers:(NSArray*)users withModel:(ChatListModel*)model result:(RequestCallBack)result;

-(void)setReadAtIndex:(NSInteger)index;

@end
