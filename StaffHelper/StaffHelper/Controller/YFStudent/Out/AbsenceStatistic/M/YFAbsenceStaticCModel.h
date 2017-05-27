//
//  YFAbsenceStaticCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/2/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFAbsenceStaticCModel : YFBaseCModel

@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *absence;
@property(nonatomic, copy)NSString *date_and_time;
@property(nonatomic, copy)NSString *ab_id;

@property(nonatomic, copy)NSString *user_id;
@property(nonatomic, copy)NSString *avatar;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *username;

@property(nonatomic, copy)void(^phoneActionBlock)();


@end
