//
//  CoursePlan.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlan.h"

@implementation CoursePlan

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.weeks = [NSMutableArray array];
        
        self.course = [[Course alloc]init];
        
        self.coach = [[Coach alloc]init];
        
        self.yards = [NSMutableArray array];
        
        self.cardKinds = [NSMutableArray array];
        
        self.onlinePays = [NSMutableArray array];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.date forKey:@"date"];
    
    [aCoder encodeObject:self.startTime forKey:@"startTime"];
    
    [aCoder encodeObject:self.endTime forKey:@"endTime"];
    
    [aCoder encodeObject:self.month forKey:@"month"];
    
    [aCoder encodeObject:self.weeks forKey:@"weeks"];
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        self.date = [aDecoder decodeObjectForKey:@"date"];
        
        self.startTime = [aDecoder decodeObjectForKey:@"startTime"];
        
        self.endTime = [aDecoder decodeObjectForKey:@"endTime"];
        
        self.month = [aDecoder decodeObjectForKey:@"month"];
        
        self.weeks = [aDecoder decodeObjectForKey:@"weeks"];
        
    }
    
    return self;
    
}

-(NSArray *)compareWithPlan:(CoursePlan *)plan
{
    
    NSMutableArray *array = [NSMutableArray array];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"HH:mm";
    
    if ([[df dateFromString:plan.startTime] timeIntervalSinceDate:[df dateFromString:self.endTime]]>=0 || [[df dateFromString:plan.endTime] timeIntervalSinceDate:[df dateFromString:self.startTime]]<=0) {
        
        return nil;
        
    }else
    {
        
        for (NSString *weekStr in plan.weeks) {
            
            if ([self.weeks containsObject:weekStr]) {
                
                [array addObject:weekStr];
                
            }
            
        }
        
        return array;
        
    }
    
}

-(id)copy
{
    
    CoursePlan *plan = [[CoursePlan alloc]init];
    
    plan.course = self.course;
    
    plan.coach = self.coach;
    
    plan.yards = [self.yards copy];
    
    NSMutableArray *cardKinds = [NSMutableArray array];
    
    for (CardKind *tempCardKind in self.cardKinds) {
        
        CardKind *copyCardKinds = [tempCardKind copy];
        
        [cardKinds addObject:copyCardKinds];
        
    }
    
    plan.cardKinds = cardKinds;
    
    NSMutableArray *onlinePays = [NSMutableArray array];
    
    for (OnlinePay *onlinePay in self.onlinePays) {
        
        OnlinePay *tempPay = [onlinePay copy];
        
        [onlinePays addObject:tempPay];
        
    }
    
    plan.onlinePays = onlinePays;
    
    plan.plans = [self.plans copy];
    
    plan.planId = self.planId;
    
    plan.date = self.date;
    
    plan.isFree = self.isFree;
    
    plan.hasOrder = self.hasOrder;
    
    plan.week = self.week;
    
    plan.weeks =  [self.week copy];
    
    plan.startTime = self.startTime;
    
    plan.endTime = self.endTime;
    
    plan.month = self.month;
    
    return plan;
    
}

@end
