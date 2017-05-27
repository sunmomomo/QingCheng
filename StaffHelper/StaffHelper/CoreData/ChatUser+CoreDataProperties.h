//
//  ChatUser+CoreDataProperties.h
//  
//
//  Created by 馍馍帝😈 on 2017/4/11.
//
//

#import "ChatUser+CoreDataClass.h"


NS_ASSUME_NONNULL_BEGIN

@interface ChatUser (CoreDataProperties)

+ (NSFetchRequest<ChatUser *> *)fetchRequest;

@property (nullable, nonatomic, copy) NSString *userId;
@property (nullable, nonatomic, copy) NSString *username;
@property (nullable, nonatomic, copy) NSString *iconURL;
@property (nullable, nonatomic, copy) NSString *phone;

@end

NS_ASSUME_NONNULL_END
