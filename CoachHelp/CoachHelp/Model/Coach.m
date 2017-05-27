//
//  Coach.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Coach.h"

@implementation Coach

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.gym = [[Gym alloc]init];
        
        self.rate = [[CourseRate alloc]init];
        
    }
    return self;
}

-(id)copy
{
    
    Coach *coach = [[Coach alloc]init];
    
    coach.name = self.name;
    
    coach.sex = self.sex;
    
    coach.phone = self.phone;
    
    coach.coachId = self.coachId;
    
    coach.iconUrl = self.iconUrl;
    
    coach.choosed = self.choosed;
    
    coach.country = self.country;
    
    return coach;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.sex = [aDecoder decodeIntegerForKey:@"sex"];
        
        self.choosed = [aDecoder decodeBoolForKey:@"choosed"];
        
        self.iconUrl = [aDecoder decodeObjectOfClass:[NSURL class] forKey:@"iconUrl"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
        self.phone = [aDecoder decodeObjectForKey:@"phone"];
        
        self.country = [aDecoder decodeObjectOfClass:[CountryPhone class] forKey:@"country"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
    [aCoder encodeObject:self.phone forKey:@"phone"];
    
    [aCoder encodeObject:self.iconUrl forKey:@"iconUrl"];
    
    [aCoder encodeInteger:self.sex forKey:@"sex"];
    
    [aCoder encodeBool:self.choosed forKey:@"choosed"];
    
    [aCoder encodeObject:self.country forKey:@"country"];
    
}

@end
