//
//  CardCost.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardCost.h"

@implementation CardCost

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.fromNumber = [aDecoder decodeIntegerForKey:@"fromNumber"];
        
        self.toNumber = [aDecoder decodeIntegerForKey:@"toNumber"];
        
        self.perCost = [aDecoder decodeIntegerForKey:@"perCost"];
        
        self.costString = [aDecoder decodeObjectForKey:@"costString"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeInteger:self.fromNumber forKey:@"fromNumber"];
    
    [aCoder encodeInteger:self.toNumber forKey:@"toNumber"];
    
    [aCoder encodeInteger:self.perCost forKey:@"perCost"];
    
    [aCoder encodeObject:self.costString forKey:@"costString"];
    
}

-(id)copy
{
    
    CardCost *cost = [[CardCost alloc]init];
    
    cost.fromNumber = self.fromNumber;
    
    cost.toNumber = self.toNumber;
    
    cost.perCost = self.perCost;
    
    cost.costString = self.costString;
    
    return cost;
    
}

@end
