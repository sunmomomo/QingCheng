//
//  IntegralHistory.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    IntegralHistoryTypeGroup,
    IntegralHistoryTypeGroupCancel,
    IntegralHistoryTypePrivate,
    IntegralHistoryTypePrivateCancel,
    IntegralHistoryTypeCheckin,
    IntegralHistoryTypeCheckinCancel,
    IntegralHistoryTypeCharge,
    IntegralHistoryTypeRecharge,
    IntegralHistoryTypeAdd,
    IntegralHistoryTypeSub,
} IntegralHistoryType;

@interface IntegralHistory : NSObject

@property(nonatomic,assign)NSInteger historyId;

@property(nonatomic,assign)float integral;

@property(nonatomic,assign)float currentIntegral;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *staffName;

@property(nonatomic,copy)NSString *place;

@property(nonatomic,copy)NSString *award;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,assign)IntegralHistoryType type;

@end
