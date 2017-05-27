//
//  ScheduleReportDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/11.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "User.h"

#import "OrderReport.h"

typedef enum : NSUInteger {
    ScheduleReportDetailPayTypeCard,
    ScheduleReportDetailPayTypeOnline,
    ScheduleReportDetailPayTypeWechat,
    ScheduleReportDetailPayTypeNopay,
    ScheduleReportDetailPayTypeWechatCode,
} ScheduleReportDetailPayType;

typedef enum : NSUInteger {
    ScheduleReportDetailPayStatusCreate=0,
    ScheduleReportDetailPayStatusDone=1,
    ScheduleReportDetailPayStatusCancel=2,
    ScheduleReportDetailPayStatusFail=3,
    ScheduleReportDetailPayStatusSignin=4,
} ScheduleReportDetailPayStatus;

@interface SecheduleReportDetailModel : NSObject

@property(nonatomic,strong)User *user;

@property(nonatomic,assign)ScheduleReportDetailPayStatus status;

@property(nonatomic,assign)ScheduleReportDetailPayType type;

@property(nonatomic,strong)Card *card;

@property(nonatomic,copy)NSString *time;

@property(nonatomic,assign)NSInteger count;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)float realPrice;

@end

@interface ScheduleReportDetailInfo : NSObject

@property(nonatomic,strong)NSArray *orders;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL allTimeCard;

@property(nonatomic,assign)NSInteger serviceCount;

@property(nonatomic,assign)float price;

@property(nonatomic,assign)float realPrice;

@property(nonatomic,assign)NSInteger times;

@property(nonatomic,strong)RequestCallBack callBack;

-(void)requestWithReport:(OrderReport*)report result:(RequestCallBack)result;

@end
