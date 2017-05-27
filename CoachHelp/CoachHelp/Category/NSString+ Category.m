//
//  NSString+Category.m
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/5/23.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import "NSString+Category.h"

@implementation NSString (Strlenth)
-(NSUInteger) unicodeLength{
    NSUInteger asciiLength = 0;
    for (NSUInteger i = 0; i < self.length; i++) {
        unichar uc = [self characterAtIndex: i];
        asciiLength += isascii(uc) ? 1 : 2;
    }
    return asciiLength;
}

-(NSString *)substringToLength:(NSInteger)length
{
    NSString *tempStr;
    for (NSUInteger i = [self length] ; i >0; i--) {
        tempStr = [self substringToIndex:i];
        if ([tempStr unicodeLength]<=length) {
            break;
        }
    }
    return tempStr;
}

+(NSString *)stringWithInteger:(NSInteger)value
{
    
    return [NSString stringWithFormat:@"%ld",(long)value];
    
}

+(NSString *)integerFormatString:(NSString *)string
{
    
    float i = [string floatValue];
    
    if (i>=10000) {
        
        return [NSString stringWithFormat:@"%.1fw",i/10000];
        
    }else{
        
        return string;
        
    }
    
}

+ (NSString *)uuid{
    CFUUIDRef uuid = CFUUIDCreate(kCFAllocatorDefault);
    CFStringRef strUuid = CFUUIDCreateString(kCFAllocatorDefault,uuid);
    NSString * str = [NSString stringWithString:(__bridge NSString *)strUuid];
    CFRelease(strUuid);
    CFRelease(uuid);
    return  str;
    
}

+(NSString *)formatStringWithFloat:(float)floatValue
{
    
    NSString *value = [NSString stringWithFormat:@"%.2f",floatValue];
    
    if ([value hasSuffix:@"00"]) {
        
        value = [[value componentsSeparatedByString:@"."]firstObject];
        
    }else if([value hasSuffix:@"0"]){
        
        value = [value substringToIndex:value.length-1];
        
    }else{
        
        value = value;
        
    }
    
    return value;
    
}

@end
