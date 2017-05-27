//
//  YFStudentFilterRePeoModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStudentFilterRePeoModel : YFBaseCModel

@property(nonatomic,assign)BOOL isAll;

@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *r_id;
@property(nonatomic, copy)NSString *count;
@property(nonatomic, copy)NSString *avatar;

@property(nonatomic,assign)BOOL isSelected;

@end
