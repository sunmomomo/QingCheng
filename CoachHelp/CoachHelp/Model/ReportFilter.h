//
//  ReportFilter.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/30.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

#import "Coach.h"

#import "Student.h"

#import "Staff.h"

#import "Seller.h"

#import "CardKind.h"

typedef enum : NSUInteger {
    ReportInfoTypeCheckin = 2,
    ReportInfoTypeSell = 1,
    ReportInfoTypeSchedule = 0,
} ReportInfoType;

@interface ReportFilter : NSObject

@property(nonatomic,copy)NSString *startDate;

@property(nonatomic,copy)NSString *endDate;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Student *student;

@property(nonatomic,assign)PayWay payWay;

@property(nonatomic,assign)TradeType tradeType;

@property(nonatomic,strong)Seller *seller;

@property(nonatomic,strong)CardKind *cardKind;

@property(nonatomic,assign)ReportInfoType infoType;

@property(nonatomic,assign)CheckinType checkinType;

@property(nonatomic,assign)BOOL allGroup;

@property(nonatomic,assign)BOOL allPrivate;

@property(nonatomic,assign)BOOL allPrepaidCardKind;

@property(nonatomic,assign)BOOL allCountCardKind;

@property(nonatomic,assign)BOOL allTimeCardKind;

@property(nonatomic,assign)BOOL isCustom;

@end
