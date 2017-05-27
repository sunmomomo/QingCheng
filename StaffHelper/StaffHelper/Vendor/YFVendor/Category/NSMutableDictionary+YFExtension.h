//
//  NSMutableDictionary+YFExtension.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableDictionary (YFExtension)

- (void)setObje_FY:(NSObject *)obje toKey:(NSString *)key;
-(void)setNotNilObje_FY:(NSObject *)obje toKey:(NSString *)key;
-(void)setStringLengthNotZero_FY:(NSString *)obje toKey:(NSString *)key;

- (void)setString_FY:(NSString *)string toKey:(NSString *)key;
- (void)setArray_FY:(NSArray *)array toKey:(NSString *)key;

- (void)setDictionary_FY:(NSDictionary *)dictionary toKey:(NSString *)key;

- (void)setNumber_FY:(NSNumber *)number toKey:(NSString *)key;
- (void)setInteger_FY:(NSInteger)intNum toKey:(NSString *)key;


-(void)setObject_FY:(NSObject *)obje forKey:(NSString *)key;

@end
