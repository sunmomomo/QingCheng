//
//  YFSignUpGroupCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSelectArrowCModel.h"

@interface YFSignUpGroupCModel : YFSelectArrowCModel

@property(nonatomic, copy)NSNumber *gr_Id;
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSNumber *count;

@property(nonatomic, copy)NSString *created_at;

@property(nonatomic, copy)NSString *username;
@end
