//
//  MessageController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/18.
//  Copyright (c) 2015年 馍馍帝👿. All rights reserved.
//

#import "MessageController.h"

#import "ChooseView.h"

#import "MessageCell.h"

#import "WebViewController.h"

#import "RootController.h"

#import "MOTableView.h"

#define ClearAPI @"/api/coaches/%ld/notifications/clear/"

#define ReadAPI @"/api/notifications/%ld/clear/"

static NSString *identifier = @"Cell";

@interface MessageController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate>

@property(nonatomic,strong)MessageInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation MessageController

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
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    [self reloadData];
    
}
  
  -(void)updateData
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        if (success && [error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}


-(void)reloadData
{
    
    MessageInfo *info = [[MessageInfo alloc]init];
    
    info.type = self.type;
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.info = info;
            
            [self.tableView.mj_footer resetNoMoreData];
            
        }
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
        self.tableView.mj_footer.hidden = self.tableView.contentSize.height<self.tableView.height;
        
    }];
    
}

  -(void)createUI
{
    
    switch (self.type) {
            
        case MessageInfoTypeGym:
            
            self.title = @"场馆信息";
            
            break;
            
        case MessageInfoTypeSystem:
            
            self.title = @"系统通知";
            
            break;
            
        case MessageInfoTypeStudy:
            
            self.title = @"学习培训";
            
            break;
            
        case MessageInfoTypeCheckin:
            
            self.title = @"签到处理";
            
            break;
            
        case MessageInfoTypeMatch:
            
            self.title = @"赛事训练营";
            
            break;
            
        default:
            break;
    }
    
    self.rightTitle = @"全部已读";
    
    self.rightColor = UIColorFromRGB(0xffffff);
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[MessageCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoNormalFooter *footer = [MJRefreshAutoNormalFooter footerWithRefreshingBlock:^{
        
        [self updateData];
        
    }];
    
    [footer setTitle:@"无更多数据" forState:MJRefreshStateNoMoreData];
    
    [footer setTitle:@"正在加载..." forState:MJRefreshStateRefreshing];
    
    self.tableView.mj_footer = footer;
    
    [self.view addSubview:self.tableView];
    
}

  -(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.messages.count;
    
}

  -(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Message *msg = self.info.messages[indexPath.row];
    
    cell.haveRead = msg.readed;
    
    cell.iconURL = msg.imgUrl;
    
    cell.title = msg.title;
    
    cell.descriptions = msg.content;
    
    cell.time = msg.time;
    
    cell.gymName = msg.gym.name;
    
    cell.haveArrow = msg.url.absoluteString.length;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}
  
  -(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *msg = self.info.messages[indexPath.row];
    
    CGSize size = [msg.content boundingRectWithSize:CGSizeMake(Width320(225), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    return size.height+Height320(65);
    
}
  
  -(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Message *msg = self.info.messages[indexPath.row];
    
    MessageInfo *info = [[MessageInfo alloc]init];
    
    [info readMessage:msg result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            msg.readed = YES;
            
            [tableView reloadData];
            
        }
        
    }];
    
    if (msg.url.absoluteString.length){
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        svc.url = msg.url;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}
  
  -(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(73), Height320(107), Width320(174), Height320(146))];
    
    emptyImg.image = [UIImage imageNamed:@"message_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(10), emptyImg.bottom+Height320(15), emptyView.width-Width320(20), Height320(15))];
    
    emptyLabel.text = @"暂无通知";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}
  
  -(void)naviRightClick
{
    
    UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"全部标为已读？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    
    [alert show];
    
}
  
  -(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        MessageInfo *info = [[MessageInfo alloc]init];
        
        [info readAllMessageResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                [self reloadData];
                
            }
            
        }];
        
    }
    
}

-(void)naviLeftClick
{
    
    [self popViewControllerAndReloadData];
    
}
  

@end
