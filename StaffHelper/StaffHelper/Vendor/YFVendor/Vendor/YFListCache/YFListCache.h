//
//  YFListCache.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#define YFCacheKey @"StudentListyf.txt"


@interface YFListCache : NSObject

/*
 1.   存    数据
 2.   取    数据
 3. 清除  数据
 
 */

/**
 * 存数据
 dic    字典数据
 key   文件名字
 */
+(void)setObjectOfDic:(NSDictionary *)dic key:(NSString *)key;

+(void)setToDocumentObjectOfDic:(NSDictionary *)dic key:(NSString *)key;


/**
 *  取 数据
 key  文件 名字
 */
+(NSDictionary *)cacheDicForKey:(NSString *)key;

+(NSDictionary *)cacheOnDocumentDicForKey:(NSString *)key;

+ (void)setStudentDic:(NSDictionary *)studentDic toDic:(NSDictionary *)dic;


/**
 *  清除 数据,清除 成功 回调 block :completion
 */
+(void)clearCacheListData:(void(^)())completion;

+(NSMutableArray *)cacheOnDocumentStudentArrayFromDic:(NSDictionary *)dic;

+ (void)setStudentArray:(NSArray *)array toDic:(NSDictionary *)dic;

+ (void)removeCacheOnDocumentStudentArrayFromKey:(NSString *)key;


@end
