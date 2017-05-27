//
//  Programme.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Programme.h"

@implementation Programme

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.gym = [[Gym alloc]init];
        
        self.coach = [[Coach alloc]init];
        
    }
    return self;
}

-(NSString *)description
{
    
    NSString *str;
    
    if (self.style != ProgrammeStyleRest) {
        
            str = [NSString stringWithFormat:@"%@（%ld人已预约）",self.title,(long)self.total];
            
            if (self.orders.count == 1) {
                
                str = [NSString stringWithFormat:@"%@（%ld人：%@）",self.title,(long)[self.orders[0][@"count"] integerValue],self.orders[0][@"username"]];
                
            }
        
    }else
    {
        
        str = [NSString stringWithFormat:@"%@-%@休息",self.startTime,self.endTime];
        
    }
    return str;
    
}

-(NSString *)ordersDescription
{
    
    NSString *str = @"";
    
    for (NSDictionary *order in self.orders) {
        
        if ([order[@"count"]integerValue]>1) {
            
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@（%ld人）、",order[@"username"],(long)[order[@"count"]integerValue]]];
            
        }else
        {
            
            str = [str stringByAppendingString:[NSString stringWithFormat:@"%@、",order[@"username"]]];
            
        }
        
    }
    
    if ([str hasSuffix:@"、"]) {
        
        str = [str substringToIndex:str.length-1];
        
    }
    
    return str;
    
}

@end
