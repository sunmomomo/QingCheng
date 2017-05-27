//
//  YFSignUpListBaseCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFSignUpListBaseCModel : YFBaseCModel

@property(nonatomic, copy)NSNumber *su_id;
@property(nonatomic, copy)NSString *gender;
@property(nonatomic, copy)NSString *username;
@property(nonatomic, copy)NSString *phone;
@property(nonatomic, copy)NSURL *avatar;
@property(nonatomic, copy)NSString *created_at;

@property(nonatomic, strong)NSMutableArray *teams;

@property(nonatomic, copy)NSNumber *price;
@property(nonatomic, copy)NSNumber *order_id;

@property(nonatomic, assign)CGFloat nameWidth;


+ (NSMutableArray *)creatTestModelArray;


@end
