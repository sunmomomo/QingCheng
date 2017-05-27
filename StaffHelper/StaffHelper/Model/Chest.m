//
//  Chest.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Chest.h"

@implementation Chest

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.area = [[ChestArea alloc]init];
        
    }
    return self;
}

-(id)copy
{
    
    Chest *chest = [[Chest alloc]init];
    
    chest.chestId = self.chestId;
    
    chest.area = self.area;
    
    chest.name = self.name;
    
    return chest;
    
}

@end
