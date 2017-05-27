//
//  YFStudentFollowingVC.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFStudentFollowingVC.h"
#import "YFTBSectionsTitleModel.h"
#import "YFStudentFollowingModel.h"
#import "YFTBSectionsDelegate.h"
#import "YFTBSectionsDataSource.h"
#import "YFStudentTodayModel.h"
#import "YFStudentTodayTrendDesModel.h"
#import "YFThreeChartModel.h"
#import "YFStudentTransDesModel.h"
#import "YFTransPersentModel.h"
#import "YFGrayCellModel.h"

#import "YFStudentFolowDataModel.h"
#import "YFHttpService.h"
#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFStuFollowingOpCModel.h"

@interface YFStudentFollowingVC ()

@property(nonatomic, strong)YFStudentFolowDataModel *dataModelYF;

@property(nonatomic,strong)YFTBSectionsTitleModel *secionomodel1;
@property(nonatomic,strong)YFTBSectionsTitleModel *secionomodel2;
@property(nonatomic,strong)YFTBSectionsTitleModel *secionomodel3;

@end

@implementation YFStudentFollowingVC

//@synthesize _dataModel;

-(instancetype)init
{
    self = [super init];
    if (self) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNetDataYF) name:kPostAddNewFollowingIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(reloadNetDataYF) name:kPostAddNewMemberIdtifierYF object:nil];

    }
    return self;
}


- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.canGetMore = NO;
    self.title = @"会员跟进";
    
    NSMutableArray *allSectionArray = [NSMutableArray array];
    [allSectionArray addObject:self.secionomodel1];
    [allSectionArray addObject:self.secionomodel2];
    [allSectionArray addObject:self.secionomodel3];
  
    [self requestSuccessArray:allSectionArray];
    
    [self refreshTableListDataNoPull];
    [self setRefreshHeadViewYF];
    
}


- (void)requestData
{
    [YFHttpService getUseNameComplete:^{
    }];
    
    weakTypesYF
   [self.dataModelYF getResponseStaticsDatashowLoadingOn:nil gym:self.gym successBlock:^{
       weakS.secionomodel2.dataArray = weakS.dataModelYF.arrayToday;
//       [weakS.baseTableView reloadData];
//       [weakS.baseTableView reloadSections:[NSIndexSet indexSetWithIndex:1] withRowAnimation:UITableViewRowAnimationNone];
       [weakS successRequest];
       [weakS stopLoadingViewWithMessage:nil];
       [weakS.baseTableView.mj_header endRefreshing];
   } failBlock:^{
       [weakS failRequest:nil];
   }];
}
- (void)successRequest
{
    YFStuFollowingOpCModel * model1 = [YFStuFollowingOpCModel defaultWithYYModelDic:nil];
    YFStuFollowingOpCModel * model2 = [YFStuFollowingOpCModel defaultWithYYModelDic:nil];
    YFStuFollowingOpCModel * model3 = [YFStuFollowingOpCModel defaultWithYYModelDic:nil];

    YFThreeChartModel *model = self.secionomodel2.dataArray[1];
    
    model1.staticModel = model.neCreateUsersModel;
    model1.typeTitle = @"新增注册";
    model1.defaultColor = YFFirstChartDeColor;

    
    model2.staticModel = model.neFollowingUsers;
    model2.typeTitle = @"新增跟进";
    model2.defaultColor = YFSecondChartDeColor;
    
    model3.staticModel = model.neMemberUsers;
    model3.typeTitle = @"新增会员";
    model3.defaultColor = YFThreeChartDeColor;

    [self.secionomodel1.dataArray removeAllObjects];
    [self.secionomodel2.dataArray removeAllObjects];
    [self.secionomodel3.dataArray removeAllObjects];

    
    [self.secionomodel1.dataArray addObject:model1];
    [self.secionomodel2.dataArray addObject:model2];
    [self.secionomodel3.dataArray addObject:model3];
    
    [self.baseTableView reloadData];
}

- (void)setDataModel:(YFStuFollowingOpCModel *)model
{
    model.defaultColor = [UIColor redColor];
    
}
#pragma mark  代理Model 的设置
-(YFTBBaseDatasource *)dataSourceTBYF
{
    weakTypesYF
        return [YFTBSectionsDataSource tableDelegeteWithArray:^NSMutableArray *{
            return weakS.baseDataArray;
        }  currentVC:self];
}

-(YFTBSectionsDelegate *)delegateTBYF
{
    weakTypesYF
    return [YFTBSectionsLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
}


-(YFStudentFolowDataModel *)dataModelYF
{
    if (!_dataModelYF)
    {
        _dataModelYF = [[YFStudentFolowDataModel alloc] init];
    }
    return _dataModelYF;
}

- (YFTBSectionsTitleModel *)secionomodel1
{
    if (!_secionomodel1)
    {
        _secionomodel1 = [[YFTBSectionsTitleModel alloc] init];
        [_secionomodel1 setGrayViewHeight:15];
    }
    return _secionomodel1;
}

- (YFTBSectionsTitleModel *)secionomodel2
{
    if (!_secionomodel2)
    {
        _secionomodel2 = [[YFTBSectionsTitleModel alloc] init];
        [_secionomodel2 setGrayViewHeight:15];
    }
    return _secionomodel2;
}


- (YFTBSectionsTitleModel *)secionomodel3
{
    if (!_secionomodel3)
    {
        _secionomodel3 = [[YFTBSectionsTitleModel alloc] init];
        [_secionomodel3 setGrayViewHeight:15];

    }
    return _secionomodel3;
}

-(void)reloadNetDataYF
{
    self.canNoPullRefresh = YES;
    [self refreshTableListDataNoPull];
}

@end
