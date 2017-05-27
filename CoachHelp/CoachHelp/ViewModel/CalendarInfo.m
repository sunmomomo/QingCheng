//
//  CalendarInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CalendarInfo.h"

#define API @"/api/v1/coaches/%ld/schedules/glance/"

@implementation CalendarInfo

-(instancetype)initWithDate:(NSDate *)date
{
    
    if (self = [super init]) {
        
        self.dates = [NSMutableArray array];
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy-MM-dd"];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
        
        NSInteger numberOfDaysInMonth = range.length;
        
        NSString *fromDate = [[[df stringFromDate:date]substringToIndex:8]stringByAppendingString:@"01"];
        
        NSString *toDate = [NSString stringWithFormat:@"%@%ld",[fromDate substringToIndex:8],(long)numberOfDaysInMonth];
        
        NSString *api = [NSString stringWithFormat:API,CoachId];
        
        Parameters *para = [[Parameters alloc]init];
        
        [para setParameter:toDate forKey:@"to_date"];
        
        [para setParameter:fromDate forKey:@"from_date"];
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue]==200) {
                
                NSArray *dates = responseDic[@"data"][@"dates"];
                
                [dates enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    NSDate *date = [df dateFromString:obj];
                    
                    [self.dates addObject:date];
                    
                }];
                
                if (self.request) {
                    self.request(YES);
                }
                
            }else
            {
                
                if (self.request) {
                    self.request(NO);
                }
                
            }
            
        } failure:^(AFHTTPSessionManager *operation, NSString *error) {
            
            if (self.request) {
                self.request(NO);
            }
            
        }];
        
    }
    
    return self;
    
}

-(void)requsetWithDate:(NSDate *)date result:(void(^)(BOOL success,NSString*error))result
{
    
    self.callBack = result;
    
    self.dates = [NSMutableArray array];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    
    NSInteger numberOfDaysInMonth = range.length;
    
    NSString *fromDate = [[[df stringFromDate:date]substringToIndex:8]stringByAppendingString:@"01"];
    
    NSString *toDate = [NSString stringWithFormat:@"%@%ld",[fromDate substringToIndex:8],(long)numberOfDaysInMonth];
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:toDate forKey:@"to_date"];
    
    [para setParameter:fromDate forKey:@"from_date"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]==200) {
            
            NSArray *dates = responseDic[@"data"][@"dates"];
            
            [dates enumerateObjectsUsingBlock:^(NSString *obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                NSDate *date = [df dateFromString:obj];
                
                [self.dates addObject:date];
                
            }];
            
            if (self.callBack) {
                self.callBack(YES,nil);
            }
            
        }else
        {
            
            if (self.callBack) {
                self.callBack(NO,responseDic[@"msg"]);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            self.callBack(NO,error);
        }
        
    }];
    
}

@end
