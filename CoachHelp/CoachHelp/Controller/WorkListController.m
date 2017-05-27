//
//  WorkListController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/26.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "WorkListController.h"

#import "WorkListCell.h"

#import "WorksInfo.h"

#import "WorkDetailController.h"

#import "WorkEditController.h"

#import "ChooseGymController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface WorkListController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)WorksInfo *worksInfo;

@end

@implementation WorkListController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self createData];
    
    [self createUI];
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    WorksInfo *info = [[WorksInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(WorksInfo*)weakInfo = info;
    
    info.request = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        if (success) {
            
            weakS.worksInfo = weakInfo;
            
        }
        
        [weakS.tableView reloadData];
        
        [weakS.tableView.mj_header endRefreshing];
        
    };
    
    [info updataData];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeAdd;
    
    self.title = @"工作经历设置";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.tableView registerClass:[WorkListCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.worksInfo.works.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return  Height320(72);
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-20-Height320(49))];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
    
    emptyImg.image = [UIImage imageNamed:@"workempty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(50, emptyImg.bottom+Height320(19.5), MSW-100, Height320(39))];
    
    emptyLabel.text = @"您还没有添加任何工作经历\n请在设置页面中添加";
    
    emptyLabel.numberOfLines = 2;
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.font = STFont(16);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:emptyLabel];
    
    return view;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkListCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Work *work = self.worksInfo.works[indexPath.row];
    
    cell.title = work.title;
    
    cell.city = work.gym.city;
    
    cell.icon = work.gym.imgUrl;
    
    cell.isCertificated = work.isVerified;
    
    cell.time = [NSString stringWithFormat:@"%@至%@",work.startTime,[work.endTime isEqualToString:@"3000-01-01"]?@"今":work.endTime];
    
    cell.isHide = work.isHide;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)naviRightClick
{
    
    ChooseGymController *svc = [[ChooseGymController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.title = @"添加工作经历";
    
    svc.addSuccess = ^(Gym *gym){
        
        WorkEditController *editVC = [[WorkEditController alloc]init];
        
        editVC.isAdd = YES;
        
        editVC.work.gym = gym;
        
        editVC.editFinish = ^(Work *work){
            
            [weakS createData];
            
        };
        
        [weakS.navigationController popViewControllerAnimated:NO];
        
        [weakS.navigationController pushViewController:editVC animated:YES];
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WorkDetailController *svc= [[WorkDetailController alloc]init];
    
    svc.work = self.worksInfo.works[indexPath.row];
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
