//
//  MOTool.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MOTool.h"

@implementation MOTool

+(NSString *)formatTimeStringWithDate:(NSDate *)date
{
    
    NSString *timeStr = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    
    if (timeInterval<60) {
        
        timeStr = @"刚刚";
        
    }else if (timeInterval/60<60){
        
        timeStr = [NSString stringWithFormat:@"%ld分钟前",(long)(timeInterval/60)];
        
    }else{
        
        if ([[[dateFormatter stringFromDate:date] substringToIndex:10]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10]]) {
            
            timeStr = [[dateFormatter stringFromDate:date]substringWithRange:NSMakeRange(11, 5)];
            
        }else if ([[[dateFormatter stringFromDate:date] substringWithRange:NSMakeRange(0, 4)]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 4)]]){
            
            timeStr = [[dateFormatter stringFromDate:date]substringWithRange:NSMakeRange(5, 5)];
            
        }else{
            
            timeStr = [[dateFormatter stringFromDate:date]substringToIndex:10];
            
        }
        
    }
    
    return timeStr;
    
}

+(NSString *)formatAllShowTimeStringWithDate:(NSDate *)date
{
    
    NSString *timeStr = @"";
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm";
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSTimeInterval timeInterval = -[date timeIntervalSinceNow];
    
    if (timeInterval<60) {
        
        timeStr = @"刚刚";
        
    }else if (timeInterval/60<60){
        
        timeStr = [NSString stringWithFormat:@"%ld分钟前",(long)(timeInterval/60)];
        
    }else{
        
        if ([[[dateFormatter stringFromDate:date] substringToIndex:10]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringToIndex:10]]) {
            
            timeStr = [[dateFormatter stringFromDate:date]substringWithRange:NSMakeRange(11, 5)];
            
        }else if ([[[dateFormatter stringFromDate:date] substringWithRange:NSMakeRange(0, 4)]isEqualToString:[[dateFormatter stringFromDate:[NSDate date]] substringWithRange:NSMakeRange(0, 4)]]){
            
            timeStr = [[dateFormatter stringFromDate:date]substringFromIndex:5];
            
        }else{
            
            timeStr = [dateFormatter stringFromDate:date];
            
        }
        
    }
    
    return timeStr;
    
}

@end
