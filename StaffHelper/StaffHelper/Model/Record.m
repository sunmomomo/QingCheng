//
//  Record.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "Record.h"

@implementation Record

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.course = [[Course alloc]init];
        
    }
    return self;
}

@end
