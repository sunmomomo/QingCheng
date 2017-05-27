//
//  MessageInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Message.h"

typedef enum : NSUInteger {
    MessageInfoTypeCheckin = 1,
    MessageInfoTypeSystem = 2,
    MessageInfoTypeNone = 0,
    MessageInfoTypeGym = 3,
    MessageInfoTypeStudy = 4,
    MessageInfoTypeMatch = 5,
    MessageInfoTypeReply = 6,
} MessageInfoType;

@interface MessageInfo : NSObject

@property(nonatomic,strong)NSMutableArray *messages;

@property(nonatomic,assign)MessageInfoType type;

@property(nonatomic,assign)NSInteger unReadCount;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

-(void)readMessage:(Message*)message result:(void(^)(BOOL success,NSString *error))result;

-(void)readAllMessageResult:(void(^)(BOOL success,NSString *error))result;

-(void)readMessages:(NSArray *)messages result:(void(^)(BOOL success,NSString *error))result;

@end
