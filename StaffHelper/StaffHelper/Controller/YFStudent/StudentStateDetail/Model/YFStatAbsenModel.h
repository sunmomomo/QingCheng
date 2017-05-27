//
//  YFStatAbsenModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStatAbsenModel : YFBaseCModel

@property(nonatomic, copy)NSString *group;
//@property(nonatomic, copy)NSString *user;
@property(nonatomic, copy)NSString *private_count;
@property(nonatomic, copy)NSString *checkin;
@property(nonatomic, copy)NSString *days;

@end
