//
//  ORDetailInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ORDetailInfo.h"

@interface ORDetailInfo ()

{
    
    NSMutableArray *_array;
    
    ReportFilter *_filter;
    
    NSArray *_allReportCardKinds;
    
    NSArray *_allReportCourses;
    
    NSArray *_allReportTrades;
    
}

@end

@implementation ORDetailInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.cardKinds = [NSMutableArray array];
        
        self.prepaidCardKinds = [NSMutableArray array];
        
        self.timeCardKinds = [NSMutableArray array];
        
        self.countCardKinds = [NSMutableArray array];
        
        self.groups = [NSMutableArray array];
        
        self.privates = [NSMutableArray array];
        
        self.courses = [NSMutableArray array];
        
    }
    return self;
}

-(void)requestWithFilter:(ReportFilter *)filter andGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    _filter = filter;
    
    Parameters *para = [[Parameters alloc]init];
    
    NSString *api;
    
    switch (filter.infoType) {
        case ReportInfoTypeSchedule:
            
            api = @"/api/v2/coaches/%ld/reports/schedules/";
            
            break;
            
        case ReportInfoTypeSell:
            
            api = @"/api/v2/coaches/%ld/reports/sells/";
            
            break;
            
        case ReportInfoTypeCheckin:
            
            api = @"/api/staffs/%ld/reports/checkin/";
            
            break;
            
        default:
            break;
    }
    
    [para setParameter:filter.startDate forKey:@"start"];
    
    [para setParameter:filter.endDate forKey:@"end"];
    
    if (AppGym.gymId && AppGym.type.length) {
        
        [para setParameter:AppGym.type forKey:@"model"];
        
        [para setInteger:AppGym.gymId forKey:@"id"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setInteger:AppGym.shopId forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    if (filter.course.courseId) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.course.courseId] forKey:@"course_id"];
        
    }
    
    if (filter.cardKind.cardKindId) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.cardKind.cardKindId] forKey:@"card__card_tpl_id"];
        
    }
    
    if (filter.seller.sellerId) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.seller.sellerId] forKey:@"seller_id"];
        
    }
    
    if (filter.payWay) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.payWay] forKey:@"charge_type"];
        
    }
    
    if (filter.tradeType) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.tradeType] forKey:@"type"];
        
    }
    
    if (filter.coach.coachId) {
        
        [para setParameter:[NSNumber numberWithInteger:filter.coach.coachId] forKey:@"teacher_id"];
        
    }
    
    if (filter.allPrepaidCardKind) {
        
        [para setParameter:@"all_value" forKey:@"cards_extra"];
        
    }else if (filter.allTimeCardKind){
        
        [para setParameter:@"all_time" forKey:@"cards_extra"];
        
    }else if (filter.allCountCardKind){
        
        [para setParameter:@"all_times" forKey:@"cards_extra"];
        
    }
    
    if (filter.allGroup) {
        
        [para setParameter:@"all_public" forKey:@"course_extra"];
        
    }else if (filter.allPrivate){
        
        [para setParameter:@"all_private" forKey:@"course_extra"];
        
    }
    
    if (filter.checkinType) {
        
        [para setInteger:filter.checkinType-1 forKey:@"status"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:api,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            if (filter.infoType == ReportInfoTypeSchedule) {
                
                [self createSchedulesDataWithDict:responseDic[@"data"]];
                
            }else if (filter.infoType == ReportInfoTypeSell)
            {
                
                [self createSellDataWithDict:responseDic[@"data"]];
                
            }else{
                
                [self createCheckinDataWithDict:responseDic[@"data"]];
                
            }
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)createCheckinDataWithDict:(NSDictionary*)dict
{
    
    _array = [NSMutableArray array];
    
    self.reportCardKinds = [NSArray array];
    
    self.users = [NSMutableArray array];
    
    NSArray *array = dict[@"checkins"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        CheckinReport *report = [[CheckinReport alloc]init];
        
        report.gymName = obj[@"shop"][@"name"];
        
        report.cost = [obj[@"cost"] floatValue];
        
        report.receive = [obj[@"real_price"] floatValue];
        
        report.user = [[Student alloc]init];
        
        report.user.name = obj[@"user"][@"username"];
        
        report.user.stuId = [obj[@"user"][@"id"] integerValue];
        
        report.user.avatar = [NSURL URLWithString:obj[@"user"][@"avatar"]];
        
        report.user.photo = [NSURL URLWithString:obj[@"user"][@"checkin_avatar"]];
        
        report.checkoutTime = [obj[@"checkout_at"]stringByReplacingOccurrencesOfString:@"T" withString:@"  "];
        
        BOOL contains = NO;
        
        for (Student *stu in self.users) {
            
            if (stu.stuId == report.user.stuId) {
                
                contains = YES;
                
            }
            
        }
        
        if (!contains) {
            
            [self.users addObject:report.user];
            
        }
        
        report.checkinType = [obj[@"status"] integerValue]+1;
        
        if ([obj[@"created_at"] length]) {
            
            report.createTime = [obj[@"created_at"] substringWithRange:NSMakeRange(11, 5)];
            
            report.date = [obj[@"created_at"] substringToIndex:10];
            
        }
        
        NSDictionary *cardObj = obj[@"card"];
        
        Card *card = [[Card alloc]init];
        
        card.cardId = [cardObj[@"id"] integerValue];
        
        CardKind *cardKind = [[CardKind alloc]init];
        
        cardKind.cardKindName = cardObj[@"name"];
        
        cardKind.type = [cardObj[@"card_tpl_type"] integerValue];
        
        cardKind.cardKindId = [cardObj[@"card_tpl_id"] integerValue];
        
        card.cardKind = cardKind;
        
        BOOL cardContains = NO;
        
        for (CardKind *tempCardKind in self.cardKinds) {
            
            if (tempCardKind.cardKindId == cardKind.cardKindId) {
                
                cardContains = YES;
                
                break;
                
            }
            
        }
        
        if (!cardContains) {
            
            [self.cardKinds addObject:cardKind];
            
        }
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            BOOL prepaidContains = NO;
            
            for (CardKind *tempCardKind in self.prepaidCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    prepaidContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!prepaidContains) {
                
                [self.prepaidCardKinds addObject:cardKind];
                
            }
            
        }else if (cardKind.type == CardKindTypeTime){
            
            BOOL timeContains = NO;
            
            for (CardKind *tempCardKind in self.timeCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    timeContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!timeContains) {
                
                [self.timeCardKinds addObject:cardKind];
                
            }
            
        }else if (cardKind.type == CardKindTypeCount){
            
            BOOL countContains = NO;
            
            for (CardKind *tempCardKind in self.countCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    countContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!countContains) {
                
                [self.countCardKinds addObject:cardKind];
                
            }
            
        }
        
        report.card = card;
        
        [_array addObject:report];
        
    }];
    
    [self createReportArray];
    
}

