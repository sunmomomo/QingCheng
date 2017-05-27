//
//  Enum.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    TimeTypeFuture = 1,
    TimeTypePass = 2,
    TimeTypeNow = 0,
    TimeTypeNextWeek=3,
    TimeTypeLastWeek=4,
} TimeType;

typedef enum : NSUInteger {
    AgentTypeRest = 0,
    AgentTypeGroup = 1,
    AgentTypePrivate = 2,
} AgentType;

typedef enum : NSInteger {
    SexTypeMan=0,
    SexTypeWoman=1,
    SexTypeUnknow=-1,
} SexType;

typedef enum : NSUInteger {
    TradeTypeCreate = 3,
    TradeTypeRecharge = 1,
    TradeTypeGive = 17,
    TradeTypeCost = 14,
    TradeTypeNone = 0,
} TradeType;

typedef enum : NSUInteger {
    PayWayQRCode = 7,
    PayWayWeChat = 6,
    PayWayCash = 1,
    PayWayCard = 2,
    PayWayTransfer = 3,
    PayWayOther = 4,
    PayWayNone = 0,
    PayWayGive = 5,
} PayWay;

typedef enum : NSUInteger {
    CheckTypeCheckin,
    CheckTypeCheckout,
} CheckType;

typedef enum : NSUInteger {
    CheckinTypeCheckin = 1,
    CheckinTypeCancel = 2,
    CheckinTypeUncheckout = 4,
    CheckinTypeCheckout = 5,
    CheckinTypeNone = 0,
} CheckinType;

typedef enum : NSUInteger {
    MessageTypeCourse = 1,
    MessageTypeSystem = 2,
    MessageTypeMeeting = 3,
    MessageTypeNone = 0,
} MessageType;

#ifndef Enum_h
#define Enum_h


#endif /* Enum_h */
