//
//  ChatListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/15.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatListInfo.h"

#import "MessageInfo.h"

#import "MOTool.h"

#import "ChatUserManager.h"

#import "StaffUserInfo.h"

#define SigAPI @"/api/im/usersig/"

#define NotificationAPI @"/api/v2/notifications/index/"

#define ClearAPI @"/api/v2/notifications/"

@interface ChatListDeleteModel : NSObject<NSCoding>

@property(nonatomic,assign)NSInteger gymId;

@property(nonatomic,assign)NSInteger systemId;

@property(nonatomic,assign)NSInteger studyId;

@property(nonatomic,assign)NSInteger checkinId;

@property(nonatomic,assign)NSInteger matchId;

@property(nonatomic,assign)NSInteger replyId;

@end

@implementation ChatListDeleteModel

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.gymId forKey:@"gymId"];
    
    [aCoder encodeInteger:self.systemId forKey:@"systemId"];
    
    [aCoder encodeInteger:self.studyId forKey:@"studyId"];
    
    [aCoder encodeInteger:self.checkinId forKey:@"checkinId"];
    
    [aCoder encodeInteger:self.replyId forKey:@"replyId"];
    
    [aCoder encodeInteger:self.matchId forKey:@"matchId"];
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super init];
    
    if (self) {
        
        self.gymId = [coder decodeIntegerForKey:@"gymId"];
        
        self.systemId = [coder decodeIntegerForKey:@"systemId"];
        
        self.studyId = [coder decodeIntegerForKey:@"studyId"];
        
        self.checkinId = [coder decodeIntegerForKey:@"checkinId"];
        
        self.replyId = [coder decodeIntegerForKey:@"replyId"];
        
        self.matchId = [coder decodeIntegerForKey:@"matchId"];
        
    }
    
    return self;
    
}

@end

@implementation ChatListInfo

