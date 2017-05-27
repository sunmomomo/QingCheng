//
//  YFSignUpListGroupVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/27.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListGroupVC.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsLineEdgeDelegate.h"

#import "YFTBSectionsModel.h"

#import "YFSignUpListAddGroupCModel.h"

#import "YFSignUpGroupCModel.h"

#import "YFCompetitionModule.h"

#import "YFCompetionHeader.h"

#import "YFEmptyView.h"

@interface YFSignUpListGroupVC ()

@end

@implementation YFSignUpListGroupVC
{
    YFEmptyView *_emptyViewYF;
}


- (void)viewDidLoad
{
    weakTypesYF
    [self.viewModel setAddGroupBlock:^(id model) {
        [weakS addGroupAction:nil];
    }];
    self.canGetMore = NO;

    [super viewDidLoad];
    
    self.searchBar.placeholder = @"搜索组名";
    
    
}

- (void)requestData
{
    self.viewModel.page = self.dataPage;
    
    self.viewModel.searchStr = self.searchBar.text;
    
    self.viewModel.competition_id = self.competition_id;
    
    self.viewModel.gym_id = self.gym_id;

    weakTypesYF
    
    [self.viewModel getResponseGroupListDatashowLoadingOn:nil  listModelClass:[YFSignUpGroupCModel class] successBlock:^{
        
      weakS.peoPayNumLabel.text = [NSString stringWithFormat:@"所有分组 (%@)",weakS.viewModel.arrayModel.total_count];
        if (weakS.viewModel.arrayModel.total_count.integerValue == 0) {
            [weakS emptyDataReminderAction];
        }
      [weakS requestSuccessArray:weakS.viewModel.arrayModel.listArray];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
    
//    [self requestSuccessArray:[YFSignUpListAddGroupCModel creatTestArray]];
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


- (UIView *)emptyView
{
    if (!_emptyViewYF)
    {
        _emptyViewYF = [[YFEmptyView alloc] initWithFrame:CGRectMake(0, 60, self.baseTableView.width, self.baseTableView.height - 60)];
        
        CGFloat emptyImageWidht = 144;
        CGFloat emptyImageHeight = 146;
        
        CGFloat emptyImageYY = 126;
        
        CGFloat emptyImageXX = (_emptyViewYF.width - emptyImageWidht )/ 2.0;
        
        _emptyViewYF.emptyImg.frame = CGRectMake(emptyImageXX, emptyImageYY, emptyImageWidht, emptyImageHeight);
        
        _emptyViewYF.backgroundColor = [UIColor whiteColor];
        
        _emptyViewYF.emptyImg.image = [UIImage imageNamed:@"SmsEmptyImage"];
        
        
        _emptyViewYF.emptyLabel.textColor = YFCellSubGrayTitleColor;
        
        _emptyViewYF.emptyLabel.font = FontSizeFY(Width(16));
        
        _emptyViewYF.emptyLabel.frame = CGRectMake(_emptyViewYF.emptyLabel.mj_x, _emptyViewYF.emptyImg.bottom + Height320(3.5), _emptyViewYF.emptyLabel.width, _emptyViewYF.emptyLabel.height);
        
        _emptyViewYF.addbutton.hidden = YES;
        
        CGFloat width = Width(160);
        CGFloat height = Width(44);
        
        _emptyViewYF.addbutton.frame = CGRectMake((MSW - width)/2.0, _emptyViewYF.emptyLabel.bottom + 30, width, height);
        
        [_emptyViewYF.addbutton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_emptyViewYF.addbutton setBackgroundColor:YFThreeChartDeColor];

        [_emptyViewYF.addbutton addTarget:self action:@selector(addGroupAction:) forControlEvents:UIControlEventTouchUpInside];
        
        [_emptyViewYF.addbutton setTitle:@"新建分组" forState:UIControlStateNormal];
        
        _emptyViewYF.addbutton.hidden = NO;
    }
    if (self.viewModel.searchStr.length)
    {
        _emptyViewYF.emptyLabel.text = @"未找到结果";
        _emptyViewYF.frame = CGRectMake(0, 60, self.baseTableView.width, self.baseTableView.height - 60);
        
        [_emptyViewYF.emptyImg changeTop:66];

    }
    else
    {
        _emptyViewYF.frame = self.baseTableView.bounds;
        _emptyViewYF.emptyLabel.text = @"还没有任何分组";
        
        [_emptyViewYF.emptyImg changeTop:126];

    }
    [_emptyViewYF.emptyLabel changeTop:_emptyViewYF.emptyImg.bottom + Height320(3.5)];

    
    [_emptyViewYF.addbutton changeTop:_emptyViewYF.emptyLabel.bottom+Height320(19.5)];
    
    return _emptyViewYF;
}

- (void)addGroupAction:(id)sender
{
    UIViewController *addVC = [YFCompetitionModule signUpAddGroupListVCWithGym:self.gym_id comeptitionId:self.competition_id completion:^(id model) {
        
        [self refreshTableListDataNoPull];
        [self.navigationController popViewControllerAnimated:YES];
    }];
    [self.navigationController pushViewController:addVC animated:YES];

}



@end