-(void)createSellDataWithDict:(NSDictionary*)dict
{
    
    _array = [NSMutableArray array];
    
    self.reportCardKinds = [NSArray array];
    
    self.reportTrades = [NSArray array];
    
    self.users = [NSMutableArray array];
    
    self.sellers = [NSMutableArray array];
    
    self.cost = [dict[@"total_account"] integerValue];
    
    NSArray *array = dict[@"histories"];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        SellReport *report = [[SellReport alloc]init];
        
        NSString *userStr = @"";
        
        NSArray *users = obj[@"users"];
        
        NSMutableArray *reportUsers = [NSMutableArray array];
        
        for (NSDictionary *userObj in users) {
            
            Student *user = [[Student alloc]init];
            
            user.name = userObj[@"username"];
            
            user.stuId = [userObj[@"id"] integerValue];
            
            BOOL contains = NO;
            
            for (Student *stu in self.users) {
                
                if (stu.stuId == user.stuId) {
                    
                    contains = YES;
                    
                }
                
            }
            
            if (!contains) {
                
                [self.users addObject:user];
                
            }
            
            userStr = [userStr stringByAppendingString:userObj[@"username"]];
            
            if ([users indexOfObject:userObj]<users.count-1) {
                
                userStr = [userStr stringByAppendingString:@"、"];
                
            }
            
            [reportUsers addObject:user];
            
        }
        
        report.users = [reportUsers copy];
        
        report.userName = userStr;
        
        report.cost = -[obj[@"cost"] floatValue];
        
        report.account = [obj[@"account"] floatValue];
        
        report.remarks = obj[@"remarks"];
        
        report.createTime = obj[@"created_at"];
        
        report.date = [report.createTime substringToIndex:10];
        
        report.seller.name = obj[@"seller"][@"username"];
        
        report.seller.sellerId = [obj[@"seller"][@"id"] integerValue];
        
        if (report.seller.name.length) {
            
            BOOL contains = NO;
            
            for (Seller *seller in self.sellers) {
                
                if (seller.sellerId == report.seller.sellerId) {
                    
                    contains = YES;
                    
                }
                
            }
            
            if (!contains) {
                
                [self.sellers addObject:report.seller];
                
            }
            
        }
        
        NSDictionary *cardObj = obj[@"card"];
        
        Card *card = [[Card alloc]init];
        
        card.cardId = [cardObj[@"id"] integerValue];
        
        card.cardNumber = cardObj[@"card_no"];
        
        CardKind *cardKind = [[CardKind alloc]init];
        
        cardKind.cardKindName = cardObj[@"name"];
        
        cardKind.type = [cardObj[@"card_type"] integerValue];
        
        cardKind.cardKindId = [cardObj[@"card_tpl_id"] integerValue];
        
        card.cardKind = cardKind;
        
        BOOL cardContains = NO;
        
        for (CardKind *tempCardKind in self.cardKinds) {
            
            if (tempCardKind.cardKindId == cardKind.cardKindId) {
                
                cardContains = YES;
                
                break;
                
            }
            
        }
        
        if (!cardContains) {
            
            [self.cardKinds addObject:cardKind];
            
        }
        
        if (cardKind.type == CardKindTypePrepaid) {
            
            BOOL prepaidContains = NO;
            
            for (CardKind *tempCardKind in self.prepaidCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    prepaidContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!prepaidContains) {
                
                [self.prepaidCardKinds addObject:cardKind];
                
            }
            
        }else if (cardKind.type == CardKindTypeTime){
            
            BOOL timeContains = NO;
            
            for (CardKind *tempCardKind in self.timeCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    timeContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!timeContains) {
                
                [self.timeCardKinds addObject:cardKind];
                
            }
            
        }else if (cardKind.type == CardKindTypeCount){
            
            BOOL countContains = NO;
            
            for (CardKind *tempCardKind in self.countCardKinds) {
                
                if (tempCardKind.cardKindId == cardKind.cardKindId) {
                    
                    countContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!countContains) {
                
                [self.countCardKinds addObject:cardKind];
                
            }
            
        }
        
        report.card = card;
        
        report.tradeType = [obj[@"type"] integerValue];
        
        report.payWay = [obj[@"charge_type"] integerValue];
        
        [_array addObject:report];
        
    }];
    
    [self createReportArray];
    
}

