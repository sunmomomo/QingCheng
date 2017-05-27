//
//  Checkout.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Checkout.h"

@implementation Checkout

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.card = [[Card alloc]init];
        
        self.student = [[Student alloc]init];
        
    }
    return self;
}

@end
