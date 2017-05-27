//
//  ChatUserManager.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ChatUserManager.h"

#define TableName @"ChatUser"

@implementation ChatUserManager

+(User *)checkWithUserId:(NSInteger)userId
{
    
    NSManagedObjectContext *context = [MOAppDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId=%@",[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)userId]];
    
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
    [request setFetchLimit:1];
    
    NSError *error;
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    User *user = [[User alloc]init];
    
    for (ChatUser *tempUser in fetchedObjects) {
        
        if (tempUser.userId.integerValue == userId) {
            
            user.username = tempUser.username;
            
            user.userId = userId;
            
            user.iconURL = [NSURL URLWithString:tempUser.iconURL];
            
            user.phone = tempUser.phone;
            
            break;
            
        }
        
    }
    
    return user;
    
}

+(ChatUserGroup*)checkGroupWithGroupId:(NSString *)groupId
{
    
    NSManagedObjectContext *context = [MOAppDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId=%@",groupId];
    
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
    [request setFetchLimit:1];
    
    NSError *error;
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    ChatUserGroup *group = [[ChatUserGroup alloc]init];
    
    for (ChatUser *tempUser in fetchedObjects) {
        
        if ([tempUser.userId isEqualToString:groupId]) {
            
            group.name = tempUser.username;
            
            group.groupId = groupId;
            
            break;
            
        }
        
    }
    
    return group;
    
}

+(void)saveUser:(User *)user
{
    
    NSManagedObjectContext *context = [MOAppDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId=%@",[NSString stringWithFormat:@"%@%ld",ChatPrefix,(long)user.userId]];
    
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
    [request setFetchLimit:1];
    
    NSError *error;
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    if (fetchedObjects.count) {
        
        ChatUser *chatUser = [fetchedObjects firstObject];
        
        chatUser.username = user.username;
        
        chatUser.phone = user.phone;
        
        chatUser.iconURL = user.iconURL.absoluteString;
        
        [context save:&error];
        
    }else{
        
        ChatUser *chatUser = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        
        chatUser.iconURL = user.iconURL.absoluteString;
        
        chatUser.userId = [NSString stringWithInteger:user.userId];
        
        chatUser.username = user.username;
        
        chatUser.phone = user.phone;
        
        NSError *error;
        
        [context save:&error];
        
    }
    
}

+(void)saveGroup:(ChatUserGroup *)group
{
    
    NSManagedObjectContext *context = [MOAppDelegate managedObjectContext];
    
    NSFetchRequest *request = [[NSFetchRequest alloc]init];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:TableName inManagedObjectContext:context];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"userId=%@",group.groupId];
    
    [request setEntity:entity];
    
    [request setPredicate:predicate];
    
    [request setFetchLimit:1];
    
    NSError *error;
    
    NSArray *fetchedObjects = [context executeFetchRequest:request error:&error];
    
    if (fetchedObjects.count) {
        
        ChatUser *chatUser = [fetchedObjects firstObject];
        
        chatUser.username = group.name;
        
        [context save:&error];
        
    }else{
        
        ChatUser *chatUser = [NSEntityDescription insertNewObjectForEntityForName:TableName inManagedObjectContext:context];
        
        chatUser.username = group.name;
        
        chatUser.userId = group.groupId;
        
        NSError *error;
        
        [context save:&error];
        
    }
    
}

@end
