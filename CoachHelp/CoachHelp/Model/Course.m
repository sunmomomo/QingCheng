//
//  Course.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
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
