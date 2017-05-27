//
//  Gym.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Gym.h"

@implementation Gym

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.color = UIColorFromRGB(0xFF7043);
        
        self.brand = [[Brand alloc]init];
        
        self.rate = [[CourseRate alloc]init];
        
        self.permissions = [[Permissions alloc]init];
        
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    
    self = [super init];
    
    if (self) {
        
        _type = [coder decodeObjectForKey:@"type"];
        
        _gymId = [coder decodeIntegerForKey:@"id"];
        
        _name = [coder decodeObjectForKey:@"name"];
        
        _address = [coder decodeObjectForKey:@"address"];
        
        _city = [coder decodeObjectForKey:@"city"];
        
        _districtCode = [coder decodeObjectForKey:@"districtCode"];
        
    }
    
    return self;
    
}

- (void)encodeWithCoder:(NSCoder *)coder
{
   
    [coder encodeObject:_type forKey:@"type"];
    
    [coder encodeInteger:_gymId forKey:@"id"];
    
    [coder encodeObject:_name forKey:@"name"];
    
    [coder encodeObject:_address forKey:@"address"];
    
    [coder encodeObject:_city forKey:@"city"];
    
    [coder encodeObject:_districtCode forKey:@"districtCode"];
    
}

-(id)copy
{
    
    Gym *gym = [[Gym alloc]init];
    
    gym.brand = self.brand;
    
    gym.name = self.name;
    
    gym.gymId = self.gymId;
    
    gym.shopId = self.shopId;
    
    gym.type = self.type;
    
    gym.city = self.city;
    
    gym.address = self.address;
    
    gym.summary = self.summary;
    
    gym.districtCode = self.districtCode;
    
    gym.imgUrl = [self.imgUrl copy];
    
    return gym;
    
}

@end
