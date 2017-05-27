//
//  NSMutableDictionary+YFExtension.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "NSMutableDictionary+YFExtension.h"

@implementation NSMutableDictionary (YFExtension)


-(void)setObje_FY:(NSObject *)obje toKey:(NSString *)key
{
    if (obje)
    {
        [self setObject:obje forKey:key];
    }else
    {
        [self setObject:@"" forKey:key];
        DebugLogParamYF(@"key:%@对应的值为空",key);
    }
}

-(void)setObject_FY:(NSObject *)obje forKey:(NSString *)key
{
    if (obje)
    {
        [self setObject:obje forKey:key];
    }
    else
    {
        DebugLogParamYF(@"key:%@对应的值为空",key);
    }
}

-(void)setStringLengthNotZero_FY:(NSString *)obje toKey:(NSString *)key
{
    if (obje.length)
    {
        [self setObject:obje forKey:key];
    }else
    {
        DebugLogParamYF(@"key:%@对应的值为空",key);
    }
}

-(void)setNotNilObje_FY:(NSObject *)obje toKey:(NSString *)key
{
    if (obje)
    {
        [self setObject:obje forKey:key];
    }else
    {
        DebugLogParamYF(@"key:%@对应的值为空",key);
    }
}

-(void)setString_FY:(NSString *)string toKey:(NSString *)key
{
    if (string && string.length > 0)
    {
        [self setObject:string forKey:key];
    }else
    {
        [self setObject:@"" forKey:key];
    }
}
-(void)setInteger_FY:(NSInteger)intNum toKey:(NSString *)key
{
    NSString *string = [NSString stringWithFormat:@"%ld",(long)intNum];
    
    [self setString_FY:string toKey:key];
}




-(void)setNumber_FY:(NSNumber *)number toKey:(NSString *)key
{
    if (number)
    {
        [self setObject:number forKey:key];
    }else
    {
        DebugLogParamYF(@"key:%@对应的值为空",key);

        [self setObject:@(0) forKey:key];
    }
}

-(void)setArray_FY:(NSArray *)array toKey:(NSString *)key
{
    if (array)
    {
        [self setObject:array forKey:key];
    }else
    {
        DebugLogParamYF(@"key:%@对应的数组为空",key);

        [self setObject:@[] forKey:key];
    }
}

-(void)setDictionary_FY:(NSDictionary *)dictionary toKey:(NSString *)key
{
    if (dictionary)
    {
        [self setObject:dictionary forKey:key];
    }else
    {
        DebugLogParamYF(@"key:%@对应的字典为空",key);

        [self setObject:@{} forKey:key];
    }
}


@end
