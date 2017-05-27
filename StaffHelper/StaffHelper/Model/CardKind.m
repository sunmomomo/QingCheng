//
//  CardKind.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardKind.h"

@implementation CardKind


- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.gyms = [NSMutableArray array];
        
        self.costs = [NSMutableArray array];
        
        self.specs = [NSMutableArray array];
        
    }
    return self;
}

-(id)copy
{
    
    CardKind *tempCardKind = [[CardKind alloc]init];
    
    tempCardKind.preTimes = self.preTimes;
    
    tempCardKind.dayTimes = self.dayTimes;
    
    tempCardKind.weekTimes = self.weekTimes;
    
    tempCardKind.monthTimes = self.monthTimes;
    
    tempCardKind.maxCardCount = self.maxCardCount;
    
    tempCardKind.color = self.color;
    
    tempCardKind.isLimit = self.isLimit;
    
    tempCardKind.cardKindName = self.cardKindName;
    
    tempCardKind.cardKindId = self.cardKindId;
    
    tempCardKind.typeName = self.typeName;
    
    tempCardKind.summary = self.summary;
    
    tempCardKind.astrict = self.astrict;
    
    tempCardKind.isUsed = self.isUsed;
    
    tempCardKind.gyms = [self.gyms copy];
    
    tempCardKind.type = self.type;
    
    NSMutableArray *costs = [NSMutableArray array];
    
    for (CardCost *cost in self.costs) {
        
        CardCost *tempCost = [cost copy];
        
        [costs addObject:tempCost];
        
    }
    
    tempCardKind.costs = costs;
    
    tempCardKind.costString = self.costString;
    
    tempCardKind.cost = self.cost;
    
    tempCardKind.specs = self.specs;
    
    tempCardKind.state = self.state;
    
    tempCardKind.canCancel = self.canCancel;
    
    tempCardKind.isEnabled = self.isEnabled;
    
    return tempCardKind;
    
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self) {
        
        self.cardKindName = [aDecoder decodeObjectForKey:@"cardName"];
        
        self.type = [aDecoder decodeIntegerForKey:@"type"];
        
        self.costs = [aDecoder decodeObjectOfClass:[NSMutableArray class] forKey:@"costs"];
        
        self.isUsed = [aDecoder decodeBoolForKey:@"isUsed"];
        
        self.summary = [aDecoder decodeObjectForKey:@"summary"];
        
    }
    return self;
}

-(void)encodeWithCoder:(NSCoder *)aCoder
{
    
    [aCoder encodeObject:self.cardKindName forKey:@"cardName"];
    
    [aCoder encodeInteger:self.type forKey:@"type"];
    
    [aCoder encodeObject:self.costs forKey:@"costs"];
    
    [aCoder encodeBool:self.isUsed forKey:@"isUsed"];
    
    [aCoder encodeObject:self.summary forKey:@"summary"];
    
}


@end
