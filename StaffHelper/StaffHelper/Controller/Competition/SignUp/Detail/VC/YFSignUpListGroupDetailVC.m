//
//  YFSignUpListGroupDetailVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/28.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListGroupDetailVC.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsSignUpGroupModel.h"

#import "YFSignUpGroupDetailModel.h"

#import "YFSignUpListAddPerVC.h"

#import "YFSignUpListDeletePerVC.h"

#import "YFCompetitionModule.h"

#import "YFSignUpViewModel.h"

#import "YFSignUpGroupMemCModel.h"

#import "NSMutableArray+YFExtension.h"

#import "NSMutableDictionary+YFExtension.h"

#import "YFCompetionHeader.h"

#import "UIActionSheet+YFAdditions.h"

@interface YFSignUpListGroupDetailVC ()

@end

@implementation YFSignUpListGroupDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initView];
    [self refreshTableListDataNoPull];
}

- (void)initView
{
    [self setRefreshHeadViewYF];
    self.rightType = MONaviRightTypeMore;
    self.canGetMore = NO;
    self.baseTableView.backgroundColor = YFGrayViewColor;
    // 底部 显示 部分 灰色 条
    self.baseTableView.contentInset = UIEdgeInsetsMake(0, 0, 30, 0);
}

- (void)requestData
{
    
    weakTypesYF
    
    [self.viewModel getResponseGroupDetailDatashowLoadingOn:nil teams_id:self.teams_id successBlock:^{
        
        [weakS.viewModel.groupDetailModel.sectionTwoModel.addButton addTarget:weakS action:@selector(addMemeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [weakS.viewModel.groupDetailModel.sectionTwoModel.deleteButton addTarget:weakS action:@selector(deleteMemeAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [weakS requestSuccessArray:weakS.viewModel.groupDetailModel.dataArray];
        
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    YFSignUpGroupDetailModel *model = [YFSignUpGroupDetailModel creatTestArray];
    
   
}


- (void)addMemeAction:(UIButton *)sender
{
    NSMutableSet *idDicSet = [NSMutableSet set];
    
    for (YFSignUpGroupMemCModel *model in self.viewModel.groupDetailModel.users)
    {
        [idDicSet addObject:model.p_id];
    }
    
    weakTypesYF
    
    UIViewController *controller = [YFCompetitionModule signUpChoosePerListVCWithGym:self.gym_id comeptitionId:self.comeptition_id chooseidNumSet:idDicSet completion:^(NSMutableArray * chooseArray,id vc) {

        [weakS addMemWithMemberArray:chooseArray onController:vc];
    }];
    
    [self.navigationController pushViewController:controller animated:YES];
//
}

- (void)addMemWithMemberArray:(NSArray *)array onController:(YFBaseVC *)controller
{
    NSMutableSet *idDicSet = [NSMutableSet set];
    
    for (YFSignUpGroupMemCModel *model in self.viewModel.groupDetailModel.users)
    {
        [idDicSet addObject:model.p_id];
    }

    for (NSDictionary *dic in array)
    {
        if ([dic isKindOfClass:[NSDictionary class]])
        {
            NSNumber *idNumber = [dic[@"id"] guardNumberYF];

            if (idNumber) {
            [idDicSet addObject:idNumber];
            }
        }
    }
    
    weakTypesYF
    __weak typeof(controller)weakVC = controller;
    [self.viewModel putGroupName:nil userIds:idDicSet.allObjects teams_id:self.teams_id showLoadingOn:controller.view  successBlock:^{
        [weakS refreshTableListDataNoPull];
        
        [weakVC showHint:@"添加成功"];
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostChangeGroupMemberIdtifierYF object:nil];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakS.navigationController popViewControllerAnimated:YES];
        });
        

    } failBlock:^{
       
    }];
}


- (void)deleteMemeAction:(UIButton *)sender
{
    YFSignUpListDeletePerVC *deletVC = allocInObjYF(YFSignUpListDeletePerVC);
    deletVC.team_id = self.teams_id;
    
    weakTypesYF
    [deletVC setDeletidArraySuccessBlock:^(NSMutableArray * array) {
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostChangeGroupMemberIdtifierYF object:nil];

        
        [weakS refreshTableListDataNoPull];
    }];
    
    NSMutableArray *array = [NSMutableArray array];
    for (YFSignUpGroupMemCModel *model in self.viewModel.groupDetailModel.users)
    {
        [array addObject:model.toJsonDic];
    }

    deletVC.allUsersDicArray = array;
    
    [self.navigationController pushViewController:deletVC animated:YES];
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

- (void)naviRightClick
{
    weakTypesYF
    [UIActionSheet actionSWithCallBackBlock:^(NSInteger buttonIndex) {
        NSLog(@"%@",@(buttonIndex));
        if (buttonIndex == 0) {
            [weakS deleteAction];
        }
    } title:nil destructiveButtonTitle:@"删除该分组" cancelButtonName:@"取消" otherButtonTitles:nil];
}

- (void)deleteAction
{
    weakTypesYF
    [self.viewModel deleteGroupShowLoadingOn:self.view teams_id:self.teams_id successBlock:^{
        [weakS showHint:@"删除成功"];

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [[NSNotificationCenter defaultCenter] postNotificationName:kDeleteCompetitionGroupIdtifierYF object:nil];
        });
    } failBlock:nil];
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
