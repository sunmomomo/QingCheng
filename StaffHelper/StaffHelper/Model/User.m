//
//  User.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "User.h"

@implementation GymPosition

@end

@implementation ChatUserGroup

@end

@implementation UserGroup

@end

@implementation User

-(id)copy
{
    
    User *user = [[User alloc]init];
    
    user.head = self.head;
    
    user.username = self.username;
    
    user.userId = self.userId;
    
    user.iconURL = self.iconURL;
    
    user.phone = self.phone;
    
    user.position = self.position;
    
    user.positions = self.positions;
    
    return user;

}

@end
