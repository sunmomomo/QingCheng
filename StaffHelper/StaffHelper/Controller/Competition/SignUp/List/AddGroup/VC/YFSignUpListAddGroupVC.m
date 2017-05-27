//
//  YFSignUpListAddGroupVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListAddGroupVC.h"

#import "YFSignUpListAddGroupCModel.h"

#import "YFTBSectionsModel.h"

#import "YFGrayCellModel.h"


#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFCompetitionModule.h"

#import "YFSignUpGroupMemCModel.h"

#import "UITableView+YFReloadExtension.h"

#import "YFAppService.h"

#import "YFSignUpViewModel.h"

#import "UIView+YFLoadAniView.h"

#import "UIView+lineViewYF.h"

@interface YFSignUpListAddGroupVC ()

@property(nonatomic,strong)UITextField *textField;

@property(nonatomic, strong)YFGrayCellModel *grayCellModel;

@property(nonatomic, strong)YFTBSectionsModel *sectionsListModel;

@property(nonatomic, strong)NSMutableArray *selectDicArray;

@property(nonatomic, strong)YFSignUpViewModel *viewModel;


@end

@implementation YFSignUpListAddGroupVC


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self createUI];
    
    [self requestData];
}

- (void)requestData
{
    NSMutableArray *dataArray = [NSMutableArray array];
    
    
    YFTBSectionsModel *sectionsModel1 = [[YFTBSectionsModel alloc] init];
    [dataArray addObject:sectionsModel1];
    
    [sectionsModel1.dataArray addObject:self.grayCellModel];

    
  
    weakTypesYF
    YFSignUpListAddGroupCModel *addGroupModel = [YFSignUpListAddGroupCModel defaultWithYYModelDic:nil selectBlock:^(id model) {
        [weakS addPerAction:model];
    }];
    addGroupModel.name = @"添加成员";
    [sectionsModel1.dataArray addObject:addGroupModel];

    
    
    [dataArray addObject:self.sectionsListModel];
    
    
    self.baseDataArray = dataArray;
    [self.baseTableView reloadData];

}

-(void)createUI
{
    self.baseTableView.contentInset = UIEdgeInsetsMake(15, 0, 0, 0);
    
    self.title = @"新建分组";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"确定";
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, 50)];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    
    
    self.textField = [[UITextField alloc]initWithFrame:CGRectMake(15, 0, MSW-30, 50)];
    
    
    self.textField.font = FontSizeFY(15);
    
    self.textField.clearButtonMode = UITextFieldViewModeWhileEditing;
    
    self.textField.placeholder = @"填写组名";
    
    self.textField.textColor = YFCellTitleColor;
    
    [topView addSubview:self.textField];
    
    [topView addLinewViewToTop];
    
    [topView addLinewViewToBottom];
//    [self.baseTableView changeTop:topView.bottom];
//    [self.baseTableView changeHeight:MSH - topView.bottom];

    [self.baseTableView setTableHeaderView:topView];
    
}


- (YFGrayCellModel *)grayCellModel
{
    if (!_grayCellModel)
    {
        _grayCellModel = [YFGrayCellModel defaultWithCellHeght:45 title:@"小组成员 (0)"];
    }
    return _grayCellModel;
}


- (YFTBSectionsModel *)sectionsListModel
{
    if (!_sectionsListModel)
    {
        _sectionsListModel = [[YFTBSectionsModel alloc] init];
    }
    return _sectionsListModel;
}


-  (void)addPerAction:(id)sender
{
    NSMutableSet *set = [NSMutableSet set];
    
    for (YFSignUpGroupMemCModel *model in self.sectionsListModel.dataArray)
    {
        [set addObject:model.p_id];
    }
    
    weakTypesYF
    UIViewController *controller = [YFCompetitionModule signUpChoosePerListVCWithGym:self.gym_id comeptitionId:self.comeptition_id  chooseidNumSet:set completion:^(NSMutableArray * chooseArray,id vc) {
        
        weakS.selectDicArray = chooseArray;
        
        NSMutableArray *array = [NSMutableArray array];
        
        for (NSDictionary *dic in chooseArray)
        {
            YFSignUpGroupMemCModel *groupModel = [YFSignUpGroupMemCModel defaultWithYYModelDic:dic];
            
            [array addObject:groupModel];
        }
        
        [weakS.sectionsListModel.dataArray removeAllObjects];
        [weakS.sectionsListModel.dataArray addObjectsFromArray:array];
        
        
        weakS.grayCellModel.title = [NSString stringWithFormat:@"小组成员 (%@)",@(array.count)];
        [weakS.baseTableView reloadData];
//        [weakS.baseTableView reloadSectionYF:weakS.sectionsListModel.indexPath.section];
        [weakS.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)naviRightClick
{
    if (self.textField.text.length <= 0)
    {
        [YFAppService showAlertMessage:@"请填写组名"];
        return;
    }
    
    NSMutableArray *idsArray = [NSMutableArray array];
    
    [self.view setLoadViewOffsetNavi];
    
    for (YFSignUpGroupMemCModel *groupModel in self.sectionsListModel.dataArray)
    {
        [idsArray addObject:groupModel.p_id];
    }
    
    weakTypesYF

    self.viewModel.competition_id = self.comeptition_id;
    [self.viewModel postGroupName:self.textField.text userIds:idsArray showLoadingOn:self.view successBlock:^{
        if (weakS.addSuccessBlock)
        {
            weakS.addSuccessBlock(weakS.viewModel.addTeamDic);
        }
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}

- (YFSignUpViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFSignUpViewModel dataModel];
        _viewModel.gym_id = self.gym_id;

    }
    return _viewModel;
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
    return  [YFTBSectionsLineEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
    } currentVC:self];
}

@end
