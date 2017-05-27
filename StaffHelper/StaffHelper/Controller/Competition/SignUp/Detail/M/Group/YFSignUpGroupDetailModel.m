//
//  YFSignUpGroupDetailModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/29.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpGroupDetailModel.h"

#import "YFSignUpGroupMemCModel.h"

#import "YYModel.h"

#import "YFSignUpGroupNameCModel.h"

#import "YFGrayCellModel.h"

#import "YFSignUpGroupMemCModel.h"


#import "YFSignUpGroupDetaiMorelModel.h"

#import "UITableView+YFReloadExtension.h"

#import "YFTBSectionsSignUpGroupModel.h"

#import "YFUserAttendanceModel.h"

#import "UIView+lineViewYF.h"

#import "YFDateService.h"

@interface YFSignUpGroupDetailModel ()<YYModel>

@end

@implementation YFSignUpGroupDetailModel

- (NSInteger)beginDays
{
    if (!self.start)
    {
        return -1;
    }
    return [YFDateService calcDaysCurrentToDateString:self.start];
}



+ (instancetype)creatTestArray
{
    
    NSArray *array = @[@{@"id":@(1),@"username":@"Kent",@"phone":@"12345612345",@"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"},
                       @{@"id":@(1),@"username":@"Kent",@"phone":@"12345612345",@"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"},
                       @{@"id":@(1),@"username":@"Kent",@"phone":@"12345612345",@"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"},
                       @{@"id":@(1),@"username":@"Kent",@"phone":@"12345612345",@"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"},
                       @{@"id":@(1),@"username":@"Kent",@"phone":@"12345612345",@"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"},
                       ];

    NSDictionary *user_attendacedic = @{
                                                @"id":@(2),
                                                @"username":@"KENT",
                                                @"avatar":@"https://ss0.bdstatic.com/5aV1bjqh_Q23odCf/static/superman/img/logo/bd_logo1_31bdc765.png"
                                                
                                        };
    
    
    NSDictionary *alldic = @{@"id":@(1),
                             @"name":@"王学民",
                             @"users":array,
                             @"team_attendance":@{
                                     @"days":@{
                                             @"count":@(56742),
                                             @"rank_country":@(3000),
                                             @"rank_gym":@(2000),
                                             },
                                     @"private_course":@{
                                             @"count":@(556),
                                             @"rank_country":@(2002),
                                             @"rank_gym":@(4),
                                             },
                                     @"group_course":@{
                                             @"count":@(12),
                                             @"rank_country":@(2009),
                                             @"rank_gym":@(12),
                                             },
                                     @"checkin":@{
                                             @"count":@(1),
                                             @"rank_country":@(2030),
                                             @"rank_gym":@(30),
                                             },
                                     },
                             @"users_attendance":@[@{@"user":user_attendacedic,
                                                   @"day_count":@(1),
                                                   @"private_count":@(2),
                                                   @"group_count":@(4),
                                                   @"checkin_count":@(14),
                                                   },
                                                   @{@"user":user_attendacedic,
                                                     @"day_count":@(1333),
                                                     @"private_count":@(332),
                                                     @"group_count":@(4444),
                                                     @"checkin_count":@(1433),
                                                     },
                                                   @{@"user":user_attendacedic,
                                                     @"day_count":@(1),
                                                     @"private_count":@(233),
                                                     @"group_count":@(433),
                                                     @"checkin_count":@(13334),
                                                     },
                                                   @{@"user":user_attendacedic,
                                                     @"day_count":@(1222),
                                                     @"private_count":@(2333),
                                                     @"group_count":@(4333),
                                                     @"checkin_count":@(3314),
                                                     },
                                                   @{@"user":user_attendacedic,
                                                     @"day_count":@(1),
                                                     @"private_count":@(2),
                                                     @"group_count":@(4),
                                                     @"checkin_count":@(14),
                                                     },
                                                   @{@"user":user_attendacedic,
                                                     @"day_count":@(1),
                                                     @"private_count":@(2),
                                                     @"group_count":@(4),
                                                     @"checkin_count":@(14),
                                                     }
                                                   ],
                             };
    NSMutableArray *dataArray = [NSMutableArray array];
    
    YFSignUpGroupDetailModel *detailModel = [YFSignUpGroupDetailModel defaultWithYYModelDic:alldic];

    detailModel.dataArray = dataArray;
    
    
    YFGrayCellModel *grayModel = [YFGrayCellModel defaultWithCellHeght:12.0];
    
    
    YFTBSectionsTitleModel *sectionsModel1 = [[YFTBSectionsTitleModel alloc] init];
    [dataArray addObject:sectionsModel1];
    
    YFTBSectionsSignUpGroupModel *sectionsModel2 = [[YFTBSectionsSignUpGroupModel alloc] init];
    detailModel.sectionTwoModel = sectionsModel2;
    [dataArray addObject:sectionsModel2];
    
    
    YFSignUpGroupNameCModel *grMOdel = [YFSignUpGroupNameCModel defaultWithYYModelDic:nil];
    grMOdel.des = @"组名";
    grMOdel.desValue = @"青橙小分队";
    [sectionsModel1.dataArray addObject:grMOdel];
    
    [sectionsModel1.dataArray addObject:grayModel];
    
    sectionsModel2.dataArray = detailModel.users;
    
    
    if (sectionsModel2.dataArray.count > MaxShowGroupMemCountYF)
    {
        sectionsModel2.isShowAll = NO;
        
        YFTBSectionsTitleModel *sectionsModel3 = [[YFTBSectionsTitleModel alloc] init];
        [dataArray addObject:sectionsModel3];
        
        __weak typeof(sectionsModel2)weakSecModel2 = sectionsModel2;
        
        __weak typeof(sectionsModel3)weakSecModel3 = sectionsModel3;
        
        YFSignUpGroupDetaiMorelModel *moreModel = [YFSignUpGroupDetaiMorelModel defaultWithYYModelDic:nil selectBlock:^(id mo) {
            weakSecModel2.isShowAll = YES;
            
            [weakSecModel2.weakTableView insertRowsAtSectionYF:weakSecModel2.indexPath.section beginRow:MaxShowGroupMemCountYF endRow:weakSecModel2.dataArray.count - 1];
            [weakSecModel3.dataArray removeAllObjects];
            [weakSecModel3.weakTableView reloadSectionYF:weakSecModel3.indexPath.section];
            
        }];
        
        [sectionsModel3.dataArray addObject:moreModel];
    }
    
    // 小组出勤
    YFTBSectionsTitleModel *sectionsModel4 = [[YFTBSectionsTitleModel alloc] init];
    [dataArray addObject:sectionsModel4];

    [sectionsModel4.dataArray addObject:grayModel];
    
    static NSInteger i = 0;
    if (i % 2 == 1)
    {
        [sectionsModel4.dataArray addObject:detailModel.attendanceNotBegin];

        return detailModel;
    }
    i ++;
    [sectionsModel4.dataArray addObject:detailModel.team_attendance];

    
    
    // 小组成员出勤详情
    YFTBSectionsTitleModel *sectionsModel5 = [[YFTBSectionsTitleModel alloc] init];
    
    sectionsModel5.sectionTitle = @"小组成员出勤详情";
    sectionsModel5.font = FontSizeFY(Width(14));
    sectionsModel5.headerHeight = Width(40);
    sectionsModel5.headReaHeight = Width(40);
    sectionsModel5.textColor = YFCellTitleColor;

    sectionsModel5.xxOffset = 15.0;
    
    [sectionsModel5.headerView addLinewViewToTopWithxOffset:15];
    
    sectionsModel5.dataArray = detailModel.users_attendance;
    
    [dataArray addObject:sectionsModel5];

    
    
    return detailModel;
}


- (YFSignUpAttendanceEmptyCModel *)attendanceNotBegin
{
    if (!_attendanceNotBegin)
    {
        _attendanceNotBegin = [YFSignUpAttendanceEmptyCModel defaultWithYYModelDic:nil];
    }
    return _attendanceNotBegin;
}

- (NSMutableArray *)dataArray
{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"su_id":@"id"
             };
}

+ (NSDictionary<NSString *,id> *)modelContainerPropertyGenericClass
{
    return @{
             @"users":YFSignUpGroupMemCModel.class,
             @"users_attendance":YFUserAttendanceModel.class,
             
             };
}

@end