-(void)createSchedulesDataWithDict:(NSDictionary*)dict
{
    
    _array = [NSMutableArray array];
    
    self.reportCardKinds = [NSArray array];
    
    self.reportCourses = [NSArray array];
    
    self.users = [NSMutableArray array];
    
    self.coaches = [NSMutableArray array];
    
    self.courseCount = [dict[@"stat"][@"course_count"] integerValue];
    
    self.userCount = [dict[@"stat"][@"user_count"] integerValue];
    
    self.orderCount = [dict[@"stat"][@"order_count"] integerValue];
    
    NSArray *array = dict[@"schedules"];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        OrderReport *report = [[OrderReport alloc]init];
        
        report.count = [obj[@"count"] integerValue];
        
        report.orderCount = [obj[@"order_count"] integerValue];
        
        report.start = obj[@"start"];
        
        report.end = obj[@"end"];
        
        report.reportId = [obj[@"id"] integerValue];
        
        report.gymName = obj[@"shop"][@"name"];
        
        if ([obj[@"start"] length]>=10) {
            
            report.date = [obj[@"start"] substringToIndex:10];
            
        }
        
        report.course.courseId = [obj[@"course"][@"id"] integerValue];
        
        report.course.name = obj[@"course"][@"name"];
        
        report.course.imgUrl = [NSURL URLWithString:obj[@"course"][@"photo"]];
        
        report.course.count = [obj[@"course"][@"count"] integerValue];
        
        report.course.type = [obj[@"course"][@"is_private"] boolValue]?CourseTypePrivate:CourseTypeGroup;
        
        BOOL courseContains = NO;
        
        for (Course *tempCourse in self.courses) {
            
            if (tempCourse.courseId == report.course.courseId) {
                
                courseContains = YES;
                
                break;
                
            }
            
        }
        
        if (!courseContains) {
            
            [self.courses addObject:report.course];
            
        }
        
        if (report.course.type == CourseTypeGroup) {
            
            BOOL groupContains = NO;
            
            for (Course *tempCourse in self.groups) {
                
                if (tempCourse.courseId == report.course.courseId) {
                    
                    groupContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!groupContains) {
                
                [self.groups addObject:report.course];
                
            }
            
        }else if (report.course.type == CourseTypePrivate){
            
            BOOL privateContains = NO;
            
            for (Course *tempCourse in self.privates) {
                
                if (tempCourse.courseId == report.course.courseId) {
                    
                    privateContains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!privateContains) {
                
                [self.privates addObject:report.course];
                
            }
            
        }
        
        Coach *coach = [[Coach alloc]init];
        
        coach.coachId = [obj[@"teacher"][@"id"] integerValue];
        
        coach.name = obj[@"teacher"][@"username"];
        
        report.coach = coach;
        
        BOOL containCoach = NO;
        
        for (Coach *tempCoach in self.coaches) {
            
            if (tempCoach.coachId == coach.coachId) {
                
                containCoach = YES;
                
                break;
                
            }
            
        }
        
        if (!containCoach) {
            
            [self.coaches addObject:coach];
            
        }
        
        NSArray *orders = obj[@"orders"];
        
        NSMutableArray *courseOrders = [NSMutableArray array];
        
        __block float realPrice = 0;
        
        [orders enumerateObjectsUsingBlock:^(id  _Nonnull orderObj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            ReportOrder *order = [[ReportOrder alloc]init];
            
            order.price = [orderObj[@"total_price"] floatValue];
            
            order.realPrice = [orderObj[@"total_real_price"] floatValue];
            
            realPrice += order.realPrice;
            
            order.count = [orderObj[@"count"] integerValue];
            
            NSDictionary *cardObj = orderObj[@"card"];
            
            CardKind *cardKind = [[CardKind alloc]init];
            
            cardKind.cardKindName = cardObj[@"name"];
            
            if ([orderObj[@"channel"] isEqualToString:@"CARD"]) {
                
                cardKind.type = [cardObj[@"card_type"] integerValue];
                
            }else{
                
                cardKind.type = CardKindTypeOnline;
                
            }
            
            cardKind.cardKindId = [cardObj[@"card_tpl_id"] integerValue];
            
            order.cardKind = cardKind;
            
            NSDictionary *userDict = orderObj[@"user"];
            
            Student *user = [[Student alloc]init];
            
            user.name = userDict[@"username"];
            
            user.stuId = [userDict[@"id"] integerValue];
            
            BOOL contains = NO;
            
            for (Student *stu in self.users) {
                
                if (stu.stuId == user.stuId) {
                    
                    contains = YES;
                    
                }
                
            }
            
            if (!contains) {
                
                [self.users addObject:user];
                
            }
            
            order.user = user;
            
            [courseOrders addObject:order];
            
        }];
        
        report.realPrice = realPrice;
        
        report.orders = courseOrders;
        
        if (report.course.type == CourseTypeGroup) {
            
            report.users = [NSString stringWithFormat:@"%ld人次",(long)report.count];
            
        }else{
            
            NSString *str = @"";
            
            for (ReportOrder *order in report.orders) {
                
                str = [str stringByAppendingString:order.user.name];
                
                if ([report.orders indexOfObject:order]<report.orders.count-1) {
                    
                    str = [str stringByAppendingString:@"、"];
                    
                }
                
            }
            
            str = [str stringByAppendingString:[NSString stringWithFormat:@" %ld人次",(long)report.count]];
            
            report.users = str;
            
        }
        
        [_array addObject:report];
        
    }];
    
    [self createReportArray];
    
}

