//
//  ChatController.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOViewController.h"

#import "ChatHeader.h"

typedef enum : NSUInteger {
    SendText,
    SendVoice,
     SendImage
} MySendContentType;

@interface ChatController : MOViewController

@property(nonatomic,strong)ChatListModel *chatListModel;

- (void)onNewMessage:(TIMMessage*) msg;

@end
