//
//  Message.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    MessageTypeCheckin=1,
    MessageTypeCheckout=2,
    MessageTypeOrder=3,
    MessageTypeOrderCancel=4,
    MessageTypeScore=5,
    MessageTypeTeamError=6,
    MessageTypeCoach=7,
    MessageTypeCheckinConfirm=8,
    MessageTypeCheckoutConfirm=9,
    MessageTypeChangeSeller=11,
    MessageTypeWithoutSeller=12,
    MessageTypeCardNoSufficient=13,
    MessageTypeChangeCoach=16,// 分配教练 该推送暂时 未加，教练助手 已添加
    MessageTypeMeetingPay=10001,
    MessageTypeMeetingTicket=10002,
    MessageTypeMeetingPayCertificates=10003,
    MessageTypeMeetingSchedules=10004,
    MessageTypeMeetingSchedulesCancel=10005,
    MessageTypeMeetingCertificates=10006,
    MessageTypeMeetingPayCheck=10007,
    MessageTypeMeetingPayCheckFail=10008,
    MessageTypeCompettiionReview=20004,
} MessageType;

@interface Message : NSObject

- (instancetype)initWithMessageJson:(NSDictionary *)json;

@property(nonatomic,assign)NSInteger msgId;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *place;

@property(nonatomic,copy)NSString *content;

@property(nonatomic, copy)NSString *cardId;

@property(nonatomic,assign)BOOL readed;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)MessageType type;

// 是否可以 跳往 非 WebView 页面
- (BOOL)canGoToNotWebVC;

@end
