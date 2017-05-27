//
//  YFDateService.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDateService.h"
#import "NSObject+YFExtension.h"

@implementation YFDateService


//日期格式
+(NSDateFormatter *)dateformatter{
    
    static NSDateFormatter * dateFormatter;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        dateFormatter=[[NSDateFormatter alloc] init] ;
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    });
    
    return dateFormatter;
}


+ (NSString *)getTodayDate:(NSString *)formatString
{
    if (formatString.length == 0) {
        formatString = @"yyyy-MM-dd";
    }
    NSDate *curDate = [NSDate date];
    NSDateFormatter *formater = [YFDateService  dateformatter];
    [formater setDateFormat:formatString];
    NSString * curTime = [formater stringFromDate:curDate];
    
    return curTime;
}

+ (NSDate *)getDateFromDateString:(NSString *)DateString formatString:(NSString *)formatString
{
    if (formatString.length == 0) {
        formatString = @"yyyy-MM-dd";
    }
    
    NSDateFormatter *formater = [YFDateService  dateformatter];
    [formater setDateFormat:formatString];
    return [formater dateFromString:DateString];;
}

+ (NSString *)getTomorrowDate:(NSString *)formatString
{
    NSDate *curDate = [NSDate date];
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:curDate];
    [components setDay:([components day]+1)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [YFDateService  dateformatter];
    [dateday setDateFormat:formatString];
    return [dateday stringFromDate:beginningOfWeek];
}

+ (NSInteger) calcDaysCurrentToDateString:(NSString *)endDatestr
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[self class]dateformatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatter dateFromString:endDatestr];
    
    return [self calcDaysFromEnd:[NSDate date] start:endDate];
}

+ (NSInteger) calcDaysCurrentToDateString:(NSString *)endDatestr startDate:(NSString *)startDateStr
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[self class]dateformatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *endDate = [dateFormatter dateFromString:endDatestr];
    
    NSDate *startDate = [dateFormatter dateFromString:startDateStr];

    
    return [self calcDaysFromEnd:endDate start:startDate];
}
//计算两个日期之间的天数
+ (NSInteger) calcDaysFromEnd:(NSDate *)beginDate start:(NSDate *)endDate
{
    //创建日期格式化对象
    NSDateFormatter *dateFormatter=[[self class]dateformatter];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    
    //取两个日期对象的时间间隔：
    //这里的NSTimeInterval 并不是对象，是基本型，其实是double类型，是由c定义的:typedef double NSTimeInterval;
    NSTimeInterval time=[endDate timeIntervalSinceDate:beginDate];
    
    int days=((int)time)/(3600*24);
    //int hours=((int)time)%(3600*24)/3600;
    //NSString *dateContent=[[NSString alloc] initWithFormat:@"%i天%i小时",days,hours];
    return -days;
}

+ (NSString *)getDateFromDays:(NSInteger )days formating:(NSString *)formatString
{
    NSDate *curDate = [NSDate date];

   
    return [self getDateFromdate:curDate Days:days formating:formatString];
}

+ (NSString *)getDateFromdate:(NSDate *)curDate Days:(NSInteger )days formating:(NSString *)formatString
{
    if (formatString.length == 0) {
        formatString = @"yyyy-MM-dd";
    }
    
    NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar] ;
    NSDateComponents *components = [gregorian components:NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit fromDate:curDate];
    [components setDay:([components day]+days)];
    
    NSDate *beginningOfWeek = [gregorian dateFromComponents:components];
    NSDateFormatter *dateday = [YFDateService  dateformatter];
    [dateday setDateFormat:formatString];
    return [dateday stringFromDate:beginningOfWeek];
}

#pragma mark 得到当前日期
+(NSString *)nowDateDay
{
    NSDate *date=[NSDate date];
    
    
    NSDateFormatter *inputFormatter=[[self class]dateformatter];
    
    inputFormatter.dateFormat=@"YYYY-MM-dd";
    
    NSString *dateNow=[inputFormatter stringFromDate:date];
    
//    NSLog(@" 当前日期 %@",dateNow);
    
    return dateNow;
    
}

