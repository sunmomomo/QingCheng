//
//  NSObject+RuntimeYF.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (RuntimeYF)

-(id)yf_getValueFromObject:(NSObject *)object key:(const void *)key;

-(void)yf_setRetainValueToObject:(NSObject *)object key:(const void *)key value:(id)value;

-(void)yf_setCopyValueToObject:(NSObject *)object key:(const void *)key value:(id)value;


@end
