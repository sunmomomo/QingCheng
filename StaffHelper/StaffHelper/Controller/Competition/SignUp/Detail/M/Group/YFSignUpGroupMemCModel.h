//
//  YFSignUpGroupMemCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFSignUpGroupMemCModel : YFBaseCModel

@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSURL *avatar;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSNumber *p_id;
@property(nonatomic, copy)NSString *phone;


- (NSDictionary *)toJsonDic;
@end
