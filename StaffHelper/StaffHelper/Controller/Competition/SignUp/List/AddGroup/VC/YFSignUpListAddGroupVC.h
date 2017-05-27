//
//  YFSignUpListAddGroupVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseRefreshTBExtensionVC.h"

@interface YFSignUpListAddGroupVC : YFBaseRefreshTBExtensionVC

@property(nonatomic ,strong)NSNumber *gym_id;

@property(nonatomic, copy)NSNumber *comeptition_id;

@property(nonatomic, copy)void(^addSuccessBlock)(id);

@end
