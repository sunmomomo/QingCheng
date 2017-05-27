//
//  YFContestListVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/23.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFContestListVC.h"

#import "YFContestListSubVC.h"

@interface YFContestListVC ()

@end

@implementation YFContestListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title = @"赛事训练营";
    
    [self.tabsView loadButtonWithoutScrolWithTitles:@[@"发现训练营",@"我报名的"] buttonsGap:20 leftTrainGap:30];
    
    YFContestListSubVC *contestFindVC = [[YFContestListSubVC alloc] init];
    YFContestListSubVC *contestMyVC = [[YFContestListSubVC alloc] init];
    
    [self.scrollVCs loadVC:contestFindVC];
    [self.scrollVCs loadVC:contestMyVC];

    
}


@end
