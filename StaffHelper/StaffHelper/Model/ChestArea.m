//
//  ChestArea.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestArea.h"

@implementation ChestArea

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.chests = [NSMutableArray array];
        
    }
    return self;
}

-(id)copy
{
    
    ChestArea *area = [[ChestArea alloc]init];
    
    area.areaName = self.areaName;
    
    area.areaId = self.areaId;
    
    return area;
    
}

@end
