//
//  YFHttpService.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "YFRespoStatusModel.h"
#import "StaffUserInfo.h"

@interface YFHttpService : NSObject

//@property(nonatomic,strong)NSString *str;

@property(nonatomic, strong, nullable)StaffUserInfo *info;

+(void)getUseNameComplete:(void (^_Nullable)())complete;


/**
 * requestSerializerType  0  AFJSONRequestSerializer,1 AFHTTPRequestSerializer
 */
@property(nonatomic,assign)NSUInteger  requestSerializerType;

/**
 * requestSerializerType  0  AFJSONRequestSerializer,1 AFHTTPRequestSerializer
 */
@property(nonatomic,assign)NSUInteger  responseSerializerType;



+ (nullable instancetype)sharedInstance;


+ (nullable instancetype)instance;

/**
 * Get 方法
 */
-(void)GETNoTocken:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters serviceRelyModel:(nullable __weak NSObject *)relyModel responceModelClass:(nullable Class)responceModelClass responseData:(nullable Class)responseDataClass modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView success:(nullable void (^)(YFRespoStatusModel* _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;

-(void)GET:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters serviceRelyModel:(nullable __weak NSObject *)relyModel responceModelClass:(nullable Class)responceModelClass responseData:(nullable Class)responseDataClass modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView success:(nullable void (^)(YFRespoStatusModel* _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;




/**
 * POST方法
 */
-(void)POST:(nullable NSString *)URLString parameters:(nullable id)parameters serviceRelyModel:(nullable __weak NSObject *)relyModel responceModelClass:(nullable Class)responceModelClass responseData:(nullable Class)responseDataClass  modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView   success:(nullable void (^)(YFRespoStatusModel* _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;




/**
 * PUT 方法
 */
//-(void)PUT:(nullable NSString *)URLString parameters:(nullable id)parameters   success:(nullable void (^)(id _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;


-(void)PUT:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters serviceRelyModel:(nullable __weak NSObject *)relyModel responceModelClass:(nullable Class)responceModelClass responseData:(nullable Class)responseDataClass  modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView   success:(nullable void (^)(YFRespoStatusModel* _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;

/**
 * Delete 方法
 */

-(void)DELETE:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters serviceRelyModel:(nullable __weak NSObject *)relyModel responceModelClass:(nullable Class)responceModelClass responseData:(nullable Class)responseDataClass  modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView   success:(nullable void (^)(YFRespoStatusModel* _Nullable))success  failure:(nullable void (^)(NSError * _Nonnull))failure;



/**
 * 上传
 */
-(void)sendImageAndVideosFY:(nonnull NSArray *)imageAndVideoArray completionBlock:(nullable void(^)(BOOL nullable))completionBlock;


// 取消 网络请求
-(void)yf_cancel;

@end
