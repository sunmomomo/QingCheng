//
//  Yard.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

typedef enum : NSUInteger {
    YardTypePrivate = 0,
    YardTypeGroup = 1,
    YardTypeUnlimited = 2,
} YardType;

@interface Yard : NSObject<NSCoding>

@property(nonatomic,assign)NSInteger yardId;

@property(nonatomic,assign)NSInteger capacity;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)YardType type;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,strong)Gym *gym;

@end
