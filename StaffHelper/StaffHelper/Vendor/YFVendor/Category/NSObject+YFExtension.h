//
//  NSObject+YFExtension.h
//  GTW
//
//  Created by FYWCQ on 16/8/1.
//  Copyright © 2016年 imeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (YFExtension)

/**
 * 使用Long 在 iPod（非64） 会出问题
 */

- (double)longLongValueYF;
- (BOOL)isEqualToStringYF:(NSString *)string;
- (NSString *)guardStringYF;
- (double)doubleValueYF;

- (BOOL)isStringValueYF;

- (NSInteger)integerValueYF;

-(NSArray *)guardArrayYF;

-(NSDictionary *)guardDictionaryYF;

-(NSNumber *)guardNumberYF;
@end
