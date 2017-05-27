//
//  AllReportInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AllReportInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/staffs/%ld/reports/%@/glance/"

@interface AllReportInfo ()

{
    
    ReportInfoType _type;
    
}

@end

@implementation AllReportInfo

-(instancetype)initWithType:(ReportInfoType)type
{
    
    if (self = [super init]) {
        
        _type = type;
        
        self.totalReportInfo = [[ReportInfo alloc]init];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]];
        
        NSInteger weekday = [components weekday];
        
        weekday --;
        
        if(weekday == 0){
            
            weekday = 7;
            
        }
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
        
        NSInteger numberOfDaysInMonth = range.length;
        
        self.totalReportInfo.todayReport.fromDate = [dateFormatter stringFromDate:[NSDate date]];
        
        self.totalReportInfo.todayReport.toDate = [dateFormatter stringFromDate:[NSDate date]];
        
        self.totalReportInfo.weekReport.fromDate = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-86400*(weekday-1) sinceDate:[NSDate date]]];
        
        self.totalReportInfo.weekReport.toDate = [dateFormatter stringFromDate:[NSDate dateWithTimeInterval:86400*(7-weekday) sinceDate:[NSDate date]]];
        
        self.totalReportInfo.monthReport.fromDate = [[[dateFormatter stringFromDate:[NSDate date]]substringToIndex:8]stringByAppendingString:@"01"];
        
        self.totalReportInfo.monthReport.toDate = [NSString stringWithFormat:@"%@%ld",[self.totalReportInfo.monthReport.fromDate substringToIndex:8],(long)numberOfDaysInMonth];
        
    }
    
    return self;
    
}

-(void)requestInfoWithGym:(Gym *)gym result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    NSString *typeStr = @"";
    
    if (_type == ReportInfoTypeSell) {
        
        typeStr = @"sells";
        
    }else if(_type == ReportInfoTypeSchedule)
    {
        
        typeStr = @"schedules";
        
    }else{
        
        typeStr = @"checkin";
        
    }
    
    NSString *api = [NSString stringWithFormat:API,StaffId,typeStr];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            if (_type == ReportInfoTypeSchedule) {
                
                [self createSchedulesDataWithDict:responseDic[@"data"]];
                
            }else if (_type == ReportInfoTypeSell)
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

-(void)createCheckinDataWithDict:(NSDictionary *)dict
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]];
    
    NSInteger weekday = [components weekday];
    
    weekday --;
    
    if(weekday == 0){
        
        weekday = 7;
        
    }
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    
    NSInteger numberOfDaysInMonth = range.length;
    
    self.totalReportInfo.weekReport.checkinNum = [dict[@"week"][@"total_count"] floatValue];
    
    self.totalReportInfo.weekReport.fromDate = [dict[@"week"][@"from_date"] length]?dict[@"week"][@"from_date"]:[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-86400*(weekday-1) sinceDate:[NSDate date]]];
    
    self.totalReportInfo.weekReport.toDate = [dict[@"week"][@"to_date"] length]?dict[@"week"][@"to_date"]:[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:86400*(7-weekday) sinceDate:[NSDate date]]];
    
    self.totalReportInfo.monthReport.checkinNum = [dict[@"month"][@"total_count"] floatValue];
    
    self.totalReportInfo.monthReport.fromDate = [dict[@"month"][@"from_date"] length]?dict[@"month"][@"from_date"] :[[[dateFormatter stringFromDate:[NSDate date]]substringToIndex:8]stringByAppendingString:@"01"];
    
    self.totalReportInfo.monthReport.toDate = [dict[@"month"][@"to_date"] length]?dict[@"month"][@"to_date"]:[NSString stringWithFormat:@"%@%ld",[self.totalReportInfo.monthReport.fromDate substringToIndex:8],(long)numberOfDaysInMonth];
    
    self.totalReportInfo.todayReport.checkinNum = [dict[@"today"][@"total_count"]floatValue];
    
    self.totalReportInfo.todayReport.fromDate = [dict[@"today"][@"from_date"] length]?dict[@"today"][@"from_date"]:[dateFormatter stringFromDate:[NSDate date]];
    
    self.totalReportInfo.todayReport.toDate = [dict[@"today"][@"to_date"] length]?dict[@"today"][@"to_date"]:[dateFormatter stringFromDate:[NSDate date]];;
    
}

