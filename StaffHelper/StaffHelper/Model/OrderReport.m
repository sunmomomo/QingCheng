//
//  OrderReport.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "OrderReport.h"

@implementation OrderReport

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.course = [[Course alloc]init];
        
        self.coach = [[Coach alloc]init];
        
    }
    
    return self;
    
}

@end
