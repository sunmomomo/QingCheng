//
//  YFGroupSmsVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFGroupSmsVC.h"

#import "YFSmsListVC.h"

#import "YFCreateNewSmsVC.h"

@interface YFGroupSmsVC ()

@end






@implementation YFGroupSmsVC

- (instancetype)init
{
    if (self = [super init]) {
        
        // 发送 成功
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendSmsDraftSuccess) name:kPostSenderGroupDraftSmsSuccessIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(sendNewSmsSuccess) name:kPostSenderGroupSmsSuccessIdtifierYF object:nil];
// 操作 草稿
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteSmsDraftSuccess) name:kPostDeleteSmsDraftSuccessIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(saveToSmsDraftSuccess) name:kPostAddSmsDraftSuccessIdtifierYF object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(updateToSmsDraftSuccess) name:kPostUpdataSmsDraftSuccessIdtifierYF object:nil];

    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

// 新短信发送成功,显示 已发送页面
- (void)sendNewSmsSuccess
{
    
    [self showSuccessSendHint];
    
    [self refreshPageWithIndex:0];
    [self refreshPageWithIndex:1];
    [self.scrollVCs scrollToViewWithIndex:2];
    
    [self showSelfVC];
}

- (void)sendSmsDraftSuccess
{

    [self showSuccessSendHint];
    
    [self refreshPageWithIndex:0];
    [self refreshPageWithIndex:1];
    [self refreshPageWithIndex:2];
    [self.scrollVCs scrollToViewWithIndex:2];
    
    [self showSelfVC];
}
// 保存至短信草稿
- (void)saveToSmsDraftSuccess
{
    [self showSelfVC];
    [self showSuccessSaveToDraftHint];
    [self refreshPageWithIndex:0];
    [self refreshPageWithIndex:2];
    [self.scrollVCs scrollToViewWithIndex:3];
}

- (void)updateToSmsDraftSuccess
{
    [self saveToSmsDraftSuccess];
}
// 删除短信草稿 成功
- (void)deleteSmsDraftSuccess
{
    [self showSelfVC];
    [self refreshPageWithIndex:0];
    [self refreshPageWithIndex:2];
    [self.scrollVCs scrollToViewWithIndex:3];
}

- (void)showSelfVC
{
    [self.navigationController popToViewController:self animated:YES];
}

// 刷新 第几个 页面
- (void)refreshPageWithIndex:(NSUInteger)index
{
    YFSmsListVC *vc = (YFSmsListVC *)[self.scrollVCs vcWithIndex:index];
    
    [vc refreshTableListDataNoPull];
}


- (void)showSuccessSaveToDraftHint
{
    UIImageView *succeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 44, 41)];
    [succeImageView setImage:[UIImage imageNamed:@"SaveToDraft"]];
    
    [self showHint:@"保存成功" customView:succeImageView];
}

- (void)showSuccessSendHint
{
    UIImageView *succeImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 50, 36)];
    [succeImageView setImage:[UIImage imageNamed:@"SendSmsSuccess"]];
    
    [self showHint:@"发送成功" customView:succeImageView];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

//    self.rightTitle = @"发送成功测试";
    
    self.title = @"群发短信";
    
    
    
    self.view.backgroundColor = [UIColor whiteColor];
    [self.tabsView loadButtonWithoutScrolWithTitles:@[@"全部",@"已发送",@"草稿箱"] buttonsGap:20 leftTrainGap:58];
    
    [self.view addSubview:self.tabsView];
    [self.view addSubview:self.scrollVCs];
    
    YFSmsListVC *vc1 = [[YFSmsListVC alloc] init];
    vc1.gym = self.gym;
    vc1.status = nil;
    
    YFSmsListVC *vc2 = [[YFSmsListVC alloc] init];
    vc2.gym = self.gym;
    vc2.status = @"1";
    
    YFSmsListVC *vc3 = [[YFSmsListVC alloc] init];
    vc3.status = @"2";
    vc3.gym = self.gym;
    
    [self.scrollVCs loadVC:vc1];
    [self.scrollVCs loadVC:vc2];
    [self.scrollVCs loadVC:vc3];
    
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW-Width320(74), MSH-Height320(75), Width(56), Height(56))];
    
    [addButton setImage:[UIImage imageNamed:@"CreatNewSms"] forState:UIControlStateNormal];
    
    addButton.layer.shadowOffset = CGSizeMake(0, Height320(2));
    
    addButton.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
    
    addButton.layer.shadowOpacity = 0.3;
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addSms:) forControlEvents:UIControlEventTouchUpInside];

}


- (void)addSms:(UIButton *)sender
{
    YFCreateNewSmsVC * newSmsVC = [[YFCreateNewSmsVC alloc] init];
    
    [self.navigationController pushViewController:newSmsVC animated:YES];
}


@end