-(void)requestSystemResult:(RequestCallBack)result
{
    
    self.callBack = result;
    
    if (!UserId) {
        
        if (self.callBack) {
            
            self.callBack(NO, @"尚未登录");
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    NSString *str = @"{\"gym\":[11,12,13,15],\"system\":[20002],\"study\":[10001,10002,10003,10004,10005,10006,10007,10008],\"checkin\":[1,2,8,9],\"reply\":[20003],\"match\":[20004]}";
    
    [MOAFHelp AFGetHost:ROOT bindPath:NotificationAPI param:@{@"type_json":str} success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        __block NSInteger unread = 0;
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            self.systemArray = [NSMutableArray array];
            
            NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:@"chat_list_delete_model"];
            
            ChatListDeleteModel *deleteModel;
            
            if (data) {
                
                deleteModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
                
            }
            
            if (!deleteModel) {
                
                deleteModel = [[ChatListDeleteModel alloc]init];
                
            }
            
            [responseDic[@"data"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                
                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                
                dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                
                if ([obj[@"notification"] isKindOfClass:[NSDictionary class]]) {
                    
                    if ([[obj[@"notification"] allKeys]count]) {
                        
                        ChatListModel *model = [[ChatListModel alloc]init];
                        
                        model.content = obj[@"notification"][@"title"];
                        
                        model.date = [dateFormatter dateFromString:[obj[@"notification"][@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "]];
                        
                        model.time = [MOTool formatTimeStringWithDate:model.date];
                        
                        model.unreadCount = [obj[@"unread"]integerValue];
                        
                        model.notificationId = [obj[@"notification"][@"id"]integerValue];
                        
                        if ([obj[@"key"] isEqualToString:@"gym"]) {
                            
                            model.type = ChatListModelTypeGym;
                            
                            model.shopName = obj[@"notification"][@"shop_name"];
                            
                            if (model.notificationId != deleteModel.gymId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.gymId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }else if ([obj[@"key"]isEqualToString:@"system"]){
                            
                            model.type = ChatListModelTypeSystem;
                            
                            if (model.notificationId != deleteModel.systemId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.systemId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }else if ([obj[@"key"]isEqualToString:@"study"]){
                            
                            model.type = ChatListModelTypeStudy;
                            
                            model.shopName = obj[@"notification"][@"shop_name"];
                            
                            if (model.notificationId != deleteModel.studyId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.studyId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }else if ([obj[@"key"]isEqualToString:@"checkin"]){
                            
                            model.type = ChatListModelTypeCheckin;
                            
                            model.shopName = obj[@"notification"][@"shop_name"];
                            
                            if (model.notificationId != deleteModel.checkinId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.checkinId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }else if ([obj[@"key"]isEqualToString:@"reply"]){
                            
                            model.type = ChatListModelTypeReply;
                            
                            if (model.notificationId != deleteModel.replyId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.replyId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }else if ([obj[@"key"]isEqualToString:@"match"]){
                            
                            model.type = ChatListModelTypeMatch;
                            
                            if (model.notificationId != deleteModel.matchId) {
                                
                                if (model.unreadCount) {
                                    
                                    unread ++;
                                    
                                }
                                
                                deleteModel.matchId = 0;
                                
                                [self.systemArray addObject:model];
                                
                            }
                            
                        }
                        
                    }
                    
                }
                
            }];
            
            NSData *nowData = [NSKeyedArchiver archivedDataWithRootObject:deleteModel];
            
            [[NSUserDefaults standardUserDefaults] setObject:nowData forKey:@"chat_list_delete_model"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            self.unReadNumber = unread;
            
            NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
            
            [self.systemArray sortUsingDescriptors:@[descriptor]];
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO, error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)requestChatResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    NSString *user = [[TIMManager sharedInstance]getLoginUser];
    
    if (!UserId) {
        
        if (self.callBack) {
            
            self.callBack(NO, @"尚未登录");
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    if (!user) {
        
        NSString *userSig = UserSig;
        
        if (userSig.length) {
            
            TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
            
            login_param.accountType = [NSString stringWithFormat:@"%ld",(long)TencentIMType];
            login_param.identifier = [NSString stringWithFormat:@"%@%ld",ChatPrefix,UserId];
            login_param.userSig = userSig;
            
            login_param.appidAt3rd = [NSString stringWithFormat:@"%ld",(long)TencentIMID];
            
            login_param.sdkAppId = TencentIMID;
            
            [[TIMManager sharedInstance] login: login_param succ:^(){
                
                NSData *deviceToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"];
                
                NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
                
                [[TIMManager sharedInstance] log:TIM_LOG_INFO tag:@"SetToken" msg:[NSString stringWithFormat:@"My Token is :%@", token]];
                TIMTokenParam *param = [[TIMTokenParam alloc] init];
                
                param.busiId = TIMPushID;
                
                [param setToken:deviceToken];
                
                [[TIMManager sharedInstance] setToken:param succ:^{
                    
                } fail:^(int code, NSString *msg) {
                    
                }];
                
                StaffUserInfo *userInfo = [[StaffUserInfo alloc]init];
                
                [userInfo requestResult:^(BOOL success, NSString *error) {
                    
                    [[TIMFriendshipManager sharedInstance]SetNickname:userInfo.staff.name succ:^{
                        
                        [[TIMFriendshipManager sharedInstance]SetFaceURL:userInfo.staff.iconUrl.absoluteString succ:^{
                            
                            [self getMessage];
                            
                        } fail:^(int code, NSString *msg) {
                            
                            if (self.callBack) {
                                
                                self.callBack(NO, msg);
                                
                                self.callBack = nil;
                                
                            }
                            
                        }];
                        
                    } fail:^(int code, NSString *msg) {
                        
                        if (self.callBack) {
                            
                            self.callBack(NO, msg);
                            
                            self.callBack = nil;
                            
                        }
                        
                    }];
                    
                }];
                
            } fail:^(int code, NSString * err) {
                
                if (code == 70013 || code == 70009) {
                    
                    ChatListInfo *info = [[ChatListInfo alloc]init];
                    
                    [info requestSigResult:^(BOOL success, NSString *error) {
                        
                        if (success) {
                            
                            TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
                            
                            login_param.accountType = [NSString stringWithFormat:@"%ld",(long)TencentIMType];
                            login_param.identifier = [NSString stringWithFormat:@"%@%ld",ChatPrefix,UserId];
                            login_param.userSig = userSig;
                            
                            login_param.appidAt3rd = [NSString stringWithFormat:@"%ld",(long)TencentIMID];
                            
                            login_param.sdkAppId = TencentIMID;
                            
                            [[TIMManager sharedInstance] login: login_param succ:^(){
                                
                                NSData *deviceToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"];
                                
                                NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
                                
                                [[TIMManager sharedInstance] log:TIM_LOG_INFO tag:@"SetToken" msg:[NSString stringWithFormat:@"My Token is :%@", token]];
                                TIMTokenParam *param = [[TIMTokenParam alloc] init];
                                
                                param.busiId = TIMPushID;
                                
                                [param setToken:deviceToken];
                                
                                StaffUserInfo *userInfo = [[StaffUserInfo alloc]init];
                                
                                [userInfo requestResult:^(BOOL success, NSString *error) {
                                    
                                    [[TIMFriendshipManager sharedInstance]SetNickname:userInfo.staff.name succ:^{
                                        
                                        [[TIMFriendshipManager sharedInstance]SetFaceURL:userInfo.staff.iconUrl.absoluteString succ:^{
                                            
                                            [self getMessage];
                                            
                                        } fail:^(int code, NSString *msg) {
                                            
                                            if (self.callBack) {
                                                
                                                self.callBack(NO, msg);
                                                
                                                self.callBack = nil;
                                                
                                            }
                                            
                                        }];
                                        
                                    } fail:^(int code, NSString *msg) {
                                        
                                        if (self.callBack) {
                                            
                                            self.callBack(NO, msg);
                                            
                                            self.callBack = nil;
                                            
                                        }
                                        
                                    }];
                                    
                                }];
                                
                            } fail:^(int code, NSString * err) {
                                
                                if (self.callBack) {
                                    
                                    self.callBack(NO, err);
                                    
                                    self.callBack = nil;
                                    
                                }
                                
                            }];
                            
                        }else{
                            
                            if (self.callBack) {
                                
                                self.callBack(NO, error);
                                
                                self.callBack = nil;
                                
                            }
                            
                        }
                        
                    }];
                    
                }else{
                    
                    if (self.callBack) {
                        
                        self.callBack(NO, err);
                        
                        self.callBack = nil;
                        
                    }
                    
                }
                
            }];
            
        }else{
            
            ChatListInfo *info = [[ChatListInfo alloc]init];
            
            [info requestSigResult:^(BOOL success, NSString *error) {
                
                if (success) {
                    
                    NSString *nowUserSig = UserSig;
                    
                    TIMLoginParam * login_param = [[TIMLoginParam alloc ]init];
                    
                    login_param.accountType = [NSString stringWithFormat:@"%ld",(long)TencentIMType];
                    login_param.identifier = [NSString stringWithFormat:@"%@%ld",ChatPrefix,UserId];
                    login_param.userSig = nowUserSig;
                    
                    login_param.appidAt3rd = [NSString stringWithFormat:@"%ld",(long)TencentIMID];
                    
                    login_param.sdkAppId = TencentIMID;
                    
                    [[TIMManager sharedInstance] login: login_param succ:^(){
                        
                        NSData *deviceToken = [[NSUserDefaults standardUserDefaults]valueForKey:@"deviceToken"];
                        
                        NSString *token = [NSString stringWithFormat:@"%@", deviceToken];
                        
                        [[TIMManager sharedInstance] log:TIM_LOG_INFO tag:@"SetToken" msg:[NSString stringWithFormat:@"My Token is :%@", token]];
                        TIMTokenParam *param = [[TIMTokenParam alloc] init];
                        
                        param.busiId = TIMPushID;
                        
                        [param setToken:deviceToken];
                        
                        StaffUserInfo *userInfo = [[StaffUserInfo alloc]init];
                        
                        [userInfo requestResult:^(BOOL success, NSString *error) {
                            
                            [[TIMFriendshipManager sharedInstance]SetNickname:userInfo.staff.name succ:^{
                                
                                [[TIMFriendshipManager sharedInstance]SetFaceURL:userInfo.staff.iconUrl.absoluteString succ:^{
                                    
                                    [self getMessage];
                                    
                                } fail:^(int code, NSString *msg) {
                                    
                                    if (self.callBack) {
                                        
                                        self.callBack(NO, msg);
                                        
                                        self.callBack = nil;
                                        
                                    }
                                    
                                }];
                                
                            } fail:^(int code, NSString *msg) {
                                
                                if (self.callBack) {
                                    
                                    self.callBack(NO, msg);
                                    
                                    self.callBack = nil;
                                    
                                }
                                
                            }];
                            
                        }];
                        
                    } fail:^(int code, NSString * err) {
                        
                        if (self.callBack) {
                            
                            self.callBack(NO, err);
                            
                            self.callBack = nil;
                            
                        }
                        
                    }];
                    
                }else{
                    
                    if (self.callBack) {
                        
                        self.callBack(NO, error);
                        
                        self.callBack = nil;

                    }
                    
                }
                
            }];
            
        }
        
    }else{
        
        [self getMessage];
        
    }
    
}

-(void)getMessage
{
    
    self.unReadNumber = 0;
    
    self.chatArray = [NSMutableArray array];
    
    NSArray * conversations = [[TIMManager sharedInstance] getConversationList];
    
    for (TIMConversation *conversation in conversations) {
        
        if ([conversation getType]<3) {
            
            ChatListModel *model = [[ChatListModel alloc]init];
            
            model.identifier = [conversation getReceiver];
            
            model.conversation = conversation;
            
            model.user = [[User alloc]init];
            
            model.type = [conversation getType]==TIM_C2C?ChatListModelTypeChatSingle:ChatListModelTypeChatGroup;
            
            if (model.type == ChatListModelTypeChatGroup) {
                
                model.group = [[ChatUserGroup alloc]init];
                
                model.group.groupId = model.identifier;
                
            }
            
            NSArray *msgs = [conversation getLastMsgs:1];
            
            if (msgs.count) {
                
                TIMMessage *msg = [msgs lastObject];
                
                TIMElem *elem = [msg getElem:[msg elemCount]-1];
                
                NSDate *date = [msg timestamp];
                
                NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                
                dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
                
                dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                
                NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
                
                if (timeInterval<60) {
                    
                    model.time = @"刚刚";
                    
                }else if (timeInterval/60<60){
                    
                    model.time = [NSString stringWithFormat:@"%ld分钟前",(long)(timeInterval/60)];
                    
                }else{
                    
                    if ([[[dateFormatter stringFromDate:date] substringToIndex:10]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10]]) {
                        
                        model.time = [[dateFormatter stringFromDate:date]substringWithRange:NSMakeRange(11, 5)];
                        
                    }else if ([[[dateFormatter stringFromDate:date] substringWithRange:NSMakeRange(0, 4)]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 4)]]){
                        
                        model.time = [[dateFormatter stringFromDate:date]substringWithRange:NSMakeRange(5, 5)];
                        
                    }else{
                        
                        model.time = [[dateFormatter stringFromDate:date]substringToIndex:10];
                        
                    }
                    
                }
                
                if ([elem isKindOfClass:[TIMTextElem class]]) {
                    
                    model.content = ((TIMTextElem*)elem).text;
                    
                }else if ([elem isKindOfClass:[TIMImageElem class]]){
                    
                    model.content = @"[图片]";
                    
                }else if ([elem isKindOfClass:[TIMSoundElem class]]){
                    
                    model.content = @"[语音]";
                    
                }else if([elem isKindOfClass:[TIMGroupTipsElem class]]){
                    
                    TIMGroupTipsElem *groupElem = (TIMGroupTipsElem*)elem;
                    
                    if (groupElem.type == TIM_GROUP_TIPS_TYPE_INVITE) {
                        
                        NSMutableArray *groupMembers = [NSMutableArray array];
                        
                        for (TIMUserProfile *profile in groupElem.changedUserInfo.allValues) {
                            
                            [groupMembers addObject:profile.nickname];
                            
                        }
                                                
                        NSString *string = [groupMembers componentsJoinedByString:@"，"];
                        
                        model.content = [NSString stringWithFormat:@"%@加入群聊",string];
                        
                    }else if (groupElem.type == TIM_GROUP_TIPS_TYPE_QUIT_GRP){
                        
                        model.content = [NSString stringWithFormat:@"%@已退出群聊",groupElem.opUserInfo.nickname];
                        
                    }else if (groupElem.type == TIM_GROUP_TIPS_KICK){
                        
                        BOOL haveMine = NO;
                        
                        NSMutableArray *groupMembers = [NSMutableArray array];
                        
                        for (TIMUserProfile *profile in groupElem.changedUserInfo.allValues) {
                            
                            if ([profile.identifier hasPrefix:ChatPrefix]) {
                                
                                NSString *userIdStr = [profile.identifier substringFromIndex:ChatPrefix.length];
                                
                                if ([userIdStr isEqualToString:[NSString stringWithInteger:UserId]]) {
                                    
                                    haveMine = YES;
                                    
                                }
                                
                            }
                            
                            [groupMembers addObject:profile.nickname];
                            
                        }
                        
                        if (haveMine) {
                            
                            model.content = @"您已被踢出群聊";
                            
                        }else{
                            
                            NSString *string = [groupMembers componentsJoinedByString:@"，"];
                            
                            model.content = [NSString stringWithFormat:@"%@已被踢出群聊",string];
                            
                        }
                        
                    }else if(groupElem.type == TIM_GROUP_TIPS_TYPE_INFO_CHANGE){
                        
                        model.content = @"[群资料已经更新]";
                        
                    }
                    
                }else{
                    
                    model.content = @"[未知消息类型]";
                    
                }
                
            }
            
            model.unreadCount = [conversation getUnReadMessageNum];
            
            [self.chatArray addObject:model];
            
            if ([conversation getUnReadMessageNum]) {
                
                self.unReadNumber++;
                
            }
            
        }
        
    }
    
    NSMutableArray *singleUsers = [NSMutableArray array];
    
    NSMutableArray *groupUsers = [NSMutableArray array];
    
    NSMutableArray *singleUserIds = [NSMutableArray array];
    
    NSMutableArray *groupUserIds = [NSMutableArray array];
    
    for (ChatListModel *model in self.chatArray) {
        
        if (model.type == ChatListModelTypeChatSingle) {
            
            [singleUsers addObject:model];
            
            [singleUserIds addObject:model.identifier];
            
        }else{
            
            [groupUsers addObject:model];
            
            [groupUserIds addObject:model.identifier];
            
        }
        
    }
    
    if (singleUserIds.count) {
        
        [[TIMFriendshipManager sharedInstance]GetUsersProfile:singleUserIds succ:^(NSArray *friends) {
            
            for (TIMUserProfile *profile in friends) {
                
                ChatListModel *model;
                
                for (ChatListModel *tempModel in singleUsers) {
                    
                    if ([tempModel.identifier isEqualToString:profile.identifier]) {
                        
                        model = tempModel;
                        
                    }
                    
                }
                
                if (model) {
                    
                    model.user.username = profile.nickname;
                    
                    model.user.iconURL = [NSURL URLWithString:profile.faceURL];
                    
                }
                
            }
            
            [[TIMGroupManager sharedInstance]GetGroupInfo:groupUserIds succ:^(NSArray *arr) {
                
                for (TIMGroupInfo *groupInfo in arr) {
                    
                    ChatListModel *model;
                    
                    for (ChatListModel *tempModel in groupUsers) {
                        
                        if ([tempModel.identifier isEqualToString:groupInfo.group]) {
                            
                            model = tempModel;
                            
                        }
                        
                    }
                    
                    if (model) {
                        
                        model.group.name = groupInfo.groupName;
                        
                        model.group.iconURL = groupInfo.faceURL;
                        
                        model.group.userCount = groupInfo.memberNum;
                        
                    }
                    
                }
                
                if (self.callBack) {
                    
                    self.callBack(YES, nil);
                    
                    self.callBack = nil;
                    
                }
                
                
            } fail:^(int code, NSString *msg) {
                
                if (self.callBack) {
                    
                    self.callBack(YES, nil);
                    
                    self.callBack = nil;
                    
                }
                
            }];
            
        } fail:^(int code, NSString *msg) {
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }else{
        
        [[TIMGroupManager sharedInstance]GetGroupInfo:groupUserIds succ:^(NSArray *arr) {
            
            for (TIMGroupInfo *groupInfo in arr) {
                
                ChatListModel *model;
                
                for (ChatListModel *tempModel in groupUsers) {
                    
                    if ([tempModel.identifier isEqualToString:groupInfo.group]) {
                        
                        model = tempModel;
                        
                    }
                    
                }
                
                if (model) {
                    
                    model.group.name = groupInfo.groupName;
                    
                    model.group.iconURL = groupInfo.faceURL;
                    
                    model.group.userCount = groupInfo.memberNum;
                    
                }
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
            
        } fail:^(int code, NSString *msg) {
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }
    
}

-(void)createChatWithUsers:(NSArray *)users result:(UsersCallBack)result
{
    
    self.usercb = result;
    
    NSString *userStatus = [[TIMManager sharedInstance]getLoginUser];
    
    if (!userStatus) {
        
        if (self.usercb) {
            
            self.usercb(NO, @"创建失败，请重新登录",nil);
            
            self.usercb = nil;
            
        }
        
        return;
        
    }
    
    NSMutableArray *allUsers = [users mutableCopy];
    
    if (allUsers.count>1) {
        
        for (User *tempUser in allUsers) {
            
            if (tempUser.userId == UserId) {
                
                [allUsers removeObject:tempUser];
                
                break;
                
            }
            
        }
        
    }
    
    if (allUsers.count == 1) {
        
        User *user = [allUsers firstObject];
        
       TIMConversation *conversation = [[TIMManager sharedInstance]getConversation:TIM_C2C receiver:[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)user.userId]];
        
        if (conversation) {
            
            self.chatId = [NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)user.userId];
            
            if (self.usercb) {
                
                self.usercb(YES, nil,allUsers);
                
                self.usercb = nil;
                
            }
            
        }else{
            
            if (self.usercb) {
                
                self.usercb(NO, @"创建聊天失败",nil);
                
                self.usercb = nil;
                
            }
            
        }
        
    }else{
        
        NSMutableArray *userIds = [NSMutableArray array];
        
        StaffUserInfo *info = [[StaffUserInfo alloc]init];
        
        [info requestResult:^(BOOL success, NSString *error) {
            
            User *user = [[User alloc]init];
            
            user.username = info.staff.name;
            
            user.userId = info.staff.userId;
            
            user.iconURL = info.staff.iconUrl;
            
            [allUsers insertObject:user atIndex:0];
            
            NSMutableArray *usernames = [NSMutableArray array];
            
            NSString *name = @"";
            
            for (User *tempUser in allUsers) {
                
                [userIds addObject:[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)tempUser.userId]];
                
                [usernames addObject:tempUser.username];
                
            }
            
            NSString *tempName = [usernames componentsJoinedByString:@"、"];
            
            NSString *pointStr = @"...";
            
            if ([tempName lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>30) {
                
                for (NSInteger i = 0 ; i<usernames.count; i++) {
                    
                    NSString *str = usernames[i];
                    
                    if (str.length) {
                        
                        NSString *nowName = [[name stringByAppendingString:str]stringByAppendingString:@"、"];
                        
                        if ([[nowName substringToIndex:nowName.length-1] lengthOfBytesUsingEncoding:NSUTF8StringEncoding]+[pointStr lengthOfBytesUsingEncoding:NSUTF8StringEncoding]>30) {
                            
                            name = [[name substringToIndex:name.length-1]stringByAppendingString:pointStr];
                            
                            break;
                            
                        }else{
                            
                            name = [[nowName substringToIndex:nowName.length-1]stringByAppendingString:@"、"];
                            
                        }
                        
                    }
                    
                }
                
            }else{
                
                name = tempName;
                
            }
            
            [[TIMGroupManager sharedInstance]CreatePrivateGroup:userIds groupName:name succ:^(NSString *groupId) {
                
                [[TIMGroupManager sharedInstance]ModifyGroupFaceUrl:groupId url:@"http://zoneke-img.b0.upaiyun.com/4ca8948c8e2cc5d0874d163001fa2267.png" succ:^{
                    
                    self.group = [[ChatUserGroup alloc]init];
                    
                    self.group.groupId = groupId;
                    
                    self.group.name = name;
                    
                    self.group.users = allUsers;
                    
                    self.group.iconURL = @"http://zoneke-img.b0.upaiyun.com/4ca8948c8e2cc5d0874d163001fa2267.png";
                    
                    self.group.userCount = allUsers.count;
                    
                    [ChatUserManager saveGroup:self.group];
                    
                    if (self.usercb) {
                        
                        self.usercb(YES, nil,allUsers);
                        
                        self.usercb = nil;
                        
                    }
                    
                } fail:^(int code, NSString *msg) {
                    
                    self.group = [[ChatUserGroup alloc]init];
                    
                    self.group.groupId = groupId;
                    
                    self.group.name = name;
                    
                    self.group.users = allUsers;
                    
                    self.group.userCount = allUsers.count;
                    
                    self.group.iconURL = @"http://zoneke-img.b0.upaiyun.com/4ca8948c8e2cc5d0874d163001fa2267.png";
                    
                    [ChatUserManager saveGroup:self.group];
                    
                    if (self.usercb) {
                        
                        self.usercb(YES, nil,allUsers);
                        
                        self.usercb = nil;
                        
                    }
                    
                }];
                
            } fail:^(int code, NSString *msg) {
                
                if (self.usercb) {
                    
                    self.usercb(NO, msg,nil);
                    
                    self.usercb = nil;
                    
                }
                
            }];
            
        }];
        
    }
    
}

-(void)requestSigResult:(RequestCallBack)result
{
    
    self.callBack = result;
    
    if (!UserId) {
        
        if (self.callBack) {
            
            self.callBack(NO, @"尚未登录");
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSString stringWithFormat:@"%@%ld",ChatPrefix,UserId] forKey:@"identifier"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:SigAPI param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]== 200) {
            
            [[NSUserDefaults standardUserDefaults]setValue:responseDic[@"data"][@"usersig"] forKey:@"userSig"];
            
            [[NSUserDefaults standardUserDefaults]synchronize];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO, error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

+(void)setDeleteModelIdWithType:(ChatListModelType)type andNotificationId:(NSInteger)notificationId
{
    
    NSData *data = [[NSUserDefaults standardUserDefaults]valueForKey:@"chat_list_delete_model"];
    
    ChatListDeleteModel *deleteModel;
    
    if (data) {
        
        deleteModel = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        
    }
    
    if (!deleteModel) {
        
        deleteModel = [[ChatListDeleteModel alloc]init];
        
    }
    
    switch (type) {
        case ChatListModelTypeGym:
            
            deleteModel.gymId = notificationId;
            
            break;
            
        case ChatListModelTypeSystem:
            
            deleteModel.systemId = notificationId;
            
            break;
            
        case ChatListModelTypeStudy:
            
            deleteModel.studyId = notificationId;
            
            break;
            
        case ChatListModelTypeCheckin:
            
            deleteModel.checkinId = notificationId;
            
            break;
            
        case ChatListModelTypeReply:
            
            deleteModel.replyId = notificationId;
            
            break;
        
        case ChatListModelTypeMatch:
            
            deleteModel.matchId = notificationId;
            
            break;
            
        default:
            break;
    }
    
    NSData *nowData = [NSKeyedArchiver archivedDataWithRootObject:deleteModel];
    
    [[NSUserDefaults standardUserDefaults] setObject:nowData forKey:@"chat_list_delete_model"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
}

-(void)readAllResult:(RequestCallBack)result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:@"" forKey:@"type__in"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:ClearAPI putParam:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            NSArray *conversations = [[TIMManager sharedInstance]getConversationList];
        
            for (TIMConversation *conversation in conversations) {
                
                [conversation setReadMessage];
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
    }];
    
}

@end