-(void)createReportArray
{
    
    self.reports = [NSMutableArray array];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSTimeInterval time = [[df dateFromString:_filter.endDate] timeIntervalSinceDate:[df dateFromString:_filter.startDate]];
    
    NSInteger days = time/86400+1;
    
    for (NSInteger i = 0; i<days; i++) {
        
        NSString *dateStr = [df stringFromDate:[NSDate dateWithTimeInterval:i*86400 sinceDate:[df dateFromString:_filter.startDate]]];
        
        NSMutableArray *tempArray = [NSMutableArray array];
        
        if (_filter.infoType == ReportInfoTypeSchedule) {
            
            [_array enumerateObjectsUsingBlock:^(OrderReport* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.date isEqualToString:dateStr]) {
                    
                    [tempArray addObject:obj];
                    
                }
                
            }];
            
        }else if (_filter.infoType == ReportInfoTypeSchedule)
        {
            
            [_array enumerateObjectsUsingBlock:^(SellReport *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.date isEqualToString:dateStr]) {
                    
                    [tempArray addObject:obj];
                    
                }
                
            }];
            
        }else{
            
            [_array enumerateObjectsUsingBlock:^(CheckinReport *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                if ([obj.date isEqualToString:dateStr]) {
                    
                    [tempArray addObject:obj];
                    
                }
                
            }];
            
        }
        
        if (tempArray.count) {
            
            NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:_filter.infoType == ReportInfoTypeSchedule?@"start":@"date" ascending:NO];
            
            NSArray *sorts = [NSArray arrayWithObjects:sortDescriptor, nil];
            
            tempArray = [[tempArray sortedArrayUsingDescriptors:sorts] mutableCopy];
            
            [self.reports addObject:@{@"date":dateStr,@"data":tempArray}];
            
        }
        
    }
    
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"date" ascending:NO];
    
    NSArray *sorts = [NSArray arrayWithObjects:sortDescriptor, nil];
    
    self.reports = [[self.reports sortedArrayUsingDescriptors:sorts] mutableCopy];
    
    self.showReports = [self.reports mutableCopy];
    
}

