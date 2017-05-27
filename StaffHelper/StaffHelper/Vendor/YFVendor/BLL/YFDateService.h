//
//  YFDateService.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <UIKit/UIKit.h>

@interface YFDateService : NSObject


/**
 *单例日期格式
 */
+(NSDateFormatter *)dateformatter;

/**
 *得到当前日期
 */
+ (NSString *)getTodayDate:(NSString *)formatString;

/**
 *得到明天日期
 */
+ (NSString *)getTomorrowDate:(NSString *)formatString;

/**
 * 得到当前日期
 */
+(NSString *)nowDateDay;

// 得到今天相差 days 天数的日期， +days formatString默认 @"yyyy-MM-dd"
+ (NSString *)getDateFromDays:(NSInteger )days formating:(NSString *)formatString;


/**
 * 根据 字符串 得到 NSDate
 formatString  字符串日期格式
 */
+ (NSDate *)getDateFromDateString:(NSString *)DateString formatString:(NSString *)formatString;

+(NSDate *)timeStringFromStringOrNumber:(NSString *)timestr formatString:(NSString *)formatString;

+(NSString *)timeStringFromStringOrNumberKnowledge:(NSString *)timestr;

+(NSString *)timeStringFromDaeKnowledgeYF:(NSDate *)date time:(NSTimeInterval )timeIntervalcreat;

+(NSString *)timeYearMOnthStringFromStringOrNumber:(NSString *)timestr;

/**
 * endDate 和当前 日期相差天数
 */
+ (NSInteger) calcDaysCurrentToDateString:(NSString *)endDatestr;

/**
 * endDate 和 startDate 相差 时间
 */
+ (NSInteger) calcDaysCurrentToDateString:(NSString *)endDatestr startDate:(NSString *)startDateStr;

/**
 *timeInterval 秒
 */
+(NSString *)timeStringFromInterval:(NSTimeInterval )timeInterval;

/**
 *  date, 下拉 刷新 用
 */
+(NSString *)timeStringFromDae:(NSDate *)date;

+(NSString *)timeStringFromStringOrNumber:(NSString *)timestr;

+ (NSString *)getDateFromdate:(NSDate *)curDate Days:(NSInteger )days formating:(NSString *)formatString;

@end