+(NSDate *)timeStringFromStringOrNumber:(NSString *)timestr formatString:(NSString *)formatString
{
    if ([timestr isKindOfClass:[NSString class]]== NO && [timestr isKindOfClass:[NSNumber class]] ==NO)
    {
        return nil;
    }
    
    double timeIntervalcreat;
    
    if ([timestr isKindOfClass:[NSString class]])
    {
        if ([timestr rangeOfString:@" "].location != NSNotFound)
        {
            return  nil;
        }
        else
        {
            // 使用Long iPod 会出问题
            timeIntervalcreat = [timestr doubleValueYF];
        }
    }
    else
    {
        timeIntervalcreat = [timestr doubleValueYF];
    }
    
    
    timeIntervalcreat = timeIntervalcreat / 1000.0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntervalcreat];
    
    return date;
}


+(NSString *)timeYearMOnthStringFromStringOrNumber:(NSString *)timestr
{
    if ([timestr isKindOfClass:[NSString class]]== NO && [timestr isKindOfClass:[NSNumber class]] ==NO)
    {
        return @"";
    }
    
    double timeIntervalcreat;
    
    if ([timestr isKindOfClass:[NSString class]])
    {
        if ([timestr rangeOfString:@" "].location != NSNotFound)
        {
            return  timestr;
        }
        else
        {
            // 使用Long iPod 会出问题
            timeIntervalcreat = [timestr doubleValueYF];
        }
    }
    else
    {
        timeIntervalcreat = [timestr doubleValueYF];
    }
    timeIntervalcreat = timeIntervalcreat / 1000.0;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntervalcreat];
    NSDateFormatter *formatter = [YFDateService dateformatter];
    
    formatter.dateFormat = @"yyyy年MM月dd日 HH:mm";
    
    NSString *time = [formatter stringFromDate:date];
    
    
    return  time;
}
+(NSString *)timeStringFromStringOrNumber:(NSString *)timestr
{
    if ([timestr isKindOfClass:[NSString class]]== NO && [timestr isKindOfClass:[NSNumber class]] ==NO)
    {
        return @"";
    }
    
    double timeIntervalcreat;
    
    if ([timestr isKindOfClass:[NSString class]])
    {
        if ([timestr rangeOfString:@" "].location != NSNotFound)
        {
            return  timestr;
        }
        else
        {
            // 使用Long iPod 会出问题
            timeIntervalcreat = [timestr doubleValueYF];
        }
    }
    else
    {
        timeIntervalcreat = [timestr doubleValueYF];
    }
    timeIntervalcreat = timeIntervalcreat / 1000.0;
    
    //    NSDateFormatter *dateFormatter = [YFDateService dateformatter];
    //    dateFormatter.dateFormat = @"yyyy年M月d日 HH:mm:ss";
    
    // 现在的时间
    NSTimeInterval  currentTime = [[NSDate date] timeIntervalSince1970];
    // 时间 相差
    NSTimeInterval timeInterval = currentTime - timeIntervalcreat;
    
    if (timeInterval < 60) {
        return @"现在";
        //        return @"1分钟内";
    } else if (timeInterval < 3600) {
        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    }
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntervalcreat];
    
    return [self timeStringFromDaeYF:date];
    
}

+(NSString *)timeStringFromStringOrNumberKnowledge:(NSString *)timestr
{
    
    if ([timestr isKindOfClass:[NSString class]]== NO && [timestr isKindOfClass:[NSNumber class]] ==NO)
    {
        return @"";
    }
    
    double timeIntervalcreat;
    
    if ([timestr isKindOfClass:[NSString class]])
    {
        if ([timestr rangeOfString:@" "].location != NSNotFound)
        {
            return  timestr;
        }
        else
        {
            // 使用Long iPod 会出问题
            timeIntervalcreat = [timestr doubleValueYF];
        }
    }
    else
    {
        timeIntervalcreat = [timestr doubleValueYF];
    }
    timeIntervalcreat = timeIntervalcreat / 1000.0;
    
    
//    NSString *time = [[NSDate dateWithTimeIntervalSince1970:timeIntervalcreat] timeIntervalDescription];
//    return time;
    
    return @"";
    //    NSDateFormatter *dateFormatter = [YFDateService dateformatter];
    //    dateFormatter.dateFormat = @"yyyy年M月d日 HH:mm:ss";
    
    //    // 现在的时间
    //    NSTimeInterval  currentTime = [[NSDate date] timeIntervalSince1970];
    //    // 时间 相差
    //    NSTimeInterval timeInterval = currentTime - timeIntervalcreat;
    //
    //    if (timeInterval < 60) {
    //        return @"现在";
    ////        return @"1分钟内";
    //    } else if (timeInterval < 3600) {
    //        return [NSString stringWithFormat:@"%.f分钟前", timeInterval / 60];
    //    }
    //    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeIntervalcreat];
    //
    //    return [self timeStringFromDaeKnowledgeYF:date time:timeInterval];
}