-(void)createSellDataWithDict:(NSDictionary *)dict
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];

    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateComponents *components = [calendar components:NSCalendarUnitWeekday fromDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]];
    
    NSInteger weekday = [components weekday];
    
    weekday --;
    
    if(weekday == 0){
        
        weekday = 7;
        
    }
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
    
    NSInteger numberOfDaysInMonth = range.length;
    
    self.totalReportInfo.weekReport.cost = [dict[@"week"][@"total_cost"] floatValue];
    
    self.totalReportInfo.weekReport.fromDate = [dict[@"week"][@"from_date"] length]?dict[@"week"][@"from_date"]:[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:-86400*(weekday-1) sinceDate:[NSDate date]]];
    
    self.totalReportInfo.weekReport.toDate = [dict[@"week"][@"to_date"] length]?dict[@"week"][@"to_date"]:[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:86400*(7-weekday) sinceDate:[NSDate date]]];
    
    self.totalReportInfo.monthReport.cost = [dict[@"month"][@"total_cost"] floatValue];
    
    self.totalReportInfo.monthReport.fromDate = [dict[@"month"][@"from_date"] length]?dict[@"month"][@"from_date"] :[[[dateFormatter stringFromDate:[NSDate date]]substringToIndex:8]stringByAppendingString:@"01"];
    
    self.totalReportInfo.monthReport.toDate = [dict[@"month"][@"to_date"] length]?dict[@"month"][@"to_date"]:[NSString stringWithFormat:@"%@%ld",[self.totalReportInfo.monthReport.fromDate substringToIndex:8],(long)numberOfDaysInMonth];
    
    self.totalReportInfo.todayReport.cost = [dict[@"today"][@"total_cost"]floatValue];
    
    self.totalReportInfo.todayReport.fromDate = [dict[@"today"][@"from_date"] length]?dict[@"today"][@"from_date"]:[dateFormatter stringFromDate:[NSDate date]];
    
    self.totalReportInfo.todayReport.toDate = [dict[@"today"][@"to_date"] length]?dict[@"today"][@"to_date"]:[dateFormatter stringFromDate:[NSDate date]];;
    
}

-(void)createSchedulesDataWithDict:(NSDictionary *)dict
{
    
    self.totalReportInfo.weekReport.serviceNum = [dict[@"week"][@"user_count"] integerValue];
    
    self.totalReportInfo.weekReport.appointmentNum = [dict[@"week"][@"order_count"]integerValue];
    
    self.totalReportInfo.weekReport.courseNum = [dict[@"week"][@"course_count"] integerValue];
    
    self.totalReportInfo.weekReport.fromDate = dict[@"week"][@"from_date"];
    
    self.totalReportInfo.weekReport.toDate = dict[@"week"][@"to_date"];
    
    self.totalReportInfo.monthReport.serviceNum = [dict[@"month"][@"user_count"] integerValue];
    
    self.totalReportInfo.monthReport.appointmentNum = [dict[@"month"][@"order_count"]integerValue];
    
    self.totalReportInfo.monthReport.courseNum = [dict[@"month"][@"course_count"] integerValue];
    
    self.totalReportInfo.monthReport.fromDate = dict[@"month"][@"from_date"];
    
    self.totalReportInfo.monthReport.toDate = dict[@"month"][@"to_date"];
    
    self.totalReportInfo.todayReport.serviceNum = [dict[@"today"][@"user_count"]integerValue];
    
    self.totalReportInfo.todayReport.appointmentNum = [dict[@"today"][@"order_count"]integerValue];
    
    self.totalReportInfo.todayReport.courseNum = [dict[@"today"][@"course_count"] integerValue];
    
    self.totalReportInfo.todayReport.fromDate = dict[@"today"][@"from_date"];
    
    self.totalReportInfo.todayReport.toDate = dict[@"today"][@"to_date"];
    
}


@end
