//
//  YFHttpService+Extension.m
//  CoachHelp
//
//  Created by FYWCQ on 16/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFHttpService+Extension.h"

#import "YFRespoDataArrayYYModel.h"

#import "YFAppService.h"

#import "UIView+YFLoadingView.h"



@implementation YFHttpService (Extension)


+ (void)getList:(NSString *)URLString parameters:(NSDictionary *)parameters modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable,YFRespoDataArrayYYModel *_Nullable))success failure:(void (^)(NSError * _Nullable))failure
{
    [[YFHttpService instance] GET:URLString parameters:parameters serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayYYModel class] modelClass:modelClass showLoadingOnView:requestView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            if (success) {
                success(baseModel,(YFRespoDataArrayYYModel *)baseModel.dataModel);
            }
        }
        else
        {
            if (failure)
            {
                failure(nil);
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        if (failure) {
            failure(error);
        }
    }];
}



+ (void)postSuccessOrFail:(NSString *)URLString parameters:(NSDictionary *)parameters modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable,YFRespoDataArrayModel *_Nullable))success failure:(void (^)(NSError * _Nullable))failure
{
    [[YFHttpService instance] POST:URLString parameters:parameters serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataArrayModel class] modelClass:nil showLoadingOnView:requestView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            if (success) {
                success(baseModel,(YFRespoDataArrayModel *)baseModel.dataModel);
            }
        }
        else
        {
            if (failure)
            {
                if (!requestView) {// 为了 去掉加载框
                  failure(nil);
                }
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        if (!requestView) {// 为了 去掉加载框
            failure(nil);
        }
        [[[UIApplication sharedApplication] keyWindow] showHint:[YFAppService errorStringFromError:error]];
//        if (failure) {
//            failure(error);
//        }
    }];
}

+ (void)deleteSuccessOrFail:(NSString *)URLString parameters:(NSDictionary *)parameters modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable,YFRespoDataModel *_Nullable))success failure:(void (^)(NSError * _Nullable))failure

{
    [[YFHttpService instance] DELETE:URLString parameters:parameters serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:modelClass showLoadingOnView:requestView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            if (success) {
                success(baseModel,baseModel.dataModel);
            }
        }
        else
        {
            if (failure)
            {
                if (!requestView) {// 为了 去掉加载框
                    failure(nil);
                }
            }
        }
        
        
        
    } failure:^(NSError * _Nonnull error) {
        
        
        
        [[[UIApplication sharedApplication] keyWindow] showHint:[YFAppService errorStringFromError:error]];
        if (!requestView) {// 为了 去掉加载框
            failure(nil);
        }
    }];
}


+ (void)putSuccessOrFail:(NSString *)URLString parameters:(NSDictionary *)parameters modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable,YFRespoDataModel *_Nullable))success failure:(void (^)(NSError * _Nullable))failure

{
//    weakTypesYF
    [[YFHttpService instance] PUT:URLString parameters:parameters serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoDataModel class] modelClass:modelClass showLoadingOnView:requestView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            if (success) {
                success(baseModel,baseModel.dataModel);
            }
        }
        else
        {
            if (failure)
            {
                if (!requestView) {// 为了 去掉加载框
                    failure(nil);
                }
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
        [[[UIApplication sharedApplication] keyWindow] showHint:[YFAppService errorStringFromError:error]];
        
        if (!requestView) {// 为了 去掉加载框
            failure(nil);
        }
        //        [YFAppService showAlertMessage:@"网络不给力" sureTitle:@"重新发送请求" sureBlock:^{
//            [weakS putSuccessOrFail:URLString parameters:parameters modelClass:modelClass showLoadingOnView:requestView success:success failure:failure];
//        }];

    }];
}

@end
