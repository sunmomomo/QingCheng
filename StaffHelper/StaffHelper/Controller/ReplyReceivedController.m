//
//  ReplyReceivedController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/2.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ReplyReceivedController.h"

#import "MOTableView.h"

#import "ReplyReceivedCell.h"

#import "ReplyReceivedInfo.h"

#import "WebViewController.h"

#import "NewsCommentsController.h"

static NSString *identifier = @"Cell";

@interface ReplyReceivedController ()<MOTableViewDatasource,UITableViewDelegate,ReplyReceivedCellDelegate>

@property(nonatomic,strong)ReplyReceivedInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *replys;

@end

@implementation ReplyReceivedController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    ReplyReceivedInfo *info = [[ReplyReceivedInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if ([error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        [self.tableView.mj_header endRefreshing];
        
        self.info = info;
        
        self.replys = info.comments;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)update
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        if ([error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        self.replys = self.info.comments;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"收到回复";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(update)];
    
    [footer setTitle:@"无更多回复" forState:MJRefreshStateNoMoreData];
    
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
    
    [self.tableView registerClass:[ReplyReceivedCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.replys.count;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 1;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height(15);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReplyReceived *reply = self.replys[indexPath.section];
    
    return reply.cellHeight;
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    return [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(15))];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReplyReceivedCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    ReplyReceived *reply = self.replys[indexPath.section];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.name = reply.username;
    
    cell.time = reply.time;
    
    cell.replyForName = reply.replyForName;
    
    cell.iconURL = reply.iconURL;
    
    cell.replyContent = reply.reply;
    
    cell.pressContent = reply.press.content;
    
    cell.pressTitle = reply.press.title;
    
    cell.pressIconURL = reply.press.iconURL;
    
    cell.delegate = self;
    
    cell.tag = indexPath.section;
    
    return cell;
    
}

-(void)replyWithReplyCell:(ReplyReceivedCell *)cell
{
    
    ReplyReceived *reply = self.replys[cell.tag];
    
    NewsCommentsController *svc = [[NewsCommentsController alloc]init];
    
    svc.press = reply.press;
    
    svc.reply = reply;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReplyReceived *reply = self.replys[indexPath.section];
    
    WebViewController *vc = [[WebViewController alloc]init];
    
    vc.url = reply.press.URL;
    
    [self.navigationController pushViewController:vc animated:YES];
    
}

@end
