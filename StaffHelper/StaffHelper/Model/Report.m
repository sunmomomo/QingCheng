//
//  Report.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Report.h"

@implementation Report

-(instancetype)init
{
    
    if (self = [super init]) {
                
        self.appointmentNum = 0;
        
        self.serviceNum = 0;
        
        self.isToday = NO;
        
        self.fromDate = [NSString string];
        
        self.toDate = [NSString string];
        
    }
    
    return self;
    
}

@end
