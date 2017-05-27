//
//  YFSignUpViewModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpViewModel.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFCompetionHeader.h"

#import "YFSignUpListCModel.h"

#import "YFHttpService+SignUpExtension.h"

#import "YFTBSectionsModel.h"

#import "YFSignUpListAddGroupCModel.h"

#import "YFGrayCellModel.h"

#import "YFHttpService+Extension.h"

#import "YFSignUpGroupDetailModel.h"

#import "YFSignUpGroupNameCModel.h"

#import "YFSignUpGroupDetaiMorelModel.h"

#import "UITableView+YFReloadExtension.h"

#import "UIView+lineViewYF.h"

#import "NSMutableArray+YFExtension.h"

#import "YFAppService.h"

#import "YFSignUpListAddPerCModel.h"

@implementation YFSignUpViewModel

- (void)getResponseDatashowLoadingOn:(UIView *)superView listModelClass:(Class)modelClass successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;
{
    
    Parameters *para = [self parameteYF];
    
    if (modelClass == [YFSignUpListAddPerCModel class])
    {
        [para setParameter:@"1" forKey:@"show_all"];

    }else
    {
        [para setInteger:self.page forKey:@"page"];

    }
    
    [para.data setStringLengthNotZero_FY:self.searchStr toKey:@"q"];
    
    [para.data setNotNilObje_FY:self.competition_id toKey:@"competition_id"];

    [para setParameter:self.gym_id  forKey:@"gym_id"];

    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,kCompetitionsMembersOrderesYF];
    
    weakTypesYF
    [YFHttpService getSignUpList:urlString parameters:para.data modelClass:modelClass showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoSignPerArrayYYModel * _Nullable arrayModel) {
        
        weakS.arrayModel = arrayModel;
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}

- (void)getResponseDetailDatashowLoadingOn:(UIView *)superView order_id:(NSNumber *)orderId successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self parameteYF];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@%@",ROOT,kCompetitionsMembersOrderesYF,orderId];
    
    weakTypesYF
    [YFHttpService getList:urlString parameters:para.data modelClass:[YFSignUpDetailCModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {
        
        arrayModel.exDicKey = @"user";
        
        weakS.detailModel = (YFSignUpDetailCModel *)arrayModel.exDicModel;
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}



- (void)getResponseGroupListDatashowLoadingOn:(UIView *)superView listModelClass:(Class)modelClass successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock;
{
    Parameters *para = [self parameteYF];
    
    [para.data setStringLengthNotZero_FY:@"1" toKey:@"show_all"];
    
    [para.data setStringLengthNotZero_FY:self.searchStr toKey:@"q"];
    
    [para.data setNotNilObje_FY:self.competition_id toKey:@"competition_id"];
    
    [para setParameter:self.gym_id  forKey:@"gym_id"];

    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,kStaffsCompetitionsteamsYF];
    
    weakTypesYF
    [YFHttpService getSignUpList:urlString parameters:para.data modelClass:modelClass showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoSignPerArrayYYModel * _Nullable arrayModel) {
        
        arrayModel.exArrayKey = @"teams";
        NSMutableArray *dataArray = [NSMutableArray array];

        
        YFTBSectionsModel *sectionsModel1 = [[YFTBSectionsModel alloc] init];
        [dataArray addObjectYF:sectionsModel1];
        
        YFTBSectionsModel *sectionsModel2 = [[YFTBSectionsModel alloc] init];
        [dataArray addObjectYF:sectionsModel2];
        
        YFSignUpListAddGroupCModel *addGroupModel = [YFSignUpListAddGroupCModel defaultWithYYModelDic:nil selectBlock:self.addGroupBlock];
        
        [sectionsModel1.dataArray addObjectYF:addGroupModel];
        
        if (arrayModel.listArray.count)
        {
            [sectionsModel1.dataArray addObjectYF:[YFGrayCellModel defaultWithCellHeght:12.0]];
        }
        
        [sectionsModel2.dataArray addObjectsFromArray:arrayModel.listArray];
        
        weakS.groupModelDataArray = sectionsModel2.dataArray;
        
        arrayModel.listArray = dataArray;
        
        weakS.arrayModel = arrayModel;

        
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];
}



- (void)postGroupName:(NSString *)groupName userIds:(NSArray *)idsArray showLoadingOn:(UIView *)superView  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self parameteYF];
    
    [para setParameter:self.gym_id  forKey:@"gym_id"];

    if (idsArray.count)
    {
     [para setParameter:idsArray forKey:@"user_ids"];
    }

    [para setParameter:groupName forKey:@"name"];
    
    [para setParameter:self.competition_id forKey:@"competition_id"];

    

    NSString *urlString =  [NSString stringWithFormat:@"%@%@",ROOT,kStaffsCompetitionsteamsYF];

    weakTypesYF
     [YFHttpService postSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable staModel, YFRespoDataArrayModel * _Nullable dataModel) {
         
         dataModel.exDicKey = @"team";
         
         weakS.addTeamDic = dataModel.exDic;
         
         if (successBlock) {
             successBlock();
         }
     } failure:^(NSError * _Nullable error) {
         if (failBlock) {
             failBlock();
         }
     }];
}

