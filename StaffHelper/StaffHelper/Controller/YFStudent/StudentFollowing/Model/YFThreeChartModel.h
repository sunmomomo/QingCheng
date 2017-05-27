//
//  YFThreeChartModel.h
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFBaseCModel.h"
#import "YFStaticsModel.h"

#define YFYFThreeChartCellHeight 290

@interface YFThreeChartModel : YFBaseCModel

@property(nonatomic ,strong)YFStaticsModel *neCreateUsersModel;
@property(nonatomic ,strong)YFStaticsModel *neFollowingUsers;
@property(nonatomic ,strong)YFStaticsModel *neMemberUsers;

- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray;
@end
