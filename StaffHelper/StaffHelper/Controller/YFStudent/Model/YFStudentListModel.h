//
//  YFStudentListModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStudentListModel : YFBaseCModel
@property(nonatomic, copy)NSString *username;

@property(nonatomic, copy)NSString *area_code;
@property(nonatomic, copy)NSString *avatar;
@property(nonatomic, copy)NSString *checkin_avatar;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *head;
@property(nonatomic, copy)NSString *p_id;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSString *status;
//#warning joined_at
@property(nonatomic, copy)NSString *join_at;
@property(nonatomic, copy)NSString *joined_at;



@property(nonatomic, copy)NSArray *shops;


@end
