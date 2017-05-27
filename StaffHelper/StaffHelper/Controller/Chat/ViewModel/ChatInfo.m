//
//  ChatInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatInfo.h"

@interface ChatInfo ()

@property(nonatomic,strong)TIMConversation *conversation;

@property(nonatomic,strong)NSMutableArray *messages;

@end

@implementation ChatInfo

-(void)requestWithModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    TIMConversation *conversation = [[TIMManager sharedInstance]getConversation:model.type == ChatListModelTypeChatSingle?TIM_C2C:TIM_GROUP receiver:model.identifier];
    
    self.conversation = conversation;
    
    if (!self.chats) {
        
        self.chats = [NSArray array];
        
    }
    
    if (self.mine) {
        
        [conversation getMessage:20 last:nil succ:^(NSArray *msgs) {
            
            [self dealDataWithArray:msgs];
            
            if (self.callBack) {
                
                self.callBack(YES, nil);
                
                self.callBack = nil;
                
            }
            
        } fail:^(int code, NSString *msg) {
            
            if (self.callBack) {
                
                self.callBack(NO, msg);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }else{
        
        [[TIMFriendshipManager sharedInstance] GetSelfProfile:^(TIMUserProfile * profile) {
            
            User *user = [[User alloc]init];
            
            user.username = profile.nickname;
            
            user.iconURL = [NSURL URLWithString:profile.faceURL];
            
            if ([profile.identifier hasPrefix:ChatPrefix]) {
                
                user.userId = [[profile.identifier substringFromIndex:ChatPrefix.length]integerValue];
                
            }
            
            self.mine = user;
            
            [conversation getMessage:20 last:nil succ:^(NSArray *msgs) {
                
                [self dealDataWithArray:msgs];
                
                if (self.callBack) {
                    
                    self.callBack(YES, nil);
                    
                    self.callBack = nil;
                    
                }
                
            } fail:^(int code, NSString *msg) {
                
                if (self.callBack) {
                    
                    self.callBack(NO, msg);
                    
                    self.callBack = nil;
                    
                }
                
            }];
            
        } fail:^(int code, NSString * err) {
            
            if (self.callBack) {
                
                self.callBack(NO, err);
                
                self.callBack = nil;
                
            }
            
        }];
        
    }
    
}

-(void)requestForwardWithModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    TIMConversation *conversation = [[TIMManager sharedInstance]getConversation:model.type == ChatListModelTypeChatSingle?TIM_C2C:TIM_GROUP receiver:model.identifier];
    
    self.conversation = conversation;
    
    [conversation getMessage:20 last:[self.messages lastObject] succ:^(NSArray *msgs) {
        
        [self dealDataWithArray:msgs];
        
        if (self.callBack) {
            
            self.callBack(YES, nil);
            
            self.callBack = nil;
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (self.callBack) {
            
            self.callBack(NO, msg);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)dealDataWithArray:(NSArray*)msgs
{
    
    if (!self.messages) {
        
        self.messages = [NSMutableArray array];
        
    }
    
    NSMutableArray *chats = [NSMutableArray array];
    
    for (ChatModel *model in self.chats) {
        
        if (model.type != ChatTypeTime) {
            
            [chats addObject:model];
            
        }
        
    }
    
    CGSize timeSize = [@"时间" boundingRectWithSize:CGSizeMake(MSW,Height(14)) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(12)} context:nil].size;
    
    for (TIMMessage *msg in msgs) {
        
        NSString *identifier = [msg GetSenderProfile].identifier;
        
        [self.messages addObject:msg];
        
        ChatModel *model = [[ChatModel alloc]init];
        
        TIMElem *elem = [msg getElem:[msg elemCount]-1];
        
        model.isMine = msg.isSelf;
        
        model.date = msg.timestamp;
        
        if (model.isMine || !identifier) {
            
            model.user = self.mine;
            
        }else{
            
            User *tempUser = [[User alloc]init];
            
            TIMUserProfile *profile = [msg GetSenderProfile];
            
            tempUser.username = profile.nickname;
            
            tempUser.iconURL = [NSURL URLWithString:profile.faceURL];
            
            if ([profile.identifier hasPrefix:ChatPrefix]) {
                
                tempUser.userId = [[profile.identifier substringFromIndex:ChatPrefix.length]integerValue];
                
            }
            
            model.user = tempUser;
            
        }
        
        if ([elem isKindOfClass:[TIMTextElem class]]) {
            
            model.type = ChatTypeLabel;
            
            model.content = ((TIMTextElem*)elem).text;
            
            CGSize size = [model.content boundingRectWithSize:CGSizeMake(219, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(15)} context:nil].size;
            
            model.cellHeight = size.height+30;
            
            [chats addObject:model];
            
        }else if ([elem isKindOfClass:[TIMImageElem class]]){
            
            if (((TIMImageElem*)elem).imageList.count) {
                
                TIMImage *image =[((TIMImageElem*)elem).imageList firstObject];
                
                TIMImage *thumbImage;
                
                for (TIMImage *tempImage in ((TIMImageElem*)elem).imageList) {
                    
                    if (tempImage.type == TIM_IMAGE_TYPE_THUMB) {
                        
                        thumbImage = tempImage;
                        
                    }
                    
                }
                
                if (!thumbImage) {
                    
                    thumbImage = image;
                    
                }
                
                float height = image.height;
                
                float width = image.width;
                
                model.type = ChatTypeImage;
                
                model.imageURL = [NSURL URLWithString:image.url];
                
                model.imageThumbURL = [NSURL URLWithString:thumbImage.url];
                
                float imgHeight =128/width*height;
                
                model.imageHeight = imgHeight;
                
                model.cellHeight = imgHeight +10;
                
                [chats addObject:model];
                
            }
            
        }else if ([elem isKindOfClass:[TIMSoundElem class]]){
            
            model.type = ChatTypeVoice;
            
            TIMSoundElem *soundElem = (TIMSoundElem*)elem;
            
            model.voiceLength = soundElem.second;
            
            NSTimeInterval timeInterval = [msg.timestamp timeIntervalSince1970];
            
            NSString *mainPath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES).firstObject;
            
            NSString *path = [NSString stringWithFormat:@"%@voice_%@_%ld",mainPath,[_conversation getSelfIdentifier],(long)timeInterval];
            
            model.voicePath = path;
            
            model.cellHeight = 50;
            
            model.unRead = msg.isReaded;
            
            [soundElem getSoundToFile:path succ:^{
                
            } fail:^(int code, NSString *msg) {
                
            }];
            
            [chats addObject:model];
            
        }else if([elem isKindOfClass:[TIMGroupTipsElem class]]){
            
            TIMGroupTipsElem *groupElem = (TIMGroupTipsElem*)elem;
            
            model.type = ChatTypeSystem;
            
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
            
            CGSize size = [model.content boundingRectWithSize:CGSizeMake(MSW-60, MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:STFont(10)} context:nil].size;
            
            model.cellHeight = size.height+15+8;
            
            [chats addObject:model];
            
        }
        
    }
    
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
    
    NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
    
    NSArray *nowChats = [chats sortedArrayUsingDescriptors:sortDescriptors];
    
    NSDate *date = [NSDate date];
    
    NSMutableArray *finalChats = [NSMutableArray array];
    
    for (ChatModel *model in nowChats) {
        
        if (model.type != ChatTypeSystem) {
            
            NSInteger timeInterval = [date timeIntervalSinceDate:model.date];
            
            if (timeInterval>300||timeInterval<-300) {
                
                ChatModel *timeModel = [[ChatModel alloc]init];
                
                timeModel.type = ChatTypeTime;
                
                timeModel.date = model.date;
                
                timeModel.cellHeight = timeSize.height+12;
                
                [finalChats addObject:timeModel];
                
                date = model.date;
                
            }
            
        }
        
        model.tag = [nowChats indexOfObject:model];
        
        [finalChats addObject:model];
        
    }
    
    self.chats = finalChats;
    
}

-(void)requestGroupDetailInfoWithModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    [[TIMGroupManager sharedInstance]GetGroupInfo:@[model.identifier] succ:^(NSArray *arr) {
        
        TIMGroupInfo *info = [arr firstObject];
        
        model.group.name = info.groupName;
        
        model.group.iconURL = info.faceURL;
        
        model.group.userCount = info.memberNum;
        
        NSMutableArray *userIds = [NSMutableArray array];
        
        NSMutableArray *users = [NSMutableArray array];
        
        [[TIMGroupManager sharedInstance]GetGroupMembers:model.identifier succ:^(NSArray *members) {
            
            for (TIMGroupMemberInfo *memberInfo in members) {
                
                [userIds addObject:memberInfo.member];
                
            }
            
            [[TIMFriendshipManager sharedInstance]GetUsersProfile:userIds succ:^(NSArray *friends) {
                
                for (TIMUserProfile *profile in friends) {
                    
                    User *user = [[User alloc]init];
                    
                    user.username = profile.nickname;
                    
                    user.iconURL = [NSURL URLWithString:profile.faceURL];
                    
                    if ([profile.identifier hasPrefix:ChatPrefix]) {
                        
                        user.userId = [[profile.identifier substringFromIndex:ChatPrefix.length]integerValue];
                        
                    }
                    
                    [users addObject:user];
                    
                }
                
                model.group.users = users;
                
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
        
    } fail:^(int code, NSString *msg) {
        
        if (self.callBack) {
            
            self.callBack(NO, msg);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)changeName:(NSString *)name withModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    [[TIMGroupManager sharedInstance]ModifyGroupName:model.identifier groupName:name succ:^{
        
        if (self.callBack) {
            
            self.callBack(YES, nil);
            
            self.callBack = nil;
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (self.callBack) {
            
            self.callBack(NO, msg);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)quitWithModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    [[TIMGroupManager sharedInstance]QuitGroup:model.identifier succ:^{
        
        if (self.callBack) {
            
            self.callBack(YES, nil);
            
            self.callBack = nil;
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (self.callBack) {
            
            self.callBack(NO, msg);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)removeUsers:(NSArray *)users withModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    NSMutableArray *userIds = [NSMutableArray array];
    
    for (User *user in users) {
        
        [userIds addObject:[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)user.userId]];
        
    }
    
    [[TIMGroupManager sharedInstance]DeleteGroupMember:model.identifier members:userIds succ:^(NSArray *members) {
        
        if (self.callBack) {
            
            self.callBack(YES, nil);
            
            self.callBack = nil;
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (code == 10007) {
            
            if (self.callBack) {
                
                self.callBack(NO, @"仅群聊创建人可移除成员");
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO, msg);
                
                self.callBack = nil;
                
            }
            
        }
        
    }];
    
}

-(void)addUsers:(NSArray *)users withModel:(ChatListModel *)model result:(RequestCallBack)result
{
    
    self.callBack = result;
    
    NSMutableArray *userIds = [NSMutableArray array];
    
    for (User *user in users) {
        
        [userIds addObject:[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)user.userId]];
        
    }
    
    [[TIMGroupManager sharedInstance]InviteGroupMember:model.identifier members:userIds succ:^(NSArray *members) {
        
        if (self.callBack) {
            
            self.callBack(YES, nil);
            
            self.callBack = nil;
            
        }
        
    } fail:^(int code, NSString *msg) {
        
        if (self.callBack) {
            
            self.callBack(NO, msg);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)setReadAtIndex:(NSInteger)index
{
    
    if (index<self.messages.count) {
        
        TIMMessage *message = self.messages[index];
        
        [self.conversation setReadMessage:message];
        
    }
    
}

@end
