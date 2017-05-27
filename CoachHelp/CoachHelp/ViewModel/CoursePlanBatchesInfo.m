//
//  CoursePlanBatchesInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanBatchesInfo.h"

#define API @"/api/v1/coaches/%ld/batches/%ld/%@/"

#define DELETEAPI @"/api/v1/coaches/%ld/%@/bulk/delete/"

#define kChangeAPI @"/api/v1/coaches/%ld/%@/%ld/"

@interface CoursePlanBatchesInfo ()

{
    
    Course *_course;
    
    NSMutableArray *_array;
    
    NSMutableArray *_monthArray;
    
}

@end

@implementation CoursePlanBatchesInfo

-(void)requestWithCourse:(Course *)course andBatchId:(NSInteger)batchId
{
    
    _course = course;
    
    self.data = [NSMutableArray array];
    
    _monthArray = [NSMutableArray array];
    
    _array = [NSMutableArray array];
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (course.gym.gymId && course.gym.type.length){
        
        [para setParameter:course.gym.type forKey:@"model"];
        
        [para setInteger:course.gym.gymId forKey:@"id"];
        
    }else if(course.gym.shopId && course.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:course.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:course.gym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [para setParameter:[NSNumber numberWithBool:YES] forKey:@"show_all"];

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId,(long)batchId,course.type == CourseTypeGroup?@"schedules":@"timetables"] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue]== 200) {
            
            [self createDataWithArray:[responseDic[@"data"] valueForKey:course.type == CourseTypeGroup?@"schedules":@"timetables"]];
            
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

-(void)createDataWithArray:(NSArray *)array
{
    
    [array enumerateObjectsUsingBlock:^(NSDictionary *obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        df.dateFormat = @"yyyy-MM-dd";
                
        CoursePlan *plan = [[CoursePlan alloc]init];
        
        plan.planId = [obj[@"id"] integerValue];
        
        plan.date = [[obj[@"start"] componentsSeparatedByString:@"T"]firstObject];
        
        if (plan.date.length>=7) {
            
            plan.month = [plan.date substringToIndex:7];
            
        }
        
        if ([[[obj[@"start"] componentsSeparatedByString:@"T"]lastObject] length]>=5) {
            
            plan.startTime = [[[obj[@"start"] componentsSeparatedByString:@"T"]lastObject] substringToIndex:5];

        }
        
        if ([[[obj[@"end"] componentsSeparatedByString:@"T"]lastObject] length]>=5) {
            
            plan.endTime = [[[obj[@"end"] componentsSeparatedByString:@"T"]lastObject] substringToIndex:5];

        }
        
        plan.week = [self weekdayStringFromDate:[df dateFromString:plan.date]];
        
        [_array addObject:plan];
        
        if (![_monthArray containsObject:plan.month]) {
            
            [_monthArray addObject:plan.month];
            
        }
        
    }];
    
    NSSortDescriptor *descriptor = [NSSortDescriptor sortDescriptorWithKey:nil ascending:YES];
    
    _monthArray = [[_monthArray sortedArrayUsingDescriptors:[NSArray arrayWithObject:descriptor]]mutableCopy];
    
    [self dealArray];
    
    if (self.request) {
        self.request(YES);
    }
    
}

-(void)dealArray
{
    
    for (NSString *month in _monthArray) {
        
        NSMutableArray *array  = [NSMutableArray array];
        
        for (CoursePlan *plan in _array) {
            
            if ([plan.month isEqualToString:month]) {
                
                [array addObject:plan];
                
            }
            
        }
        
        NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:YES];
        
        NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
        
        array = [[array sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
        
        NSDictionary *dict = @{@"title":month,@"data":array};
        
        [self.data addObject:dict];
        
    }
    
}

- (NSString*)weekdayStringFromDate:(NSDate*)inputDate {
    
    NSArray *weekdays = [NSArray arrayWithObjects: [NSNull null], @"周日", @"周一", @"周二", @"周三", @"周四", @"周五", @"周六", nil];
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Shanghai"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSCalendarUnitWeekday;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:inputDate];
    
    return [weekdays objectAtIndex:theComponents.weekday];
    
}

-(void)changeWithPlan:(CoursePlan *)plan andCourse:(Course *)course
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [para setParameter:[NSString stringWithFormat:@"%@T%@",plan.date,plan.startTime] forKey:@"start"];
    
    [para setParameter:[NSString stringWithFormat:@"%@T%@",plan.date,plan.endTime] forKey:@"end"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:kChangeAPI,CoachId,course.type == CourseTypeGroup?@"schedules":@"timetables",(long)plan.planId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            if (self.changeFinish) {
                self.changeFinish(YES);
            }
            
        }else
        {
            
            if (self.changeFinish) {
                self.changeFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.changeFinish) {
            self.changeFinish(NO);
        }
        
    }];
    
}

-(void)deleteWithPara:(Parameters *)para andCourse:(Course *)course
{
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:DELETEAPI,CoachId,course.type == CourseTypeGroup?@"schedules":@"timetables"] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]==200) {
            
            if (self.deleteFinish) {
                self.deleteFinish(YES);
            }
            
        }else
        {
            
            if (self.deleteFinish) {
                self.deleteFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.deleteFinish) {
            self.deleteFinish(NO);
        }
        
        
    }];
    
}


@end
