//
//  ReportInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ReportInfo.h"

@implementation ReportInfo

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.weekReport = [[Report alloc]init];
        
        self.weekReport.isToday = NO;
        
        self.todayReport = [[Report alloc]init];
        
        self.todayReport.isToday = YES;
        
        self.monthReport = [[Report alloc]init];
        
        self.monthReport.isToday = NO;
        
        self.gym = [[Gym alloc]init];
        
    }
    
    return self;
    
}

@end
