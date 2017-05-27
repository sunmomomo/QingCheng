//
//  YFListCache.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFListCache.h"
#import "NSObject+YFExtension.h"
#import "YFAppConfig.h"

#define YFListCachefilePath @"com.yfwcq.listDataCache"

@implementation YFListCache

+(void)setObjectOfDic:(NSDictionary *)dic key:(NSString *)key
{
    // 缓存的 文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [path stringByAppendingPathComponent:YFListCachefilePath];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    // 判断 文件夹 是否 存在，不存在则 创建
    if ([fileManager fileExistsAtPath:filePath] == NO)
    {
        [fileManager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
    }
    //缓存文件的路径
    NSString *cacheFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",key]];
    // 直接写入文件
   BOOL isSuccess = [NSKeyedArchiver archiveRootObject:dic toFile:cacheFilePath];
//    BOOL isSuccess =    [dic writeToFile:cacheFilePath atomically:NO];
    if (isSuccess == YES)
    {
        DebugLogYF(@"缓存数据成功 path--:%@",cacheFilePath);
    }
}

+(void)setToDocumentObjectOfDic:(NSDictionary *)dic key:(NSString *)key
{
    if (!dic || dic.count <= 0)
    {
        
    }
    // 缓存的 文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = path;
    
//    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    // 判断 文件夹 是否 存在，不存在则 创建
//    if ([fileManager fileExistsAtPath:filePath] == YES)
//    {
//        [fileManager removeItemAtPath:filePath error:nil];
//    }
    //缓存文件的路径
    NSString *cacheFilePath = [filePath stringByAppendingPathComponent:key];
    // 直接写入文件
    
    //直接写入文件
   BOOL isSuccess = [NSKeyedArchiver archiveRootObject:dic toFile:cacheFilePath];
    
//    BOOL isSuccess =    [dic writeToFile:cacheFilePath atomically:NO];
    if (isSuccess == YES)
    {
        DebugLogYF(@"缓存数据成功 path--:%@",cacheFilePath);
    }
}

+(NSDictionary *)cacheOnDocumentDicForKey:(NSString *)key
{
    // 缓存的 文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = path;
    
    //缓存文件的路径
    NSString *cacheFilePath = [filePath stringByAppendingPathComponent:key];

    //  取得 缓存数据
//    NSDictionary *cacheDic = [NSDictionary dictionaryWithContentsOfFile:cacheFilePath];
    
   NSDictionary *cacheDic =  [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFilePath];
    
    if (cacheDic)
    {
    DebugLogParamYF(@"取得缓存数据成功 path--:%@",cacheFilePath);
    }
    return cacheDic;

}

+(NSDictionary *)cacheDicForKey:(NSString *)key
{
    // 缓存的 文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = [path stringByAppendingPathComponent:YFListCachefilePath];
    
    //缓存文件的路径
    NSString *cacheFilePath = [filePath stringByAppendingPathComponent:[NSString stringWithFormat:@"%@.plist",key]];
    
    //  取得 缓存数据
//    NSDictionary *cacheDic = [NSDictionary dictionaryWithContentsOfFile:cacheFilePath];
    NSDictionary *cacheDic =  [NSKeyedUnarchiver unarchiveObjectWithFile:cacheFilePath];
    if (cacheDic)
    {
        DebugLogYF(@"取得缓存数据成功 path--:%@",cacheFilePath);
    }
    return cacheDic;
}

+(void)clearCacheListData:(void (^)())completion
{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // 清除缓存
        //  移除 缓存数据的 文件夹，创建 一个 新的空得文件夹
        NSFileManager *manager = [NSFileManager defaultManager];
        // 缓存的 文件夹路径
        NSString *path = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) firstObject];
        
        NSString *filePath = [path stringByAppendingPathComponent:YFListCachefilePath];
        // 移除 文件夹
        [manager removeItemAtPath:filePath error:nil];
        //  创建 一个新的 文件夹
        [manager createDirectoryAtPath:filePath withIntermediateDirectories:YES attributes:nil error:nil];
        if (completion)
        {
            //回调 主线程
            dispatch_async(dispatch_get_main_queue(), ^{
                //调用Block
                completion();
            });
        }
    });
}


+(NSMutableArray *)cacheOnDocumentStudentArrayFromDic:(NSDictionary *)dic
{
//    DebugLogYF(@"%@",dic);
//
//    DebugLogYF(@"%@",dic[@"data"]);

    NSMutableArray *array = [dic[@"data"][@"user"] guardArrayYF].mutableCopy;
    
    if (!array) {
        array = [dic[@"data"][@"users"] guardArrayYF].mutableCopy;
    }
    if (!array) {
        array = [NSMutableArray array];
    }
//    DebugLogYF(@"%@",array);
    return array;
}

+ (void)removeCacheOnDocumentStudentArrayFromKey:(NSString *)key
{
    // 缓存的 文件夹路径
    NSString *path = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject];
    
    NSString *filePath = path;
    
    //缓存文件的路径
    NSString *cacheFilePath = [filePath stringByAppendingPathComponent:key];
    

    
    [NSKeyedArchiver archiveRootObject:@{} toFile:cacheFilePath];

//    [[NSFileManager defaultManager] removeItemAtPath:cacheFilePath error:nil];

}

+ (void)setStudentDic:(NSDictionary *)studentDic toDic:(NSDictionary *)dic
{
    NSMutableArray *array;

    if (dic)
    {
        array = dic[@"data"][@"users"];
        
        if (array) {
            array = array.mutableCopy;
        }
        NSMutableDictionary *dicCahe = [NSMutableDictionary dictionaryWithDictionary:dic];
        
        NSMutableDictionary *dataDIc = dicCahe[@"data"];
        
        dataDIc = dataDIc.mutableCopy;
        
        [array addObject:studentDic];
        
        [self setStudentArray:array toDic:dic];
    }
}
+ (void)setStudentArray:(NSArray *)array toDic:(NSDictionary *)dic
{
    NSMutableDictionary *cacheDic = dic.mutableCopy;
    NSDictionary *dataDic = dic[@"data"];
    if (dataDic && [dataDic isKindOfClass:[NSDictionary class]])
    {
        NSMutableDictionary *cacheDataDic = dataDic.mutableCopy;
        
        [cacheDataDic setObject:array forKey:@"users"];
        
        [cacheDic setObject:cacheDataDic forKey:@"data"];
        
        DebugLogYF(@"%@",array);
        [YFListCache setToDocumentObjectOfDic:cacheDic key:YFCacheKey];
    };
   

}




@end
