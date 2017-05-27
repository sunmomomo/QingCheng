//
//  YFSignUpListDeletePerVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListDeletePerVC.h"

#import "YFSignUpViewModel.h"

#import "YFSignUpListDeletePerCModel.h"

#import "UITableView+YFReloadExtension.h"

#import "UIView+YFLoadAniView.h"

@interface YFSignUpListDeletePerVC ()

@property(nonatomic, strong)YFSignUpViewModel *viewModel;

@end

@implementation YFSignUpListDeletePerVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.leftTitle = @"取消";
    self.leftColor = [UIColor whiteColor];
    self.rightTitle = @"完成";

//    [self refreshTableListDataNoPull];

    [self requestData];
}


- (void)requestData
{   
    NSMutableArray *dataArray = [NSMutableArray array];
    for (NSDictionary *dic in self.allUsersDicArray)
    {
        weakTypesYF
        YFSignUpListDeletePerCModel *model = [YFSignUpListDeletePerCModel defaultWithYYModelDic:dic selectBlock:^(id mmm) {
           
            NSInteger index = [weakS.baseDataArray indexOfObject:mmm];
            
            if (index >=0 && index < weakS.baseDataArray.count)
            {
                [weakS.baseDataArray removeObjectAtIndex:index];
                [weakS.baseTableView deleteSectionYF:0 row:index];
            }
        }];
        
        [dataArray addObject:model];
    }
    
    self.baseDataArray = dataArray ;
    [self.baseTableView reloadData];

    
//    self.viewModel.page = self.dataPage;
//    [self requestSuccessArray:[YFSignUpListDeletePerCModel creatTestModelArray]];
}

- (void)naviRightClick
{
    NSMutableSet *idDicSet = [NSMutableSet set];
    
    for (YFSignUpListDeletePerCModel *idModel in self.baseDataArray)
    {
            [idDicSet addObject:idModel.su_id];
    }
    [self.view.loadViewYF setLoadViewOffsetNavi];
    weakTypesYF
    [self.viewModel putGroupName:nil userIds:idDicSet.allObjects teams_id:self.team_id showLoadingOn:weakS.view successBlock:^{
        [weakS showHint:@"移除成功"];
        if (weakS.deletidArraySuccessBlock)
        {
            weakS.deletidArraySuccessBlock(nil);
        }
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [weakS.navigationController popViewControllerAnimated:YES];
        });
    } failBlock:^{
        
    }];

}

- (YFSignUpViewModel *)viewModel
{
    if (!_viewModel)
    {
        _viewModel = [YFSignUpViewModel dataModel];
    }
    return _viewModel;
}

@end
