//
//  ChatHeader.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#ifndef ChatHeader_h
#define ChatHeader_h

typedef enum : NSUInteger {
    ChatListModelTypeGym = 3,
    ChatListModelTypeSystem = 2,
    ChatListModelTypeStudy = 4,
    ChatListModelTypeCheckin = 1,
    ChatListModelTypeMatch = 5,
    ChatListModelTypeReply = 6,
    ChatListModelTypeChatSingle = 7,
    ChatListModelTypeChatGroup =8,
} ChatListModelType;

typedef enum : NSUInteger {
    ChatTypeLabel,
    ChatTypeImage,
    ChatTypeVoice,
    ChatTypeTime,
    ChatTypeSystem,
} ChatType;

typedef enum : NSUInteger {
    ChatUserTypeMine,
    ChatUserTypeOther,
} ChatUserType;


@class ChatListModel;

@class ChatModel;

#import <TLSSDK/TLSHelper.h>

#import <QALSDK/QalSDKProxy.h>

#import <ImSDK/ImSDK.h>

#import <AVFoundation/AVFoundation.h>

#import "UpYun.h"

#import "MOActionSheet.h"

#import "KeyboardManager.h"


#import "ChatInfo.h"

#import "ChatListInfo.h"

#import "ChatChooseMemberInfo.h"

#import "ChatMemberGroupInfo.h"


#import "ChatToolView.h"

#import "ChatChooseView.h"

#import "ChatSoundRecorder.h"

#import "ChatMemberChoosedView.h"

#import "ChooseMemberGroupHeader.h"


#import "ChatCell.h"

#import "ChatListTopCell.h"

#import "ChatListBotCell.h"

#import "ChatMemberCell.h"

#import "ChatChooseGymCell.h"

#import "ChatChooseMemberCell.h"

#import "ChatChooseMemberGroupCell.h"


#import "ChatController.h"

#import "ChatNameController.h"

#import "ChatChooseMemberController.h"

#import "ChatMemberChangeController.h"

#import "ChatChooseMemberGroupController.h"

#endif /* ChatHeader_h */
