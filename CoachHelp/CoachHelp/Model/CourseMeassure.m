//
//  CourseMeassure.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseMeassure.h"

@implementation CourseMeassure

-(NSString *)tagsDescription
{
    
    NSString *str = @"";
    
    for (NSInteger i = 0; i<self.tags.count; i++) {
        
        str = [str stringByAppendingString:self.tags[i]];
        
        if (i<self.tags.count-1) {
            
            str = [str stringByAppendingString:@"，"];
            
        }
        
    }
    
    return str;
    
}

@end