+(NSString *)timeStringFromInterval:(NSTimeInterval)timeInterval
{
    timeInterval = timeInterval;
    
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:timeInterval];
    
    return [self timeStringFromDae:date];
    
    
//    // 1.获得年月日
//    NSCalendar *calendar = [NSCalendar currentCalendar];
//    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
//    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
//    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
//    
//    // 2.格式化日期
//    NSDateFormatter *formatter = [self dateformatter];
//    if ([cmp1 day] == [cmp2 day]) { // 今天
//        formatter.dateFormat = @"今天 HH:mm";
//    } else if ([cmp1 year] == [cmp2 year]) { // 今年
//        formatter.dateFormat = @"MM-dd HH:mm";
//    } else {
//        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
//    }
//    NSString *time = [formatter stringFromDate:date];
//    
//    return time;
}
+(NSString *)timeStringFromDae:(NSDate *)date
{
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    //    DebugLog(@"***************KKKKKKKKKK:%ld---%ld",[cmp1 day],[cmp2 day]);
    
    // 2.格式化日期
    NSDateFormatter *formatter = [YFDateService dateformatter];
    if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    }else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] -  [cmp2 day] == -1) // 昨天
    {
        formatter.dateFormat = @"昨天 HH:mm";
    }
    else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:date];
    
    return time;
}
+(NSString *)timeStringFromDaeKnowledgeYF:(NSDate *)date time:(NSTimeInterval )timeIntervalcreat
{
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    //    DebugLog(@"***************KKKKKKKKKK:%ld---%ld",[cmp1 day],[cmp2 day]);
    
    // 2.格式化日期
    NSDateFormatter *formatter = [YFDateService dateformatter];
    if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
        return [NSString stringWithFormat:@"%ld小时前", (long)(((NSInteger)timeIntervalcreat) / 3600)];
        
    }else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp2 day] -  [cmp1 day] > 0) // 昨天
    {
        formatter.dateFormat = @"昨天 HH:mm";
        
        return [NSString stringWithFormat:@"%ld天前",(long) ([cmp2 day] -  [cmp1 day])];
        
    }
    else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:date];
    
    return time;
}
+(NSString *)timeStringFromDaeYF:(NSDate *)date
{
    // 1.获得年月日
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSUInteger unitFlags = NSYearCalendarUnit| NSMonthCalendarUnit | NSDayCalendarUnit |NSHourCalendarUnit |NSMinuteCalendarUnit;
    NSDateComponents *cmp1 = [calendar components:unitFlags fromDate:date];
    NSDateComponents *cmp2 = [calendar components:unitFlags fromDate:[NSDate date]];
    
    //    DebugLog(@"***************KKKKKKKKKK:%ld---%ld",[cmp1 day],[cmp2 day]);
    
    // 2.格式化日期
    NSDateFormatter *formatter = [YFDateService dateformatter];
    if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] == [cmp2 day]) { // 今天
        formatter.dateFormat = @"今天 HH:mm";
    }else if ([cmp1 year] == [cmp2 year] && [cmp1 month] == [cmp2 month] && [cmp1 day] -  [cmp2 day] == -1) // 昨天
    {
        formatter.dateFormat = @"昨天 HH:mm";
    }
    else if ([cmp1 year] == [cmp2 year]) { // 今年
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    } else {
        formatter.dateFormat = @"yyyy-MM-dd HH:mm";
    }
    NSString *time = [formatter stringFromDate:date];
    
    return time;
}


@end
