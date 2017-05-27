//
//  YFHttpService+Extension.h
//  CoachHelp
//
//  Created by FYWCQ on 16/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFHttpService.h"

#import "YFRespoDataArrayYYModel.h"


@interface YFHttpService (Extension)


+ (void)getList:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView   success:(nullable void (^)(YFRespoStatusModel* _Nullable,YFRespoDataArrayYYModel *_Nullable))success  failure:(nullable void (^)(NSError * _Nullable))failure;


+ (void)postSuccessOrFail:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)modelClass showLoadingOnView:(nullable UIView *__weak)requestView success:(nullable void (^)(YFRespoStatusModel * _Nullable,YFRespoDataArrayModel *_Nullable))success failure:(nullable void (^)(NSError * _Nullable))failure;

+ (void)deleteSuccessOrFail:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)modelClass showLoadingOnView:(nullable UIView *__weak)requestView success:(nullable void (^)(YFRespoStatusModel * _Nullable,YFRespoDataModel *_Nullable))success failure:(nullable void (^)(NSError * _Nullable))failure;

+ (void)putSuccessOrFail:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)modelClass showLoadingOnView:(nullable UIView *__weak)requestView success:(nullable void (^)(YFRespoStatusModel * _Nullable,YFRespoDataModel *_Nullable))success failure:(nullable void (^)(NSError * _Nullable))failure;



@end
