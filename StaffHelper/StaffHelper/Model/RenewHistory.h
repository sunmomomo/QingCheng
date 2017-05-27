//
//  RenewHistory.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Staff.h"

typedef enum : NSUInteger {
    RenewHistoryTypeNone = 0,
    RenewHistoryTypeCash = 1,
    RenewHistoryTypeCard = 2,
    RenewHistoryTypeTransfer = 3,
    RenewHistoryTypeAdmin = 4,
    RenewHistoryTypeQingCheng = 11,
    RenewHistoryTypeWeixin = 12,
    RenewHistoryTypeWeixinQRCode = 13,
    RenewHistoryTypeAlipay = 14,
} RenewHistoryType;

@interface RenewHistory : NSObject

@property(nonatomic,assign)NSInteger historyId;

@property(nonatomic,assign)BOOL success;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,copy)NSString *realPrice;

@property(nonatomic,strong)Staff *staff;

@property(nonatomic,assign)RenewHistoryType type;

@end
