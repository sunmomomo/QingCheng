//
//  NSString+YFCategory.h
//  GTW
//
//  Created by FYWCQ on 16/7/6.
//  Copyright © 2016年 imeng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (YFCategory)

- (BOOL)containsString_NN:(NSString *)aString;

- (NSString*)telephoneWithReformat;

/**
 * 字典变字符串
 */
+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary;

/**
 * 数组变字符串
 */
+(NSString *)stringFromArray_nn:(NSArray *)array;

/**
 * 字符串 转 Json
 */
-(id )JSON;


-(NSString *)URLEncodedYF;
-(NSString *)URLDecodedYF;
@end
