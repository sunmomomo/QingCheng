//
//  Card.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "CardKind.h"

typedef enum : NSUInteger {
    CardStateNo = 0,
    CardStateNormal = 1,
    CardStateRest = 2,
    CardStateStop = 3,
} CardState;

typedef enum : NSUInteger {
    CardTypePrepaid = 1,
    CardTypeCount = 2,
    CardTypeTime =3,
} CardType;

@interface Card : NSObject

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,copy)NSString *cardNumber;

@property(nonatomic,assign)NSInteger cardId;

@property(nonatomic,copy)NSString *cardName;

@property(nonatomic,assign)CGFloat remain;

@property(nonatomic,copy)NSString *remainTimes;

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

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,strong)NSMutableArray *students;

@end
