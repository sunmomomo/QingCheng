//
//  ChatUserManager.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "ChatUser+CoreDataClass.h"

@interface ChatUserManager : NSObject

+(void)saveUser:(User*)user;

+(User*)checkWithUserId:(NSInteger)userId;

+(ChatUserGroup*)checkGroupWithGroupId:(NSString*)groupId;

+(void)saveGroup:(ChatUserGroup*)group;

@end
