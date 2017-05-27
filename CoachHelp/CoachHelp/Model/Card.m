//
//  Card.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "Card.h"

@implementation Card

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.students = [NSMutableArray array];
        
        self.cardKind = [[CardKind alloc]init];
        
    }
    
    return self;
    
}

@end