-(void)createFormData
{
    
    if (_filter.infoType == ReportInfoTypeSchedule) {
        
        CourseReportCardKind *prepaidCardKind = [[CourseReportCardKind alloc]init];
        
        prepaidCardKind.cardKindType = CardKindTypePrepaid;
        
        CourseReportCardKind *countCardKind = [[CourseReportCardKind alloc]init];
        
        countCardKind.cardKindType = CardKindTypeCount;
        
        CourseReportCardKind *timeCardKind = [[CourseReportCardKind alloc]init];
        
        timeCardKind.cardKindType = CardKindTypeTime;
        
        CourseReportCardKind *onlineCardKind = [[CourseReportCardKind alloc]init];
        
        onlineCardKind.cardKindType = CardKindTypeOnline;
        
        CourseReportCardKind *allCardKind = [[CourseReportCardKind alloc]init];
        
        allCardKind.cardKindType = CardKindTypeNone;
        
        CourseReportCourse *groupCourse = [[CourseReportCourse alloc]init];
        
        groupCourse.courseType = CourseTypeGroup;
        
        CourseReportCourse *privateCourse = [[CourseReportCourse alloc]init];
        
        privateCourse.courseType = CourseTypePrivate;
        
        CourseReportCourse *allCourse = [[CourseReportCourse alloc]init];
        
        allCourse.courseType = CourseTypeGroup;
        
        for (NSDictionary *dict in self.showReports) {
            
            NSArray *reports = dict[@"data"];
            
            for (OrderReport *report in reports) {
                
                for (ReportOrder *order in report.orders) {
                    
                    CardKind *cardKind = order.cardKind;
                    
                    switch (cardKind.type) {
                            
                        case CardKindTypePrepaid:
                            
                            prepaidCardKind.price += order.price;
                            
                            prepaidCardKind.receive += order.realPrice;
                            
                            prepaidCardKind.serviceCount += order.count;
                            
                            break;
                            
                        case CardKindTypeTime:
                            
                            timeCardKind.price += order.price;
                            
                            timeCardKind.receive += order.realPrice;
                            
                            timeCardKind.serviceCount += order.count;
                            
                            break;
                            
                        case CardKindTypeCount:
                            
                            countCardKind.price += order.price;
                            
                            countCardKind.receive += order.realPrice;
                            
                            countCardKind.serviceCount += order.count;
                            
                            break;
                            
                        case CardKindTypeOnline:
                            
                            onlineCardKind.price += order.price;
                            
                            onlineCardKind.receive += order.realPrice;
                            
                            onlineCardKind.serviceCount += order.count;
                            
                            break;
                            
                        default:
                            break;
                    }
                    
                    allCardKind.price += order.price;
                    
                    allCardKind.receive += order.realPrice;
                    
                    allCardKind.serviceCount += order.count;
                    
                }
                
                switch (report.course.type) {
                        
                    case CourseTypeGroup:
                        
                        groupCourse.courseCount ++;
                        
                        groupCourse.serviceCount += report.orderCount;
                        
                        break;
                        
                    case CourseTypePrivate:
                        
                        privateCourse.courseCount ++;
                        
                        privateCourse.serviceCount += report.orderCount;
                        
                        break;
                        
                    default:
                        break;
                }
                
                allCourse.courseCount ++;
                
                allCourse.serviceCount += report.orderCount;
                
            }
            
        }
        
        _allReportCardKinds = @[timeCardKind,countCardKind,prepaidCardKind,onlineCardKind,allCardKind];
        
        self.reportCardKinds = [_allReportCardKinds mutableCopy];
        
        _allReportCourses = @[groupCourse,privateCourse,allCourse];
        
        self.reportCourses = [_allReportCourses mutableCopy];
        
    }else if (_filter.infoType == ReportInfoTypeSell){
        
        SellReportCardKind *prepaidCardKind = [[SellReportCardKind alloc]init];
        
        prepaidCardKind.cardKindType = CardKindTypePrepaid;
        
        SellReportCardKind *countCardKind = [[SellReportCardKind alloc]init];
        
        countCardKind.cardKindType = CardKindTypeCount;
        
        SellReportCardKind *timeCardKind = [[SellReportCardKind alloc]init];
        
        timeCardKind.cardKindType = CardKindTypeTime;
        
        SellReportCardKind *allCardKind = [[SellReportCardKind alloc]init];
        
        allCardKind.cardKindType = CardKindTypeNone;
        
        SellReportTrade *allTrade = [[SellReportTrade alloc]init];
        
        allTrade.tradeType = TradeTypeNone;
        
        SellReportTrade *createTrade = [[SellReportTrade alloc]init];
        
        createTrade.tradeType = TradeTypeCreate;
        
        SellReportTrade *rechargeTrade = [[SellReportTrade alloc]init];
        
        rechargeTrade.tradeType = TradeTypeRecharge;
        
        SellReportTrade *giveTrade = [[SellReportTrade alloc]init];
        
        giveTrade.tradeType = TradeTypeGive;
        
        SellReportTrade *costTrade = [[SellReportTrade alloc]init];
        
        costTrade.tradeType = TradeTypeCost;
        
        for (NSDictionary *dict in self.showReports) {
            
            NSArray *reports = dict[@"data"];
            
            for (SellReport *report in reports) {
                
                CardKind *cardKind = report.card.cardKind;
                
                switch (cardKind.type) {
                        
                    case CardKindTypePrepaid:
                        
                        prepaidCardKind.tradeCount ++;
                        
                        prepaidCardKind.receive += report.account;
                        
                        prepaidCardKind.charge += report.cost;
                        
                        break;
                        
                    case CardKindTypeTime:
                        
                        timeCardKind.tradeCount ++;
                        
                        timeCardKind.receive += report.account;
                        
                        timeCardKind.charge += report.cost;
                        
                        break;
                        
                    case CardKindTypeCount:
                        
                        countCardKind.tradeCount ++;
                        
                        countCardKind.receive += report.account;
                        
                        countCardKind.charge += report.cost;
                        
                        break;
                        
                    default:
                        break;
                }
                
                allCardKind.tradeCount ++;
                
                allCardKind.receive += report.account;
                
                allCardKind.charge += report.cost;
                
                switch (report.tradeType) {
                        
                    case TradeTypeCreate:
                        
                        createTrade.tradeCount ++;
                        
                        createTrade.receive += report.account;
                        
                        break;
                        
                    case TradeTypeRecharge:
                        
                        rechargeTrade.tradeCount ++;
                        
                        rechargeTrade.receive += report.account;
                        
                        break;
                        
                    case TradeTypeGive:
                        
                        giveTrade.tradeCount ++;
                        
                        giveTrade.receive += report.account;
                        
                        break;
                        
                    case TradeTypeCost:
                        
                        costTrade.tradeCount ++;
                        
                        costTrade.receive += report.account;
                        
                        break;
                        
                    default:
                        break;
                }
                
                allTrade.tradeCount ++;
                
                allTrade.receive += report.account;
                
            }
            
        }
        
        _allReportCardKinds = @[timeCardKind,countCardKind,prepaidCardKind,allCardKind];
        
        self.reportCardKinds = [_allReportCardKinds mutableCopy];
        
        _allReportTrades = @[createTrade,rechargeTrade,giveTrade,costTrade,allTrade];
        
        self.reportTrades = [_allReportTrades mutableCopy];
        
    }else{
        
        CheckinReportCardKind *prepaidCardKind = [[CheckinReportCardKind alloc]init];
        
        prepaidCardKind.cardKindType = CardKindTypePrepaid;
        
        CheckinReportCardKind *countCardKind = [[CheckinReportCardKind alloc]init];
        
        countCardKind.cardKindType = CardKindTypeCount;
        
        CheckinReportCardKind *timeCardKind = [[CheckinReportCardKind alloc]init];
        
        timeCardKind.cardKindType = CardKindTypeTime;
        
        CheckinReportCardKind *allCardKind = [[CheckinReportCardKind alloc]init];
        
        allCardKind.cardKindType = CardKindTypeNone;
        
        for (NSDictionary *dict in self.showReports) {
            
            NSArray *reports = dict[@"data"];
            
            for (CheckinReport *report in reports) {
                
                CardKind *cardKind = report.card.cardKind;
                
                switch (cardKind.type) {
                        
                    case CardKindTypePrepaid:
                        
                        prepaidCardKind.checkinCount ++;
                        
                        prepaidCardKind.receive += report.receive;
                        
                        prepaidCardKind.cost += report.cost;
                        
                        break;
                        
                    case CardKindTypeTime:
                        
                        timeCardKind.checkinCount ++;
                        
                        timeCardKind.receive += report.receive;
                        
                        timeCardKind.cost += report.cost;
                        
                        break;
                        
                    case CardKindTypeCount:
                        
                        countCardKind.checkinCount ++;
                        
                        countCardKind.receive += report.receive;
                        
                        countCardKind.cost += report.cost;
                        
                        break;
                        
                    default:
                        break;
                }
                
                allCardKind.checkinCount ++;
                
                allCardKind.receive += report.receive;
                
                allCardKind.cost += report.cost;
                
            }
            
        }
        
        _allReportCardKinds = @[timeCardKind,countCardKind,prepaidCardKind,allCardKind];
        
        self.reportCardKinds = [_allReportCardKinds mutableCopy];
        
    }
    
}

