//
//  YFRespoStudentFollowDataModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFRespoDataModel.h"

@interface YFRespoStudentFollowDataModel : YFRespoDataModel

/*
 "data":{
 "created_users_count": 12,      # 新注册用户总数
 "following_users_count": 6,     # 跟进中用户总数
 "new_created_users_count": 1,   # 今日新增新注册用户数
 "member_users_count": 21,       # 会员总数
 "new_following_users_count": 2, # 今日新增跟进中用户数
 "all_users_count": 39,          # 总用户数
 "new_member_users_count": 2     # 今日新增会员数
 }
 */
@property(nonatomic,copy)NSString *created_users_count;
@property(nonatomic,copy)NSString *following_users_count;
@property(nonatomic,copy)NSString *ne_created_users_count;
@property(nonatomic,copy)NSString *member_users_count;
@property(nonatomic,copy)NSString *ne_following_users_count;
@property(nonatomic,copy)NSString *all_users_count;
@property(nonatomic,copy)NSString *ne_member_users_count;


@end
