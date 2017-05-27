//
//  Course.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/1/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Course.h"


@implementation Course

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.coursePlans = [NSMutableArray array];
        
        self.coaches = [NSMutableArray array];
        
        self.yards = [NSMutableArray array];
        
        self.cardKinds = [NSMutableArray array];
        
        self.gym = [[Gym alloc]init];
        
        self.gyms = [NSMutableArray array];
        
        self.rate = [[CourseRate alloc]init];
                
    }
    return self;
}

-(instancetype)initNewCourse
{
    
    self = [super init];
    
    if (self) {
        
        self.coursePlans = [NSMutableArray array];
        
        self.coaches = [NSMutableArray array];
        
        self.yards = [NSMutableArray array];
        
        self.cardKinds = [NSMutableArray array];
        
        self.capacity = 1;
        
        self.gym = [[Gym alloc]init];
        
        Yard *yard = [[Yard alloc]init];
        
        yard.name = @"默认场地";
        
        yard.choosed = YES;
        
        yard.type = YardTypeUnlimited;
        
        yard.capacity = 50;
        
        [self.yards addObject:yard];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        self.coursePlanStart = [dateFormatter stringFromDate:[NSDate date]];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[NSDate date]];
        
        NSInteger numberOfDaysInMonth = range.length;
        
        self.coursePlanEnd = [NSString stringWithFormat:@"%@%ld",[self.coursePlanStart substringToIndex:8],(long)numberOfDaysInMonth];
        
    }
    
    return self;
    
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    
    if (self = [super init]) {
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.gym = [aDecoder decodeObjectOfClass:[Gym class] forKey:@"gym"];
        
        self.imgUrl = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"imgUrl"];
        
        self.image = [aDecoder decodeObjectOfClass:[UIImage class] forKey:@"image"];
        
        self.during = [aDecoder decodeIntegerForKey:@"during"];
        
        self.capacity = [aDecoder decodeIntegerForKey:@"capacity"];
        
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        
        self.coursePlans = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"coursePlans"];
        
        self.coursePlanStart = [aDecoder decodeObjectForKey:@"coursePlanStart"];
        
        self.coursePlanEnd = [aDecoder decodeObjectForKey:@"coursePlanEnd"];
        
        self.coaches = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"coaches"];
        
        self.cardKinds = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"cardKinds"];
        
        self.yards = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"yards"];
        
        self.wayOK = [aDecoder decodeBoolForKey:@"wayOK"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.gym forKey:@"gym"];
    
    [aCoder encodeObject:self.imgUrl forKey:@"imgUrl"];
    
    [aCoder encodeObject:self.image forKey:@"image"];
    
    [aCoder encodeInteger:self.during forKey:@"during"];
    
    [aCoder encodeInteger:self.type forKey:@"type"];
    
    [aCoder encodeObject:self.coursePlans forKey:@"coursePlans"];
    
    [aCoder encodeObject:self.coursePlanStart forKey:@"coursePlanStart"];
    
    [aCoder encodeObject:self.coursePlanEnd forKey:@"coursePlanEnd"];
    
    [aCoder encodeObject:self.coaches forKey:@"coaches"];
    
    [aCoder encodeObject:self.cardKinds forKey:@"cardKinds"];
    
    [aCoder encodeObject:self.yards forKey:@"yards"];
    
    [aCoder encodeBool:self.wayOK forKey:@"wayOK"];
    
    [aCoder encodeInteger:self.capacity forKey:@"capacity"];
    
}

@end
