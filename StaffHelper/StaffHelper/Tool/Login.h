//
//  Login.h
//  健身教练助手
//
//  Created by 馍馍帝😈 on 15/8/14.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Login : NSObject

/**
 * 请求成功 调用block
 */
@property (nonatomic,strong)void (^callBackSuccess) ();

/**
 * 请求失败 调用Block
 */
@property (nonatomic,strong)void (^callBackFailure) ();

+(instancetype)loginWithPhone:(NSString *)phone andCountryNo:(NSString*)countryNo andPassword:(NSString *)password success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString *errorDesc))failure;

+(instancetype)loginWithPhone:(NSString *)phone andCountryNo:(NSString*)countryNo andCode:(NSString *)code success:(void(^)(NSDictionary *responseDic))success failure:(void(^)(NSString *errorDesc))failure;

+(instancetype)registerWithPara:(NSDictionary *)para success:(void(^)(NSDictionary *responseDic))success faliure:(void(^)(NSString *errorDesc))failure;

+(instancetype)updatePush;

@end
