//
//  Guide.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Guide.h"

@implementation Guide

- (instancetype)init
{
    
    self = [super init];
    
    if (self) {
        
        self.course = [[Course alloc]init];
        
        self.gym = [[Gym alloc]init];
        
        self.brand = [[Brand alloc]init];
        
    }
    
    return self;
    
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super init];
    
    if (self) {
        
        self.course = [coder decodeObjectForKey:@"course"];
        
        self.gym = [coder decodeObjectForKey:@"gym"];
        
        self.brand = [coder decodeObjectForKey:@"brand"];
        
    }
    
    return self;
    
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.course forKey:@"course"];
    
    [aCoder encodeObject:self.gym forKey:@"gym"];
    
    [aCoder encodeObject:self.brand forKey:@"brand"];
    
}

@end