- (void)getResponseGroupDetailDatashowLoadingOn:(UIView *)superView teams_id:(NSNumber *)teams_id successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self parameteYF];

    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@%@",ROOT,kStaffsCompetitionsteamsYF,teams_id];
    
    weakTypesYF
    [YFHttpService getList:urlString parameters:para.data modelClass:[YFSignUpGroupDetailModel class] showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataArrayYYModel * _Nullable arrayModel) {
        
        arrayModel.exDicKey = @"team";
        
        YFSignUpGroupDetailModel *detailModel = (YFSignUpGroupDetailModel *)arrayModel.exDicModel;
        detailModel.team_attendance.titleDesName = @"小组出勤";
        weakS.groupDetailModel = detailModel;

         NSMutableArray *dataArray = [NSMutableArray array];
        
        detailModel.dataArray = dataArray;

        
        
        YFGrayCellModel *grayModel = [YFGrayCellModel defaultWithCellHeght:12.0];
        
        
        YFTBSectionsTitleModel *sectionsModel1 = [[YFTBSectionsTitleModel alloc] init];
        [dataArray addObjectYF:sectionsModel1];
        
        YFTBSectionsSignUpGroupModel *sectionsModel2 = [[YFTBSectionsSignUpGroupModel alloc] init];
        detailModel.sectionTwoModel = sectionsModel2;
        [dataArray addObjectYF:sectionsModel2];
        
        
        YFSignUpGroupNameCModel *grMOdel = [YFSignUpGroupNameCModel defaultWithYYModelDic:nil];
        grMOdel.des = @"组名";
        grMOdel.desValue = detailModel.name;
        [sectionsModel1.dataArray addObjectYF:grMOdel];
        
        [sectionsModel1.dataArray addObjectYF:grayModel];
        
        sectionsModel2.dataArray = detailModel.users;
        sectionsModel2.sectionTitle = [NSString stringWithFormat:@"小组成员(%@)",@(sectionsModel2.dataArray.count)];
        
        if (sectionsModel2.dataArray.count > MaxShowGroupMemCountYF)
        {
            sectionsModel2.isShowAll = NO;
            
            YFTBSectionsTitleModel *sectionsModel3 = [[YFTBSectionsTitleModel alloc] init];
            [dataArray addObjectYF:sectionsModel3];
            
            __weak typeof(sectionsModel2)weakSecModel2 = sectionsModel2;
            
            __weak typeof(sectionsModel3)weakSecModel3 = sectionsModel3;
            
            YFSignUpGroupDetaiMorelModel *moreModel = [YFSignUpGroupDetaiMorelModel defaultWithYYModelDic:nil selectBlock:^(id mo) {
                weakSecModel2.isShowAll = YES;
                
                [weakSecModel2.weakTableView insertRowsAtSectionYF:weakSecModel2.indexPath.section beginRow:MaxShowGroupMemCountYF endRow:weakSecModel2.dataArray.count - 1];
                [weakSecModel3.dataArray removeAllObjects];
                [weakSecModel3.weakTableView reloadSectionYF:weakSecModel3.indexPath.section];
                
            }];
            
            [sectionsModel3.dataArray addObjectYF:moreModel];
        }
        
        // 小组出勤
        YFTBSectionsTitleModel *sectionsModel4 = [[YFTBSectionsTitleModel alloc] init];
        [dataArray addObjectYF:sectionsModel4];
        
        [sectionsModel4.dataArray addObjectYF:grayModel];

        
        /// 出勤详情
        if (detailModel.beginDays <= 0)
        {
            
            detailModel.attendanceNotBegin.days = -detailModel.beginDays;
            [sectionsModel4.dataArray addObjectYF:detailModel.attendanceNotBegin];
            
            detailModel.attendanceNotBegin.titleDesName = @"小组出勤";
            if (successBlock) {
                successBlock();
            }
            return;
        }
    
        [sectionsModel4.dataArray addObjectYF:detailModel.team_attendance];
        
        
        
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
        
        [dataArray addObjectYF:sectionsModel5];
        
        
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        if (failBlock) {
            failBlock();
        }
    }];

}


- (void)putGroupName:(NSString *)groupName userIds:(NSArray *)idsArray teams_id:(NSNumber *)teams_id showLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self parameteYF];
    
    if (idsArray)
    {
        [para setParameter:idsArray forKey:@"user_ids"];
    }
    [para.data setNotNilObje_FY:groupName toKey:@"name"];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@%@",ROOT,kStaffsCompetitionsteamsYF,teams_id];
    
//    weakTypesYF
    [YFHttpService putSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        
        if (failBlock) {
            failBlock();
        }
    }];
}

- (void)deleteGroupShowLoadingOn:(UIView *)superView teams_id:(NSNumber *)teams_id  successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    Parameters *para = [self parameteYF];
    
    NSString *urlString =  [NSString stringWithFormat:@"%@%@%@",ROOT,kStaffsCompetitionsteamsYF,teams_id];
    
    //    weakTypesYF
    [YFHttpService deleteSuccessOrFail:urlString parameters:para.data modelClass:nil showLoadingOnView:superView success:^(YFRespoStatusModel * _Nullable statusModel, YFRespoDataModel * _Nullable dataModel) {
        
        if (successBlock) {
            successBlock();
        }
    } failure:^(NSError * _Nullable error) {
        
        if (failBlock) {
            failBlock();
        }
    }];

}


@end
