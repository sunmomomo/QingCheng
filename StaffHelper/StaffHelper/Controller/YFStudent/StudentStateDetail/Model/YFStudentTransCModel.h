//
//  YFStudentTransCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 2017/5/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFStudentTransCModel : YFBaseCModel

@property(nonatomic, copy)NSString *sta_id;
@property(nonatomic, copy)NSString *avatar;
@property(nonatomic, copy)NSString *first_card_info;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *joined_at;
@property(nonatomic, copy)NSString *origin;
@property(nonatomic, copy)NSString *phone;

@property(nonatomic ,strong)NSDictionary *recommend_by;
@property(nonatomic, copy)NSString *recommend_byString;
@property(nonatomic ,strong)NSArray *sellers;
// 销售 名字
@property(nonatomic, copy)NSString *sellersString;

@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *track_record;
@property(nonatomic, copy)NSString *username;


@property(nonatomic, copy)NSString *join_atNoMInu;


@end
