//
//  YardListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YardListController.h"

#import "YardListInfo.h"

#import "YardCell.h"

#import "YardEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface YardListController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)YardListInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation YardListController

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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[YardListInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    self.info.requestFinish = ^(BOOL success){
        
        weakS.tableView.dataSuccess = success;
        
        [weakS.tableView.mj_header endRefreshing];
        
        [weakS.tableView reloadData];
        
    };
    
    [self.info requestWithGym:self.gym];
    
}

-(void)createUI
{
    
    self.title = @"场地";
    
    self.rightType = MONaviRightTypeAdd;
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[YardCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.allYards.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(62);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Yard *yard = self.info.allYards[indexPath.row];
    
    cell.yardCapacity = yard.capacity;
    
    cell.yardName = yard.name;
    
    cell.yardType = yard.type;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    YardEditController *svc = [[YardEditController alloc]init];
    
    svc.gym = self.gym;
    
    svc.yard = self.info.allYards[indexPath.row];
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].gym.permissions.studioPermission.addState) {
        
        YardEditController *svc = [[YardEditController alloc]init];
        
        svc.gym = self.gym;
        
        svc.yard = [[Yard alloc]init];
        
        svc.isAdd = YES;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(107), Width320(180), Height320(149))];
    
    emptyImg.image = [UIImage imageNamed:@"yard_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"暂无场地";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

@end
