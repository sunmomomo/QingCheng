//
//  Yard.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Yard.h"

@implementation Yard

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.capacity = [aDecoder decodeIntegerForKey:@"capacity"];
        
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        
        self.choosed = [aDecoder decodeBoolForKey:@"choosed"];
        
        self.name = [aDecoder decodeObjectForKey:@"name"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.capacity forKey:@"capacity"];
    
    [aCoder encodeInteger:self.type forKey:@"type"];
    
    [aCoder encodeBool:self.choosed forKey:@"choosed"];
    
    [aCoder encodeObject:self.name forKey:@"name"];
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
}

@end
