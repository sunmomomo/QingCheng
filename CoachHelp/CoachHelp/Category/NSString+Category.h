//
//  NSString+Category.h
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/5/23.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Strlenth)

/**
 *获取字符串的字节数
 @return 返回字节数
 */
-(NSUInteger) unicodeLength;

/**
 *截取字符串到第几个字节
 *@param length 需要截取到的字节数
 *@return 返回截取后的字符串
 */
-(NSString *)substringToLength:(NSInteger)length;

+(NSString *)stringWithInteger:(NSInteger)value;

+(NSString *)integerFormatString:(NSString *)string;

+(NSString *)formatStringWithFloat:(float)floatValue;

+ (NSString *)uuid;

@end
