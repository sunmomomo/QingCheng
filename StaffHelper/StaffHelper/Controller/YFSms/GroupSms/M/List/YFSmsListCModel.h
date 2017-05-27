//
//  YFSmsListCModel.h
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"

@interface YFSmsListCModel : YFBaseCModel

@property(nonatomic, copy)NSString *sms_id;
@property(nonatomic, copy)NSString *title;
@property(nonatomic, copy)NSString *status;
@property(nonatomic, copy)NSString *created_at;
@property(nonatomic, copy)NSString *content;
@property(nonatomic,assign)YFSmsType smsType;
// 有多少非名下会员，短信详情页 需要
@property(nonatomic, copy)NSString *other_users_count;


@property(nonatomic, strong)Student *created_by;
@property(nonatomic, strong)NSMutableArray *users;


@property(nonatomic, copy)NSMutableAttributedString *attriContentString;

@property(nonatomic, copy)NSMutableAttributedString *attriTitleString;

@end
