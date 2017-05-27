//
//  YFHttpService+SignUpExtension.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFHttpService+SignUpExtension.h"

#import "YFRespoSignPerArrayYYModel.h"


@implementation YFHttpService (SignUpExtension)


+ (void)getSignUpList:(NSString *)URLString parameters:(NSDictionary *)parameters modelClass:(Class)modelClass showLoadingOnView:(UIView *__weak)requestView success:(void (^)(YFRespoStatusModel * _Nullable,YFRespoSignPerArrayYYModel *_Nullable))success failure:(void (^)(NSError * _Nullable))failure
{
    [[YFHttpService instance] GET:URLString parameters:parameters serviceRelyModel:nil responceModelClass:[YFRespoStatusModel class] responseData:[YFRespoSignPerArrayYYModel class] modelClass:modelClass showLoadingOnView:requestView success:^(YFRespoStatusModel * _Nullable baseModel) {
        
        YFRespoStatusModel *reModel =(YFRespoStatusModel *)baseModel;
        if (reModel.isSuccess)
        {
            if (success) {
                success(baseModel,(YFRespoSignPerArrayYYModel *)baseModel.dataModel);
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


@end
