//
//  ChatUser+CoreDataProperties.m
//  
//
//  Created by 馍馍帝😈 on 2017/4/18.
//
//

#import "ChatUser+CoreDataProperties.h"

@implementation ChatUser (CoreDataProperties)

+ (NSFetchRequest<ChatUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ChatUser"];
}

@dynamic username;
@dynamic userId;
@dynamic phone;
@dynamic iconURL;

@end
