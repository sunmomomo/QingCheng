//
//  MOAFHelp.h
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/5/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "AFNetworking.h"
@interface MOAFHelp : NSObject
//------------------请求--------------------
/**
 * 请求成功 调用block
 */
@property (nonatomic,strong)void (^callBackSuccess) ();

/**
 * 请求失败 调用Block
 */
@property (nonatomic,strong)void (^callBackFailure) ();


@property (nonatomic,weak)AFHTTPSessionManager *operation;


// 可以在（setDefaultParamToDic:）这个类方法里 设置 默认给每个接口添加 固定的参数

/**
 *  get 请求（token）
 
 第一个参数 hostString 是 域名
 第二个参数 bindPath 是 域名后面除了 参数的 接口
 第三个参数 dic 是get 请求的 参数
 
 */
+(MOAFHelp*)AFGetNoTokenHost:(NSString*)hostString  bindPath:(NSString *)bindPath param:(NSDictionary*)dic success:( void (^) ( AFHTTPSessionManager *operation,NSDictionary* responseDic) )success failure:(void (^)( AFHTTPSessionManager *operation, NSString *error))failure;


/**
 *  get 请求
 
 第一个参数 hostString 是 域名
 第二个参数 bindPath 是 域名后面除了 参数的 接口
 第三个参数 dic 是get 请求的 参数
 
 */
+(MOAFHelp*)AFGetHost:(NSString*)hostString  bindPath:(NSString *)bindPath param:(NSDictionary*)dic success:( void (^) ( AFHTTPSessionManager *operation,NSDictionary* responseDic) )success failure:(void (^)( AFHTTPSessionManager *operation, NSString *error))failure;

/**
 * Post 请求
 
 第一个参数 hostString 是 域名
 第二个参数 bindPath 是 域名后面除了 参数的 接口
 第三个参数 postParam 是Post参数
 第三个参数 getParam  是Post请求的get参数 一般为空 nil
 */
+(MOAFHelp *)AFPostHost:(NSString *)hostString bindPath:(NSString *)bindPath postParam:(NSDictionary *)dic success:(void (^)(AFHTTPSessionManager *operation, NSDictionary *responseDic))success failure:(void (^)(AFHTTPSessionManager * operation, NSString *error))failure;


/**
 * Put 请求
 
 第一个参数 hostString 是 域名
 第二个参数 bindPath 是 域名后面除了 参数的 接口
 第三个参数 putParam 是Put参数
 */
+(MOAFHelp *)AFPutHost:(NSString *)hostString bindPath:(NSString *)bindPath putParam:(NSDictionary *)dic  success:(void (^)(AFHTTPSessionManager *operation, NSDictionary *responseDic))success failure:(void (^)(AFHTTPSessionManager *operation, NSString *error))failure;

/**
 * Delete 请求
 
 第一个参数 hostString 是 域名
 第二个参数 bindPath 是 域名后面除了 参数的 接口
 第三个参数 deleteParam 是Delete参数
 */
+(MOAFHelp *)AFDeleteHost:(NSString *)hostString bindPath:(NSString *)bindPath deleteParam:(NSDictionary *)dic  success:(void (^)(AFHTTPSessionManager *operation, NSDictionary *responseDic))success failure:(void (^)(AFHTTPSessionManager *operation, NSString *error))failure;

@end
