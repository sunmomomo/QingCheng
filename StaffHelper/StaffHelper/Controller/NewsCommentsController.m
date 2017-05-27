//
//  NewsCommentsController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/3/3.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "NewsCommentsController.h"

#import "MOTableView.h"

#import "NewsCommentCell.h"

#import "NewsCommentsInfo.h"

#import "CommentToolView.h"

#import "KeyboardManager.h"

static NSString *identifier = @"Cell";

@interface NewsCommentsController ()<MOTableViewDatasource,UITableViewDelegate,CommentToolViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *comments;

@property(nonatomic,strong)UILabel *numberLabel;

@property(nonatomic,strong)CommentToolView *toolView;

@property(nonatomic,strong)NewsCommentsInfo *info;

@property(nonatomic,strong)NSIndexPath *indexPath;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,assign)float viewHeight;

@property(nonatomic,strong)NewsComment *comment;

@end

@implementation NewsCommentsController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
    [IQKeyboardManager sharedManager].enable = NO;
    
}

-(void)createData
{
    
    self.viewHeight = MSH;
    
    if (self.reply) {
        
        NewsComment *comment = [[NewsComment alloc]init];
        
        comment.commentId = self.reply.replyId;
        
        comment.user = [[User alloc]init];
        
        comment.user.username = self.reply.username;
        
        self.comment = comment;
        
    }
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    NewsCommentsInfo *info = [[NewsCommentsInfo alloc]init];
    
    [info requestWithPress:self.press result:^(BOOL success, NSString *error) {
        
        self.info = info;
        
        self.countLabel.text = [NSString stringWithFormat:@"全部评论（%ld）",(long)self.info.totalCount];
        
        if ([error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        self.tableView.dataSuccess = success;
        
        self.comments = self.info.comments;
        
        [self.tableView.mj_header endRefreshing];
        
        self.tableView.contentOffset = CGPointMake(0, 0);
        
        [self.tableView reloadData];
        
        if (self.comment) {
            
            self.toolView.textView.placeholder = [NSString stringWithFormat:@"回复%@：",self.comment.user.username];
            
            [self.toolView becomeFirstResponder];
            
        }
        
    }];
    
}

-(void)update
{
    
    [self.info requestWithPress:self.press result:^(BOOL success, NSString *error) {
        
        self.countLabel.text = [NSString stringWithFormat:@"全部评论（%ld）",(long)self.info.totalCount];
        
        if ([error isEqualToString:@"无更多数据"]) {
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }else{
            
            [self.tableView.mj_footer endRefreshing];
            
        }
        
        self.comments = self.info.comments;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.title = @"全部评论";
    
    self.toolView = [[CommentToolView alloc]initWithFrame:CGRectMake(0, MSH-Height(48), MSW, Height(48))];
    
    self.toolView.delegate = self;
    
    [self.view addSubview:self.toolView];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-self.toolView.height) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width(65), 0, 0);
    
    self.tableView.separatorColor = UIColorFromRGB(0xe5e5e5);
    
    [self.tableView registerClass:[NewsCommentCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
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
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(30))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.tableHeaderView = tableHeader;
    
    self.countLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width(15), Height(10), Width(150), Height(18))];
    
    self.countLabel.textColor = UIColorFromRGB(0xbbbbbb);
    
    self.countLabel.font = AllFont(12);
    
    [tableHeader addSubview:self.countLabel];
    
    //获取通知中心
    NSNotificationCenter *notificationCenter = [NSNotificationCenter defaultCenter];
    //注册为被通知者
    [notificationCenter addObserver:self selector:@selector(keyChange:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.comments.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsComment *comment = self.comments[indexPath.row];
    
    return comment.cellHeight;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NewsCommentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NewsComment *comment = self.comments[indexPath.row];
    
    cell.content = comment.content;
    
    cell.iconURL = comment.user.iconURL;
    
    cell.name = comment.user.username;
    
    cell.time = comment.time;
    
    cell.replyName = comment.replyUser.username;
    
    cell.replyContent = comment.replyContent;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.comment) {
        
        self.comment = nil;
        
    }
    
    self.indexPath = indexPath;
    
    NewsComment *comment = self.comments[indexPath.row];
    
    self.toolView.textView.placeholder = [NSString stringWithFormat:@"回复%@：",comment.user.username];
    
    [self.toolView becomeFirstResponder];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width(148), Height(128), Width(80), Height(70))];
    
    emptyImg.image = [UIImage imageNamed:@"comment_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height(12), MSW, Height(18))];
    
    emptyLabel.text = @"还没人评论，快来抢沙发";
    
    emptyLabel.textColor = UIColorFromRGB(0x888888);
    
    emptyLabel.font = AllFont(12);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}


//键盘出来的时候调整tooView的位置
-(void) keyChange:(NSNotification *) notify
{
    
    NSDictionary *userInfo = notify.userInfo;
    
    // 动画的持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    
    // 键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    
    // 执行动画
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardF.origin.y >= MSH) {
            
            self.viewHeight = MSH;
            
            [self.tableView changeHeight:MSH-64-self.toolView.height];
            
            [self.toolView changeTop:self.tableView.bottom];
            
        }else
        {
            
            self.viewHeight = MSH-keyboardF.size.height;
            
            [self.tableView changeHeight:MSH-self.tableView.top-keyboardF.size.height-self.toolView.height];
            
            [self.toolView changeTop:self.tableView.bottom];
            
        }
        
    }];
    
}

-(void)sendText:(NSString *)text
{
    
    NewsCommentsInfo *info = [[NewsCommentsInfo alloc]init];
    
    NewsComment *comment;
    
    if (self.comment) {
        
        comment = self.comment;
        
    }else if (self.indexPath) {
        
        comment = self.comments[self.indexPath.row];
        
    }
    
    [info replyPress:self.press withText:text withComment:comment result:^(BOOL success, NSString *error) {
        
        MBProgressHUD *hud = [[MBProgressHUD alloc]initWithView:self.view];
        
        hud.mode = MBProgressHUDModeText;
        
        [self.view addSubview:hud];
        
        if (success) {
            
            self.indexPath = nil;
            
            self.comment = nil;
            
            self.toolView.textView.placeholder = @"";
            
            hud.label.text = @"回复成功";
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
            [self reloadData];
            
            self.toolView.textView.text = @"";
            
            [self.view endEditing:YES];
            
        }else{
            
            hud.label.text = error;
            
            [hud showAnimated:YES];
            
            [hud hideAnimated:YES afterDelay:1.5];
            
        }
        
    }];
    
}

-(void)textViewChangeHeight:(float)height
{
    
    [self.tableView changeHeight:self.viewHeight-height-64];
    
    [self.toolView changeTop:self.tableView.bottom];
    
}

-(void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    
    [self.view endEditing:YES];
    
}

-(void)viewWillDisappear:(BOOL)animated
{
    
    [super viewWillDisappear:animated];
    
    [self.view endEditing:YES];
    
}

@end
