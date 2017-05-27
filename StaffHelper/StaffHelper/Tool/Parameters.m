//
//  Parameters.m
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/7/24.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "Parameters.h"

@implementation Parameters

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.data = [NSMutableDictionary dictionary];
        
    }
    
    return self;
    
}

-(void)setParameter:(id)parameter forKey:(NSString *)key
{
    
    if (!key.length) {
        
        return;
        
    }
    
    if (!parameter) {
        
        parameter = @"";
        
    }
    
    [self.data setObject:parameter forKey:key];
    
}

-(void)setInteger:(NSInteger)integer forKey:(NSString *)key
{
    
    [self.data setObject:[NSNumber numberWithInteger:integer] forKey:key];
    
}

-(void)removeParameterWithKey:(NSString *)key
{
    
    if ([self.data objectForKey:key]) {
        
        [self.data removeObjectForKey:key];
        
    }
    
}


@end
