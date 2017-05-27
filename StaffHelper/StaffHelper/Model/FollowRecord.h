//
//  FollowRecord.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Staff.h"

typedef enum : NSUInteger {
    FollowRecordTypeText,
    FollowRecordTypeImage,
    FollowRecordTypeVoice,
} FollowRecordType;

@interface FollowRecord : NSObject

@property(nonatomic,copy)NSURL *imageURL;

@property(nonatomic,copy)NSString *content;

@property(nonatomic,strong)Staff *staff;

@property(nonatomic,assign)FollowRecordType type;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,assign)NSInteger recordId;

@property(nonatomic,assign)CGSize size;

@end
