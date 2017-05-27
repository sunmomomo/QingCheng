//
//  NSObject+RuntimeYF.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "NSObject+RuntimeYF.h"
#import <objc/runtime.h>

@implementation NSObject (RuntimeYF)

-(id)yf_getValueFromObject:(NSObject *)object key:(const void *)key
{
    return  objc_getAssociatedObject(object, key);
}

-(void)yf_setRetainValueToObject:(NSObject *)object key:(const void *)key value:(id)value
{
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_RETAIN_NONATOMIC);
}

-(void)yf_setCopyValueToObject:(NSObject *)object key:(const void *)key value:(id)value
{
    objc_setAssociatedObject(object, key, value, OBJC_ASSOCIATION_COPY);
}

@end
