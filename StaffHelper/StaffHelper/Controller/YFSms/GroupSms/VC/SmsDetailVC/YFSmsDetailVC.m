//
//  YFSmsDetailVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/14.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSmsDetailVC.h"

#import "YFSenderCModel.h"

#import "YFDesValueCModel.h"

#import "YFSmsRecipentCModel.h"

#import "TCCopyableLabel.h"

#import "YFButton.h"

#import "YFAppService.h"

#import "YFSmsDetaiDataModel.h"

#import "YFTBSectionsDataSource.h"

#import "YFTBSectionsLineExEdgeDelegate.h"

#import "YFTBSectionsModel.h"

#import "YFSmsRecipentSubCModel.h"

#import "YFTBSmsDetailSectionModel.h"

#import "YFSmsListCModel.h"

#import "UIView+YFLoadAniView.h"

#import "YFCreateNewSmsVC.h"

#import "YFTBSectionsLineExSmsEdgeDelegate.h"

@interface YFSmsDetailVC ()

@property(nonatomic, strong)UIView *footView;

@property(nonatomic, strong)YFSmsDetaiDataModel *viewModel;

@property(nonatomic ,strong)TCCopyableLabel *copLabel;

@end

@implementation YFSmsDetailVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self initView];
}

- (void)initView
{
    self.title = @"短信详情";
    self.canGetMore = NO;
    [self refreshTableListDataNoPull];
    self.baseTableView.backgroundColor = [UIColor whiteColor];
    [self.baseTableView setTableFooterView:self.footView];
    
    [self.baseTableView changeHeight:MSH - 64.0 - 50];
}
- (void)requestData
{
    weakTypesYF
    self.viewModel.message_id = self.message_id;
    
    [self.viewModel getResponseDatashowLoadingOn:nil gym:self.gym successBlock:^{
        [weakS requestSuccessArray:weakS.viewModel.dataArray];
        // 适应 大小
        [weakS.baseTableView setTableFooterView:weakS.footView];

        [weakS addBottomButtonView];
    } failBlock:^{
        [weakS failRequest:nil];
    }];
}

- (UIView *)footView
{
    if (_footView == nil)
    {
        _footView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, MSW, 130)];
        
        TCCopyableLabel *copLabel = [[TCCopyableLabel alloc] initWithFrame:CGRectMake(15, 15, MSW - 30, 100)];
        _copLabel = copLabel;
        copLabel.textColor = YFCellTitleColor;
        copLabel.font = FontSizeFY(15);
        copLabel.numberOfLines = 0;
        
        copLabel.backgroundColor = [UIColor whiteColor];
        _footView.backgroundColor = [UIColor whiteColor];
        
        [_footView addSubview:copLabel];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, -OnePX, _footView.width, OnePX)];
        lineView.backgroundColor = self.baseTableView.separatorColor;
        [_footView addSubview:lineView];
    }
    _copLabel.text = self.viewModel.detailModel.content;
    [_copLabel autoHeightWithMaxSize:CGSizeMake(_copLabel.width, 100000)];
    [_footView changeHeight:_copLabel.bottom + 15];

    return _footView;
}

        
- (void)addBottomButtonView
{
    if (self.viewModel.detailModel.smsType == YFSmsTypeDraft)
    {
        UIView *bottomView = [[UIView alloc] initWithFrame:CGRectMake(0, MSH - 50, MSW, 50)];
        
        bottomView.backgroundColor = [UIColor whiteColor];
        
        UIView *lineView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, bottomView.width, 1.0)];
        lineView.backgroundColor = YFGrayViewColor;
        [bottomView addSubview:lineView];
        
        
        CGFloat buttonWidth = MSW / 3.0;
        CGFloat buttonHeight = bottomView.height;
        CGFloat  tag = 1;
        NSArray *titlesArray = @[@"删除",@"编辑",@"发送"];
        
        NSArray *imagesArray = @[@"DeleteSmsDraft",@"EditSmsDraft",@"SendSmsDraft"];
        
        CGRect imageFrame = CGRectMake(buttonWidth / 2.0 - 10, 7, 20, 20);
        
        CGRect labelFrame = CGRectMake(buttonWidth / 2.0 - 15, 29, 30, 20);
        
        for (NSString *title in titlesArray)
        {
            YFButton *button = [[YFButton alloc] initWithFrame:CGRectMake(buttonWidth * (tag  - 1), 0, buttonWidth, buttonHeight) imageFrame:imageFrame titleFrame:labelFrame];
            
            button.backgroundColor = [UIColor clearColor];
            
            [button setTitle:title forState:UIControlStateNormal];
            
            [button setTitleColor:RGB_YF(51, 51, 51) forState:UIControlStateNormal];
            
            [button addTarget:self action:@selector(buttonEditAction:) forControlEvents:UIControlEventTouchUpInside];
            NSInteger index = tag - 1;
            button.titleLabel.textAlignment = NSTextAlignmentCenter;
            [button setImage:[UIImage imageNamed:imagesArray[index]] forState:UIControlStateNormal];
            
            [button.titleLabel setFont:FontSizeFY(12.0)];
            
            button.tag = tag;
            
            tag ++;
            
            [bottomView addSubview:button];
        }
        [self.view addSubview:bottomView];
    }
}

