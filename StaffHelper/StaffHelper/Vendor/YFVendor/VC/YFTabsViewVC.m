//
//  YFTabsViewVC.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/13.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFTabsViewVC.h"

@interface YFTabsViewVC ()

@end

@implementation YFTabsViewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}


- (YFTabsView *)tabsView
{
    if (_tabsView == nil)
    {
        __weak typeof(self)weakS = self;
        YFTabsView *tabsView = [[YFTabsView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, 44)];
        [tabsView setClickIndex:^(NSUInteger index)
         {
             DebugLogParamYF(@"点击了第%ld个分类",(unsigned long)index);
             [weakS.scrollVCs scrollToViewWithIndex:index];
         }];
        [self.view addSubview:tabsView];
        
        _tabsView = tabsView;
    }
    return _tabsView;
}

- (YFScrollVCs *)scrollVCs
{
    if (_scrollVCs == nil)
    {
        YFScrollVCs *scrollVCs = [[YFScrollVCs alloc] initWithFrame:CGRectMake(0, 108,MSW, MSH - 108)];
        // 超出_mainScrollView 显示范围的 截取掉
        scrollVCs.clipsToBounds = YES;
        __weak typeof(self)weakS = self;
        [scrollVCs setEndScrollToVC:^(UIViewController * VC) {
            //        [weakS endScrollToVCFY:VC];
        }];
        [scrollVCs setScrollToIndex:^(NSUInteger index) {
            //            NSLog(@"列表滑到了第%ld个",index);
            // 分类 View 和 列表 显示的 信息 同步
            [weakS.tabsView scrollToCategoryWithIndex:index];
        }];
        
        [scrollVCs setScrollViewDidScroll:^(UIScrollView * scrollView) {
            // 分类View 接收 _mainScrollView 的滑动情况
            [weakS.tabsView mainScrollViewDidSroll:scrollView];
        }];
        
        scrollVCs.paranteVC = self;
        _scrollVCs = scrollVCs;
    }
    return _scrollVCs;
}


@end
