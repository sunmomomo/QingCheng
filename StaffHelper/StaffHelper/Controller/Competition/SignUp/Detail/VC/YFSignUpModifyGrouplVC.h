//
//  YFSignUpModifyGrouplVC.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseVC.h"

@interface YFSignUpModifyGrouplVC : YFBaseVC

@property(nonatomic, copy)NSString *groupName;

@property(nonatomic, copy)void(^sureNameBlock)(NSString *);

@end
