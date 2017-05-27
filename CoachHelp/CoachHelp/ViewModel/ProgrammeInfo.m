

//
//  ProgrammeInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeInfo.h"

#import "EventManager.h"

#import "UIColor+Hex.h"

#define API @"/api/v1/coaches/%ld/schedules/"

#define kDuringDate 6

@interface ProgrammeInfo ()

{
    
    NSDate *_date;
    
}

@end

@implementation ProgrammeInfo

-(instancetype)initWithDate:(NSDate *)date
{
    
    if (self = [super init]) {
        
        if (!date) {
            
            date = [NSDate date];
            
        }
        
        _date = date;
        
    }
    
    return self;
    
}

-(void)requestDataResult:(void(^)(BOOL success,NSString*error))result
{
    
    self.callBack = result;
    
    if (!CoachId) {
        
        if (self.callBack) {
            
            self.callBack(NO,nil);
            
        }
        
        return;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *dateStr = [df stringFromDate:_date];
    
    self.startDate = [df dateFromString:dateStr];
    
    self.endDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.startDate];
    
    self.programmes = [NSMutableArray array];
    
    self.gyms = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:dateStr forKey:@"date"];
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
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

-(void)requestEventInfoResult:(void(^)(BOOL success,NSString*error))result
{
    
    self.callBack = result;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *fromStr = [df stringFromDate:[NSDate date]];
    
    NSString *toStr = [df stringFromDate:[NSDate dateWithTimeInterval:24*3600*kDuringDate sinceDate:[NSDate date]]];
    
    self.startDate = [df dateFromString:fromStr];
    
    self.endDate = [df dateFromString:[df stringFromDate:[NSDate dateWithTimeInterval:24*3600*(kDuringDate+1) sinceDate:[NSDate date]]]];
    
    self.programmes = [NSMutableArray array];
    
    self.gyms = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:fromStr forKey:@"from_date"];
    
    [para setParameter:toStr forKey:@"to_date"];
    
    NSString *api = [NSString stringWithFormat:API,CoachId];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
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

-(void)createDataWithArray:(NSArray *)array
{
    
    self.havePrivate = NO;
    
    for (NSDictionary *obj in array){
        
        NSArray *restArray = obj[@"rests"];
        
        NSDictionary *systemDict = obj[@"service"];
        
        Gym *gym = [[Gym alloc]init];
        
        gym.name = systemDict[@"name"];
        
        gym.type = systemDict[@"model"];
        
        gym.gymId = [systemDict[@"id"]integerValue];
        
        gym.havePrivate = [obj[@"private_schedules_exists"] boolValue];
        
        if (gym.havePrivate) {
            
            self.havePrivate = YES;
            
        }
        
        [self.gyms addObject:gym];
        
        for (NSDictionary * restDict in restArray){
            
            Programme *programme = [[Programme alloc]init];
            
            programme.style = ProgrammeStyleRest;
            
            programme.startTime = [restDict[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
            programme.endTime = [restDict[@"end"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
            programme.url = [NSURL URLWithString:restDict[@"url"]];
            
            programme.title = [NSString stringWithFormat:@"%@-%@ 休息",[programme.startTime substringWithRange:NSMakeRange(11, 5)],[programme.endTime substringWithRange:NSMakeRange(11, 5)]];
            
            programme.gym = gym;
            
            programme.shopName = restDict[@"shop"][@"name"];
            
            programme.programmeId = [restDict[@"id"]integerValue];
            
            [self.programmes addObject:programme];
            
        }
        
        NSArray *schedulesArray = obj[@"schedules"];
        
        for (NSDictionary *schDict in schedulesArray) {
            
            Programme *programme = [[Programme alloc]init];
            
            programme.total = [schDict[@"count"] integerValue];
            
            programme.startTime = [schDict[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
            programme.endTime = [schDict[@"end"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            
            programme.programmeId = [schDict[@"id"]integerValue];
            
            programme.url = [NSURL URLWithString:schDict[@"url"]];
            
            programme.gym = gym;
            
            programme.shopName = schDict[@"shop"][@"name"];
            
            programme.orders = schDict[@"orders"];
            
            programme.title = schDict[@"course"][@"name"];
            
            programme.imgUrl = [NSURL URLWithString:schDict[@"course"][@"photo"]];
            
            programme.clash = [[EventManager sharedManager]checkEventWithStart:programme.startTime andEnd:programme.endTime];
            
            programme.courseType = ![schDict[@"course"][@"is_private"]boolValue];
            
            [self.programmes addObject:programme];
            
        }
        
    }
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES];
    
    self.programmes = [[self.programmes sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]mutableCopy];
    
}

-(void)requestWeekDataWithDate:(NSDate *)date result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.programmes = [NSMutableArray array];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    NSDate *startDate = [NSDate dateWithTimeInterval:(theComponents.weekday-1)*-86400 sinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:date]]];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[dateFormatter stringFromDate:startDate] forKey:@"from_date"];
    
    [para setParameter:[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:86400*6 sinceDate:startDate]] forKey:@"to_date"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic)  {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
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

-(NSArray *)getShowDataWithGym:(Gym *)gym
{
    
    if (!gym) {
        
        return [self.programmes copy];
        
    }else
    {
        
        NSMutableArray *array = [NSMutableArray array];
        
        [self.programmes enumerateObjectsUsingBlock:^(Programme *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.gym.gymId == gym.gymId && [obj.gym.type isEqualToString:gym.type]) {
                
                [array addObject:obj];
                
            }
            
        }];
        
        return [array copy];
        
    }
    
}

-(id)copy
{
    
    ProgrammeInfo *info = [[ProgrammeInfo alloc]init];
    
    info.startDate = self.startDate;
    
    info.endDate = self.endDate;
    
    info.programmes = self.programmes;
    
    info.gyms = self.gyms;
    
    info.havePrivate = self.havePrivate;
    
    return info;
    
}

-(BOOL)havePrivateWithGym:(Gym *)gym
{
    
    if (!gym) {
        
        return self.havePrivate;
        
    }else{
        
        BOOL havePrivate = NO;
        
        for (Gym *tempGym in self.gyms) {
            
            if ([gym.type isEqualToString:tempGym.type] && gym.gymId == tempGym.gymId) {
                
                havePrivate = tempGym.havePrivate;
                
            }
            
        }
        
        return havePrivate;
        
    }
    
}

@end
