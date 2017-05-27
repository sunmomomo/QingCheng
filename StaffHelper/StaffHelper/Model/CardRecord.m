//
//  CardRecord.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRecord.h"

@implementation CardRecord

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.course = [[Course alloc]init];
        
    }
    return self;
}

-(NSString *)description
{
    
    return @"";
    
}

@end
