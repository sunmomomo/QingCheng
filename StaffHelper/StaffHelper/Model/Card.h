//
//  Card.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

#import "Gym.h"

#import "Student.h"

typedef enum : NSUInteger {
    CardStateNo = 0,
    CardStateNormal = 1,
    CardStateRest = 2,
    CardStateStop = 3,
    CardStateExpired = 4,
} CardState;

@interface Card : NSObject

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,copy)NSString *cardNumber;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,assign)CGFloat remain;

@property(nonatomic,strong)NSArray *users;

@property(nonatomic,assign)CardState state;

@property(nonatomic,strong)UIColor *color;

@property(nonatomic,assign)BOOL checkValid;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,copy)NSString *validFrom;

@property(nonatomic,copy)NSString *validTo;

@property(nonatomic,copy)NSString *lockStart;

@property(nonatomic,copy)NSString *lockEnd;

- (NSString *)getStartTimeYF;
- (NSString *)getEndTimeYF;

// 过期天数
@property(nonatomic, assign)NSInteger trial_days;
@end