- (void)buttonEditAction:(UIButton *)sender
{
    if (sender.tag == 1)
    {
        DebugLogParamYF(@"删除");
        
        weakTypesYF
        [YFAppService showAlertMessage:@"确定删除该草稿" sureTitle:@"删除" sureBlock:^{
            [weakS deleteDraftSms];
        }];
    }
    else if (sender.tag == 2)
    {
        DebugLogParamYF(@"编辑");
        YFCreateNewSmsVC *creatNewSmsVC = [[YFCreateNewSmsVC alloc] init];
        
        creatNewSmsVC.editModel = self.viewModel.detailModel;
        
        creatNewSmsVC.title = @"编辑草稿";
        
        [self.navigationController pushViewController:creatNewSmsVC animated:YES];
    }
    else if (sender.tag == 3)
    {
        DebugLogParamYF(@"发送");
        
        [self sendDraftSms];
    }
}

- (void)deleteDraftSms
{
    weakTypesYF
    [self.viewModel deleteDatashowLoadingOn:self.view gym:self.gym successBlock:^{
        
        [[NSNotificationCenter defaultCenter] postNotificationName:kPostDeleteSmsDraftSuccessIdtifierYF object:nil];

    } failBlock:^{
        [YFAppService showAlertMessage:@"网络不给力" sureTitle:@"再次删除" sureBlock:^{
            [weakS deleteDraftSms];
        }];
    }];
}

- (void)sendDraftSms
{
    if (self.viewModel.detailModel.users.count <= 0)
    {
        [self showHint:@"请填写收件人"];
        return;
    }
    
    if (self.viewModel.detailModel.content.length <= 0)
    {
        [self showHint:@"请填写短信内容"];
        return;
    }
    
    
    weakTypesYF
    self.viewModel.content = self.viewModel.detailModel.content;
    
    [self.viewModel setChooseArrayForIds:self.viewModel.detailModel.users];
    
    self.viewModel.message_id = self.viewModel.detailModel.sms_id;
    
    self.view.loadViewYF.frame = CGRectMake(0, 64.0, self.view.width, self.view.height - 64.0);
    
    self.viewModel.send = @"1";
    
    
    [self.viewModel updateSMSDatashowLoadingOn:self.view gym:self.gym successBlock:^{
        
        if (weakS.viewModel.send)
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostSenderGroupDraftSmsSuccessIdtifierYF object:nil];
        }else
        {
            [[NSNotificationCenter defaultCenter] postNotificationName:kPostUpdataSmsDraftSuccessIdtifierYF object:nil];
        }
        
    } failBlock:^{
        
    }];

}

#pragma mark Setter
- (YFSmsDetaiDataModel *)viewModel
{
    if (_viewModel == nil)
    {
        _viewModel = [YFSmsDetaiDataModel dataModel];
    }
    _viewModel.smsType = self.smsType;
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
    YFTBSectionsDelegate *delegaetYFTB = [YFTBSectionsLineExSmsEdgeDelegate tableDelegeteWithArray:^NSMutableArray *{
        return weakS.baseDataArray;
        
    } currentVC:self];
    
    return delegaetYFTB;
}



@end
