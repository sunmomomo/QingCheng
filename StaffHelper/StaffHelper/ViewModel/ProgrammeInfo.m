

//
//  ProgrammeInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/staffs/%ld/schedules/"

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

-(void)requestDataWithGym:(Gym *)gym
{
    
    if (!StaffId) {
        
        if (self.request) {
            self.request(NO);
        }
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *dateStr = [df stringFromDate:_date];
    
    self.startDate = [df dateFromString:dateStr];
    
    self.endDate = [NSDate dateWithTimeInterval:86400 sinceDate:self.startDate];
    
    self.programmes = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:dateStr forKey:@"date"];
    
    NSString *api = [NSString stringWithFormat:API,StaffId];
    
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
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithDict:responseDic[@"data"]];
            
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

-(void)requestEventInfo
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSString *fromStr = [df stringFromDate:[NSDate date]];
    
    NSString *toStr = [df stringFromDate:[NSDate dateWithTimeInterval:24*3600*kDuringDate sinceDate:[NSDate date]]];
    
    self.startDate = [df dateFromString:fromStr];
    
    self.endDate = [df dateFromString:[df stringFromDate:[NSDate dateWithTimeInterval:24*3600*(kDuringDate+1) sinceDate:[NSDate date]]]];
    
    self.programmes = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:fromStr forKey:@"from_date"];
    
    [para setParameter:toStr forKey:@"to_date"];
    
    NSString *api = [NSString stringWithFormat:API,StaffId];
    
    [MOAFHelp AFGetHost:ROOT bindPath:api param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createDataWithDict:responseDic[@"data"]];
            
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

-(void)createDataWithDict:(NSDictionary*)dict
{
    
    NSArray *restArray = dict[@"rests"];
    
    for (NSDictionary * restDict in restArray){
        
        Programme *programme = [[Programme alloc]init];
        
        programme.style = ProgrammeStyleRest;
        
        programme.startTime = [restDict[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        programme.endTime = [restDict[@"end"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        programme.url = [NSURL URLWithString:restDict[@"url"]];
        
        programme.title = [NSString stringWithFormat:@"%@-%@ 休息",[programme.startTime substringWithRange:NSMakeRange(11, 5)],[programme.endTime substringWithRange:NSMakeRange(11, 5)]];
        
        programme.programmeId = [restDict[@"id"]integerValue];
        
        programme.gym.name = restDict[@"shop"][@"name"];
        
        programme.gym.gymId = [restDict[@"id"]integerValue];
        
        programme.gym.shopId = programme.gym.gymId;
        
        programme.coach.name = restDict[@"teacher"][@"username"];
        
        [self.programmes addObject:programme];
        
    }
    
    NSArray *schedulesArray = dict[@"schedules"];
    
    for (NSDictionary *schDict in schedulesArray) {
        
        Programme *programme = [[Programme alloc]init];
        
        programme.total = [schDict[@"count"] integerValue];
        
        programme.startTime = [schDict[@"start"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        programme.endTime = [schDict[@"end"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
        
        programme.programmeId = [schDict[@"id"]integerValue];
        
        programme.url = [NSURL URLWithString:schDict[@"url"]];
        
        programme.orders = schDict[@"orders"];
        
        programme.title = schDict[@"course"][@"name"];
        
        programme.imgUrl = [NSURL URLWithString:schDict[@"course"][@"photo"]];
        
        programme.gym.name = schDict[@"shop"][@"name"];
        
        programme.gym.shopId = [schDict[@"shop"][@"id"]integerValue];
        
        programme.coach.name = schDict[@"teacher"][@"username"];
        
        [self.programmes addObject:programme];
        
    }
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:@"startTime" ascending:YES];
    
    self.programmes = [[self.programmes sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]mutableCopy];
    
    if (self.request) {
        self.request(YES);
    }
    
}

-(NSArray *)getShowDataWithGym:(Gym *)gym
{
    
    if (!gym) {
        
        return [self.programmes copy];
        
    }else
    {
        
        NSMutableArray *array = [NSMutableArray array];
        
        [self.programmes enumerateObjectsUsingBlock:^(Programme *obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            if (obj.gym.shopId == gym.shopId) {
                
                [array addObject:obj];
                
            }
            
        }];
        
        return [array copy];
        
    }
    
}

@end
