//
//  Enum.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSInteger {
    SexTypeMan=0,
    SexTypeWoman=1,
    SexTypeUnknow=-1,
} SexType;

typedef enum : NSUInteger {
    PayTypeCreate,
    PayTypeRecharge,
    PayTypeCost,
} PayType;

typedef enum : NSUInteger {
    TradeTypeCreate = 3,
    TradeTypeRecharge = 1,
    TradeTypeGive = 13,
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
    UserTypeFollowing = 1,
    UserTypeNewRegister = 0,
    UserTypeNormal = 2,
} UserType;

typedef enum : NSUInteger {
    YFSmsTypeNone = 0,
    YFSmsTypeSuccess = 1,
    YFSmsTypeDraft = 2,
} YFSmsType;

#define YFIsRegisterTimeKey @"YFIsRegisterTimeKey"
typedef enum : NSUInteger {
    YFIsRegisterTimeTypeNone = 0,
    YFIsRegisterTimeTypeToday = 1,
    YFIsRegisterTimeTypeSeven = 2,
    YFIsRegisterTimeTypeThirty = 3,
} YFIsRegisterTimeType;

#ifndef Enum_h
#define Enum_h


#endif /* Enum_h */
