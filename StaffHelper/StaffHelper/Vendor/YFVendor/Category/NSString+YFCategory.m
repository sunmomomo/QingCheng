//
//  NSString+YFCategory.m
//  GTW
//
//  Created by FYWCQ on 16/7/6.
//  Copyright © 2016年 imeng. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

#import "NSString+YFCategory.h"

@implementation NSString (YFCategory)



- (BOOL)containsString_NN:(NSString *)aString
{
    NSRange range = [self rangeOfString:aString];
    
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}



- (NSString*)telephoneWithReformat
{
    NSString * str = self;
    
    if ([str containsString_NN:@"-"])
    {
        
        str = [str stringByReplacingOccurrencesOfString:@"-" withString:@""];
    }
    
    if ([str containsString_NN:@" "])
    {
        str = [str stringByReplacingOccurrencesOfString:@" " withString:@""];
    }
    
    if ([str containsString_NN:@"("])
    {
        str = [str stringByReplacingOccurrencesOfString:@"(" withString:@""];
    }
    
    if ([str containsString_NN:@")"])
    {
        str = [str stringByReplacingOccurrencesOfString:@")" withString:@""];
    }
    
    if ([str containsString_NN:@"+86"])
    {
        str = [str stringByReplacingOccurrencesOfString:@"+86" withString:@""];
    }
    
    return str;
}



- (BOOL)containsString_NN__NN:(NSString *)aString
{
    NSRange range = [[self lowercaseString] rangeOfString:[aString lowercaseString]]; // 不区分大小写
    
    if (range.location != NSNotFound)
    {
        return YES;
    }
    
    return NO;
}



+(NSString *)stringFromArray_nn:(NSArray *)array
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:array options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

+(NSString *)stringFromdictioanry_nn:(NSDictionary *)dictionary
{
    NSData * data = [NSJSONSerialization dataWithJSONObject:dictionary options:NSJSONWritingPrettyPrinted error:nil];
    
    NSString * string = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
    
    return string;
}

-(id)JSON
{
    if ([self isKindOfClass:[NSString class]] == NO)
    {
        return @{};
    }
    
    NSData *  data = [self dataUsingEncoding:NSUTF8StringEncoding];
    
    id  dic = nil;
    NSError *error = nil;
    
    if (data) {
        if ([data length] > 0) {
            dic = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:&error];
            if (error)
            {
                NSLog(@" 解析json错误 %@",[error description]);
            }
        }
    }
    return dic;
}

-(NSString *)URLDecodedYF
{
    NSString *decodedString=(__bridge_transfer NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (__bridge CFStringRef)self, CFSTR(""), CFStringConvertNSStringEncodingToEncoding(NSUTF8StringEncoding));
    
    return decodedString;
}

-(NSString *)URLEncodedYF
{
    NSString *encodedString = (NSString *)
    CFBridgingRelease(CFURLCreateStringByAddingPercentEscapes(kCFAllocatorDefault,
                                                              (CFStringRef)self,
                                                              NULL,
                                                              (CFStringRef)@"!*'();:@&=+$,/?%#[]",
                                                              kCFStringEncodingUTF8));
    
    return encodedString;
}


@end
