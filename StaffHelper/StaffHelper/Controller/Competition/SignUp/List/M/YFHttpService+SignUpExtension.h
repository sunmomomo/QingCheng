//
//  YFHttpService+SignUpExtension.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFHttpService.h"

#import "YFRespoSignPerArrayYYModel.h"


@interface YFHttpService (SignUpExtension)

+ (void)getSignUpList:(nullable NSString *)URLString parameters:(nullable NSDictionary *)parameters modelClass:(nullable Class)modelClass showLoadingOnView:(nullable __weak UIView*)requestView   success:(nullable void (^)(YFRespoStatusModel* _Nullable,YFRespoSignPerArrayYYModel *_Nullable))success  failure:(nullable void (^)(NSError * _Nullable))failure;


@end
