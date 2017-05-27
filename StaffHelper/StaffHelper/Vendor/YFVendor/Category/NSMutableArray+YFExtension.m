//
//  NSMutableArray+YFExtension.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "NSMutableArray+YFExtension.h"

@implementation NSMutableArray (YFExtension)

-(void)addObjectYF:(NSObject *)object
{
    if (object)
    {
        [self addObject:object];
    }else
    {
        DebugLogParamYF(@"空数据 添加 到数组");
    }
}

@end
