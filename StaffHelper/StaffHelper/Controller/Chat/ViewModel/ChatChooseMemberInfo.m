//
//  ChatChooseMemberInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/31.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatChooseMemberInfo.h"

#define API @"/api/im/gym/contacts/"

@interface ChatChooseMemberInfo ()

@end

@implementation ChatChooseMemberInfo

-(void)requestResult:(RequestCallBack)result
{
    
    self.callBack = result;
    
    if (!UserId) {
        
        if (self.callBack) {
            
            self.callBack(NO, @"尚未登录");
            
            self.callBack = nil;
            
        }
        
        return;
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:API param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            _heads = [NSMutableArray array];
            
            NSMutableArray *gyms = [NSMutableArray array];
            
            NSMutableArray *users = [NSMutableArray array];
            
            [responseDic[@"data"][@"gyms"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                ChatMemberGymModel *gym = [[ChatMemberGymModel alloc]init];
                
                gym.gymName = obj[@"name"];
                
                gym.iconURL = obj[@"photo"];
                
                gym.brandName = obj[@"brand_name"];
                
                gym.gymId = [obj[@"id"] integerValue];
                
                NSMutableArray *userIds = [NSMutableArray array];
                
                NSMutableArray *positions = [NSMutableArray array];
                
                [obj[@"staffs"] enumerateObjectsUsingBlock:^(id  _Nonnull staffObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (![userIds containsObject:[NSString stringWithInteger:[staffObj[@"id"]integerValue]]]) {
                        
                        [userIds addObject:[NSString stringWithInteger:[staffObj[@"id"]integerValue]]];
                        
                    }
                    
                    ChatMemberGroupModel *position;
                    
                    for (ChatMemberGroupModel *tempPostion in positions) {
                        
                        if ([tempPostion.position isEqualToString:staffObj[@"position_str"]]) {
                            
                            position = tempPostion;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!position) {
                        
                        position = [[ChatMemberGroupModel alloc]init];
                        
                        position.position = staffObj[@"position_str"];
                        
                        [positions addObject:position];
                        
                    }
                    
                    if (!position.users) {
                        
                        position.users = [NSMutableArray array];
                        
                    }
                    
                    User *user = [[User alloc]init];
                    
                    user.username = staffObj[@"username"];
                    
                    user.userId = [staffObj[@"id"]integerValue];
                    
                    user.phone = staffObj[@"phone"];
                    
                    user.iconURL = [NSURL URLWithString:staffObj[@"avatar"]];
                    
                    if ([staffObj[@"head"] length]==1) {
                        
                        int asciicode = [staffObj[@"head"] characterAtIndex:0];
                        
                        if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
                            
                            user.head = [staffObj[@"head"] uppercaseString];
                            
                        }else
                        {
                            
                            user.head = @"#";
                            
                        }
                        
                    }else
                    {
                        
                        user.head = @"#";
                        
                    }
                    
                    if (![_heads containsObject:user.head]) {
                        
                        [_heads addObject:user.head];
                        
                    }
                    
                    [position.users addObject:user];
                    
                    BOOL contains = NO;
                    
                    for (User *tempUser in users) {
                        
                        if (tempUser.userId == user.userId) {
                            
                            if (!tempUser.positions) {
                                
                                tempUser.positions = [NSMutableArray array];
                                
                            }
                            
                            GymPosition *gymPosition = [[GymPosition alloc]init];
                            
                            gymPosition.name = staffObj[@"position_str"];
                            
                            gymPosition.gymId = gym.gymId;
                            
                            [tempUser.positions addObject:gymPosition];
                            
                            user.positions = tempUser.positions;
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        User *tempUser = [[User alloc]init];
                        
                        tempUser.username = user.username;
                        
                        tempUser.userId = user.userId;
                        
                        tempUser.iconURL = user.iconURL;
                        
                        tempUser.phone = user.phone;
                        
                        tempUser.head = user.head;
                        
                        tempUser.positions = [NSMutableArray array];
                        
                        GymPosition *gymPosition = [[GymPosition alloc]init];
                        
                        gymPosition.name = staffObj[@"position_str"];
                        
                        gymPosition.gymId = gym.gymId;
                        
                        [tempUser.positions addObject:gymPosition];
                        
                        user.positions = tempUser.positions;
                        
                        [users addObject:tempUser];
                        
                    }
                    
                }];
                
                [obj[@"coaches"] enumerateObjectsUsingBlock:^(id  _Nonnull coachObj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    if (![userIds containsObject:[NSString stringWithInteger:[coachObj[@"id"]integerValue]]]) {
                        
                        [userIds addObject:[NSString stringWithInteger:[coachObj[@"id"]integerValue]]];
                        
                    }
                    
                    ChatMemberGroupModel *position;
                    
                    for (ChatMemberGroupModel *tempPostion in positions) {
                        
                        if ([tempPostion.position isEqualToString:@"教练"]) {
                            
                            position = tempPostion;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!position) {
                        
                        position = [[ChatMemberGroupModel alloc]init];
                        
                        position.position = @"教练";
                        
                        [positions addObject:position];
                        
                    }
                    
                    if (!position.users) {
                        
                        position.users = [NSMutableArray array];
                        
                    }
                    
                    User *user = [[User alloc]init];
                    
                    user.username = coachObj[@"username"];
                    
                    user.userId = [coachObj[@"id"]integerValue];
                    
                    user.phone = coachObj[@"phone"];
                    
                    if ([coachObj[@"head"] length]==1) {
                        
                        int asciicode = [coachObj[@"head"] characterAtIndex:0];
                        
                        if ((asciicode>=65 && asciicode <=90) || (asciicode>=97 && asciicode<=122)) {
                            
                            user.head = [coachObj[@"head"] uppercaseString];
                            
                        }else
                        {
                            
                            user.head = @"#";
                            
                        }
                        
                    }else
                    {
                        
                        user.head = @"#";
                        
                    }
                    
                    if (![_heads containsObject:user.head]) {
                        
                        [_heads addObject:user.head];
                        
                    }
                    
                    user.iconURL = [NSURL URLWithString:coachObj[@"avatar"]];
                    
                    [position.users addObject:user];
                    
                    BOOL contains = NO;
                    
                    for (User *tempUser in users) {
                        
                        if (tempUser.userId == user.userId) {
                            
                            if (!tempUser.positions) {
                                
                                tempUser.positions = [NSMutableArray array];
                                
                            }
                            
                            GymPosition *gymPosition = [[GymPosition alloc]init];
                            
                            gymPosition.name = @"教练";
                            
                            gymPosition.gymId = gym.gymId;
                            
                            [tempUser.positions addObject:gymPosition];
                            
                            user.positions = tempUser.positions;
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        User *tempUser = [[User alloc]init];
                        
                        tempUser.username = user.username;
                        
                        tempUser.userId = user.userId;
                        
                        tempUser.iconURL = user.iconURL;
                        
                        tempUser.phone = user.phone;
                        
                        tempUser.positions = [NSMutableArray array];
                        
                        tempUser.head = user.head;
                        
                        GymPosition *gymPosition = [[GymPosition alloc]init];
                        
                        gymPosition.name = @"教练";
                        
                        gymPosition.gymId = gym.gymId;
                        
                        [tempUser.positions addObject:gymPosition];
                        
                        user.positions = tempUser.positions;
                        
                        [users addObject:tempUser];
                        
                    }
                    
                }];
                
                gym.userCount = userIds.count;
                
                gym.positions = positions;
                
                [gyms addObject:gym];
                
            }];
            
            self.gyms = [gyms copy];
            
            self.users = [users copy];
            
            [_heads sortUsingDescriptors:[NSArray arrayWithObject:[NSSortDescriptor sortDescriptorWithKey:nil ascending:YES]]];
            
            if ([_heads containsObject:@"#"]) {
                
                [_heads removeObjectAtIndex:0];
                
                [_heads addObject:@"#"];
            }
            
            NSMutableArray *groups = [NSMutableArray array];
            
            [_heads enumerateObjectsUsingBlock:^(NSString* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSMutableArray *array =[NSMutableArray array];
                
                for (User *tempUser in self.users) {
                    
                    if ([tempUser.head isEqualToString:obj]) {
                        
                        [array addObject:tempUser];
                        
                    }
                    
                }
                
                if (array.count) {
                    
                    UserGroup *group = [[UserGroup alloc]init];
                    
                    group.users = array;
                    
                    group.header = obj;
                    
                    [groups addObject:group];
                    
                }
                
            }];
            
            if (_heads.count) {
                
                [_heads insertObject:@"" atIndex:0];
                
            }
            
            self.groups = groups;
            
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

@end