-(void)filterWithFilter:(ReportFilter *)filter
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    self.showReports = [NSMutableArray array];
    
    if (_filter.infoType == ReportInfoTypeSchedule) {
        
        for (NSDictionary *dict in self.reports) {
            
            NSDate *date = [df dateFromString:dict[@"date"]];
            
            if ([date timeIntervalSinceDate:[df dateFromString:filter.startDate]]>=0 || [date timeIntervalSinceDate:[df dateFromString:filter.endDate]]<=0) {
                
                NSArray *reports = dict[@"data"];
                
                NSMutableArray *tempReports = [NSMutableArray array];
                
                for (OrderReport *report in reports) {
                    
                    BOOL canFilter = YES;
                    
                    if (filter.course.courseId) {
                        
                        if (report.course.courseId != filter.course.courseId) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.coach.coachId) {
                        
                        if (report.coach.coachId != filter.coach.coachId) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allGroup) {
                        
                        if (report.course.type != CourseTypeGroup) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allPrivate) {
                        
                        if (report.course.type != CourseTypePrivate) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (canFilter) {
                        
                        if (filter.student.stuId) {
                            
                            BOOL contains = NO;
                            
                            for (ReportOrder *order in report.orders) {
                                
                                if (order.user.stuId == filter.student.stuId) {
                                    
                                    contains = YES;
                                    
                                }
                                
                            }
                            
                            if (contains) {
                                
                                [tempReports addObject:report];
                                
                            }
                            
                        }else{
                            
                            [tempReports addObject:report];
                            
                        }
                        
                    }
                    
                }
                
                if (tempReports.count) {
                    
                    [self.showReports addObject:@{@"date":dict[@"date"],@"data":tempReports}];
                    
                }
                
            }
            
        }
        
    }else if (_filter.infoType == ReportInfoTypeSell){
        
        for (NSDictionary *dict in self.reports) {
            
            NSDate *date = [df dateFromString:dict[@"date"]];
            
            if ([date timeIntervalSinceDate:[df dateFromString:filter.startDate]]>=0 || [date timeIntervalSinceDate:[df dateFromString:filter.endDate]]<=0) {
                
                NSArray *reports = [dict[@"data"] mutableCopy];
                
                NSMutableArray *tempReports = [NSMutableArray array];
                
                for (SellReport *report in reports) {
                    
                    BOOL canFilter = YES;
                    
                    if (filter.cardKind.cardKindId) {
                        
                        if (report.card.cardKind.cardKindId != filter.cardKind.cardKindId) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allPrepaidCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypePrepaid) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allCountCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypeCount) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allTimeCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypeTime) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.payWay) {
                        
                        if (report.payWay != filter.payWay) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.tradeType) {
                        
                        if (report.tradeType != filter.tradeType) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.seller.sellerId) {
                        
                        if (report.seller.sellerId != filter.seller.sellerId) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (canFilter) {
                        
                        if (filter.student.stuId) {
                            
                            BOOL contains = NO;
                            
                            for (Student *user in report.users) {
                                
                                if (user.stuId == filter.student.stuId) {
                                    
                                    contains = YES;
                                    
                                }
                                
                            }
                            
                            if (contains) {
                                
                                [tempReports addObject:report];
                                
                            }
                            
                        }else{
                            
                            [tempReports addObject:report];
                            
                        }
                        
                    }
                    
                }
                
                if (tempReports.count) {
                    
                    [self.showReports addObject:@{@"date":dict[@"date"],@"data":tempReports}];
                    
                }
                
            }
            
        }
        
    }else{
        
        for (NSDictionary *dict in self.reports) {
            
            NSDate *date = [df dateFromString:dict[@"date"]];
            
            if ([date timeIntervalSinceDate:[df dateFromString:filter.startDate]]>=0 || [date timeIntervalSinceDate:[df dateFromString:filter.endDate]]<=0) {
                
                NSArray *reports = [dict[@"data"] mutableCopy];
                
                NSMutableArray *tempReports = [NSMutableArray array];
                
                for (CheckinReport *report in reports) {
                    
                    BOOL canFilter = YES;
                    
                    if (filter.cardKind.cardKindId) {
                        
                        if (report.card.cardKind.cardKindId != filter.cardKind.cardKindId) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allPrepaidCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypePrepaid) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allCountCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypeCount) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.allTimeCardKind) {
                        
                        if (report.card.cardKind.type != CardKindTypeTime) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (filter.checkinType) {
                        
                        if (report.checkinType != filter.checkinType) {
                            
                            canFilter = NO;
                            
                        }
                        
                    }
                    
                    if (canFilter) {
                        
                        if (filter.student.stuId) {
                            
                            if (report.user.stuId == filter.student.stuId) {
                                
                                [tempReports addObject:report];
                                
                            }
                            
                        }else{
                            
                            [tempReports addObject:report];
                            
                        }
                        
                    }
                    
                }
                
                if (tempReports.count) {
                    
                    [self.showReports addObject:@{@"date":dict[@"date"],@"data":tempReports}];
                    
                }
                
            }
            
        }
        
    }
    
    [self createFormData];
    
}

@end
