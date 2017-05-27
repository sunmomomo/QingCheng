//
//  CardKind.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Gym.h"

#import "CardCost.h"

#import "Spec.h"

typedef enum : NSUInteger {
    CardKindStateNormal = 0,
    CardKindStateStop = 1,
} CardKindState;

typedef enum : NSUInteger {
    CardKindTypePrepaid = 1,
    CardKindTypeCount = 2,
    CardKindTypeTime =3,
    CardKindTypeOnline = 4,
    CardKindTypeNone = 0,
} CardKindType;

@interface CardKind : NSObject<NSCoding>

@property(nonatomic,assign)NSInteger preTimes;

@property(nonatomic,assign)NSInteger dayTimes;

@property(nonatomic,assign)NSInteger weekTimes;

@property(nonatomic,assign)NSInteger monthTimes;

@property(nonatomic,assign)NSInteger maxCardCount;

@property(nonatomic,strong)UIColor *color;

@property(nonatomic,assign)BOOL isLimit;

@property(nonatomic,copy)NSString *cardKindName;

@property(nonatomic,assign)NSInteger cardKindId;

@property(nonatomic,copy)NSString *typeName;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,copy)NSString *astrict;

@property(nonatomic,assign)BOOL isUsed;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,assign)CardKindType type;

@property(nonatomic,strong)NSMutableArray *costs;

@property(nonatomic,assign)NSInteger cost;

@property(nonatomic,copy)NSString *costString;

@property(nonatomic,strong)NSMutableArray *specs;

@property(nonatomic,assign)CardKindState state;

@property(nonatomic,assign)BOOL canCancel;

@property(nonatomic,assign)BOOL isEnabled;

@end
