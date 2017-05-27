//
//  YFSignUpListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFSignUpListVC.h"

#import "YFSignUpListPerVC.h"

#import "YFSignUpListGroupVC.h"

#import "YFEmptyView.h"

#import "YFCompetionHeader.h"

@interface YFSignUpListVC ()

@property(nonatomic, strong)YFSignUpListGroupVC *groupVC;
@property(nonatomic, strong)YFSignUpListPerVC *personalVC;

@end

@implementation YFSignUpListVC

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(deleteGroupSuccess) name:kDeleteCompetitionGroupIdtifierYF object:nil];
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGroupDetail) name:kPostChangeGroupDetailIdtifierYF object:nil];

        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeGroupMember) name:kPostChangeGroupMemberIdtifierYF object:nil];
    }
    return self;
}

- (void)dealloc
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)deleteGroupSuccess
{
    [self.groupVC refreshTableListDataNoPull];
    [self.personalVC refreshTableListDataNoPull];
    [self.navigationController popToViewController:self animated:YES];
}

- (void)changeGroupMember
{
    [self.groupVC refreshTableListDataNoPull];
    [self.personalVC refreshTableListDataNoPull];
}

- (void)changeGroupDetail
{
    [self.groupVC refreshTableListDataNoPull];
    [self.personalVC refreshTableListDataNoPull];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    
    self.title = @"报名表";
    
    [self.tabsView changeHeight:50];
    [self.tabsView loadButtonWithoutScrolWithTitles:@[@"个人",@"分组"] buttonsGap:60 leftTrainGap:(MSW - 160) / 2.0];
    
    
    YFSignUpListPerVC *personalVC = [[YFSignUpListPerVC alloc] init];
    personalVC.gym_id = self.gym_id;
    personalVC.competition_id = self.comeptition_id;
    self.personalVC = personalVC;
    
    YFSignUpListGroupVC *groupVC = [[YFSignUpListGroupVC alloc] init];
    groupVC.competition_id = self.comeptition_id;
    groupVC.gym_id = self.gym_id;
    self.groupVC = groupVC;
    
    self.scrollVCs.frame = CGRectMake(0, 114, MSW, MSH - 114);
    
    [self.view addSubview:self.scrollVCs];
    [self.scrollVCs loadVC:personalVC];
    [self.scrollVCs loadVC:groupVC];
}




@end
