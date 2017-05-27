//
//  YFBaseRefreshTBVC.m
//  OCTBLogical
//
//  Created by YFWCQ on 16/12/15.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseRefreshTBVC.h"

@interface YFBaseRefreshTBVC ()

@end

@implementation YFBaseRefreshTBVC

- (UIScrollView *)getScrollViewYF
{
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 64.0, MSW, MSH - 64.0f) style:UITableViewStylePlain];
    tableView.backgroundColor = [UIColor clearColor];

    if ([tableView respondsToSelector:@selector(setSeparatorInset:)])
    {
        tableView.separatorInset = UIEdgeInsetsZero;
    }
    if ([tableView respondsToSelector:@selector(setLayoutMargins:)])
    {
        tableView.layoutMargins = UIEdgeInsetsZero;
    }
    
    tableView.tableFooterView = [[UIView alloc] init];
    
    self.baseTableView = tableView;
    self.baseTableView.separatorColor = YFLineViewColor;

       //    tableView = UITableViewCellSeparatorStyleNone; // 去掉横线
    
    return tableView;
}

- (void)setScrollViewDelegateFY
{
    self.baseTableView.delegate = self;
    self.baseTableView.dataSource = self;
}


#pragma mark TableView  Delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.baseDataArray.count;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 44;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell respondsToSelector:@selector(setSeparatorInset:)])
    {
        [cell setSeparatorInset:UIEdgeInsetsZero];
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)])
    {
        [cell setLayoutMargins:UIEdgeInsetsZero];
    }
}


#pragma mark - UITableView DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:cellIdentifier];
    }
    return cell;
}


@end
