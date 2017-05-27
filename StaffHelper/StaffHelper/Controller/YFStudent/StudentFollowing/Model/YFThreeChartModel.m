//
//  YFThreeChartModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFThreeChartModel.h"
#import "YFThreeChartCell.h"

static NSString *yFThreeChartCell = @"YFThreeChartCell";

@implementation YFThreeChartModel


- (instancetype)initWithDictionary:(NSDictionary *)jsonDic
{
//    jsonDic = @{
//                @"new_create_users":@{@"count":@(4),@"date_counts":@[@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"}]},
//                @"new_following_users":@{@"count":@(3),@"date_counts":@[@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"}]},
//                @"new_member_users":@{@"count":@(3),@"date_counts":@[@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"},@{@"date":@"2016-12-01",@"count":@"3"},@{@"date":@"2016-12-01",@"count":@"1"},@{@"date":@"2016-12-01",@"count":@"6"}]},
//                };
    
    self = [super initWithDictionary:jsonDic];
    if (self) {
        self.cellIdentifier = yFThreeChartCell;
        self.cellClass = [YFThreeChartCell class];
        self.cellHeight = YFYFThreeChartCellHeight;
        
        
        
    }
    return self;
}

- (void)bindCell:(YFBaseCell *)baseCell indexPath:(NSIndexPath *)indexPath
{
    YFThreeChartCell *cell = (YFThreeChartCell *)baseCell;
    
    cell.charFirstView.staticModel = self.neCreateUsersModel;
    cell.charSecondView.staticModel = self.neFollowingUsers;
    cell.charThreeView.staticModel = self.neMemberUsers;
}


-(void)setValue:(id)value forKey:(NSString *)key
{
    DebugLogYF(@"%@",value);
    if ([key isEqualToString:@"new_create_users"])
    {
        self.neCreateUsersModel = [YFStaticsModel defaultWithDic:value];
        
    }else if ([key isEqualToString:@"new_following_users"])
    {
        self.neFollowingUsers = [YFStaticsModel defaultWithDic:value];
    }else if([key isEqualToString:@"new_member_users"]){
        self.neMemberUsers = [YFStaticsModel defaultWithDic:value];
        
    }else
        [super setValue:value forKey:key];
}

- (void)fullEmptyArrayWithDateArray:(NSArray *)dateArray
{
    [self.neCreateUsersModel fullEmptyArrayWithDateArray:dateArray];
    [self.neFollowingUsers fullEmptyArrayWithDateArray:dateArray];
    [self.neMemberUsers fullEmptyArrayWithDateArray:dateArray];
}



@end
