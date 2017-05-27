//
//  YFCompetionHeader.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/5.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCompetionHeader.h"

@implementation YFCompetionHeader


//报名表 gym_id=&competition_id=，报名详情 后面加 order_id/
NSString * const kCompetitionsMembersOrderesYF = @"/api/staffs/competitions/members/orders/";//

/**
 *
 小组列表 GET gym_id=&competition_id=,
 新建小组 POST：body参数：{"gym_id":1, "competition_id": 1, "name": "青橙小分队"}
 小组详情 GET 后加 team_id/
 
 */
NSString * const kStaffsCompetitionsteamsYF = @"/api/staffs/competitions/teams/";

/**
 * Get 判断 该工作人员 是不是该场馆的 超级管理员
   brand_id=1&shop_id=1   或者传 model id
 */
NSString * const kStaffsCompetitionGymIsSuperusersTeamsYF = @"%@/api/staffs/%@/check/superuser/";



// 改变 分组信息,删除 添加 修改
NSString *const kPostChangeGroupDetailIdtifierYF = @"kPostChangeGroupDetailIdtifierYF";

// 添加或者 删除 小组 成员
NSString *const kPostChangeGroupMemberIdtifierYF = @"kPostChangeGroupMemberIdtifierYF";

// 改变,删除
NSString *const kDeleteCompetitionGroupIdtifierYF = @"kDeleteCompetitionGroupIdtifierYF";




@end

