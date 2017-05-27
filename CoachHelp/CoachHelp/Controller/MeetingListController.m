//
//  MeetingListController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/17.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MeetingListController.h"

#import "RootController.h"

#import "MeetingCell.h"

#import "WebViewController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface MeetingListController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation MeetingListController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)reloadData
{
    
    [self.tableView reloadData];
    
}

-(void)createData
{
    
    MeetingsListInfo *meetingInfo = [[MeetingsListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(MeetingsListInfo*)weakInfo = meetingInfo;
    
    meetingInfo.request = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        if (success) {
            
            weakS.meetingsInfo = weakInfo;
            
            [weakS.tableView reloadData];
            
        }
        
        [weakS.tableView.mj_header endRefreshing];
        
    };
    
    [meetingInfo requestData];
    
}

-(void)createUI
{
    
    self.title = @"会议/培训";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[MeetingCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.meetingsInfo.meetings.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MeetingCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Meeting *meeting = self.meetingsInfo.meetings[indexPath.row];
    
    cell.title = meeting.title;
    
    cell.subtitle = meeting.time;
    
    cell.address = [NSString stringWithFormat:@"%@    %@",meeting.city,meeting.address.length?meeting.address:@""];
    
    cell.imgURL = meeting.image;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    Meeting *meeting = self.meetingsInfo.meetings[indexPath.row];
    
    svc.url = meeting.link;
    
    svc.shouldShare = YES;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(91);
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
