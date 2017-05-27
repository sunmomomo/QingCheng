//
//  ChatUser+CoreDataProperties.m
//  
//
//  Created by 馍馍帝😈 on 2017/4/11.
//
//

#import "ChatUser+CoreDataProperties.h"

@implementation ChatUser (CoreDataProperties)

+ (NSFetchRequest<ChatUser *> *)fetchRequest {
	return [[NSFetchRequest alloc] initWithEntityName:@"ChatUser"];
}

@dynamic userId;
@dynamic username;
@dynamic iconURL;
@dynamic phone;

@end
