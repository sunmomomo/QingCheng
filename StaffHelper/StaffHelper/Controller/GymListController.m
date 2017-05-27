//
//  GymListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GymListController.h"

#import "GymDetailController.h"

#import "MOTableView.h"

#import "GymCell.h"

#import "ServicesInfo.h"

#import "BrandListController.h"

#import "MessageController.h"

static NSString *identifier = @"Cell";

@interface GymListController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)ServicesInfo *gymInfo;

@end

@implementation GymListController

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.tabTitle = @"我的健身房";
        
        self.unselectImg = [UIImage imageNamed:@"gym_unselect"];
        
        self.selectedImg = [UIImage imageNamed:@"gym_selected"];
        
        self.leftType = MONaviLeftTypeNO;
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    self.brand = ((AppDelegate*)[UIApplication sharedApplication].delegate).brand;
    
    if ([self.tableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.tableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.tableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.tableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}

-(void)viewDidAppear:(BOOL)animated
{
    
    [super viewDidAppear:animated];
    
    if (self.brand) {
        
        ((AppDelegate*)[UIApplication sharedApplication].delegate).brand = self.brand;
        
    }
    
    if (!AppMessage.gym) {
        
        ((AppDelegate*)[UIApplication sharedApplication].delegate).gym = nil;
        
    }
    
}

+(GymListController *)sharedController
{
    
    static GymListController *gymVC;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        gymVC = [[self alloc]init];
        
    });
    
    return gymVC;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    ServicesInfo *gymInfo = [ServicesInfo shareInfo];
    
    [gymInfo requestSuccess:^{
        
        self.tableView.dataSuccess = YES;
        
        self.gymInfo = gymInfo;
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^{
        
        self.tableView.dataSuccess = NO;
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)reloadData
{
    
    if (!self.gymInfo) {
        
        self.gymInfo = [ServicesInfo shareInfo];
        
    }
    
    [self.gymInfo requestSuccess:^{
        
        self.tableView.dataSuccess = YES;
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    } Failure:^{
        
        self.tableView.dataSuccess = NO;
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeRing;
    
    self.rightNum = self.rightNum;
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-49) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(54))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(117), Height320(18), Width320(18), Height320(18))];
    
    addImg.image = [UIImage imageNamed:@"card_recharge"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(addImg.right+Width320(6), 0, Width320(150), Height320(54))];
    
    addLabel.text = @"添加场馆";
    
    addLabel.textColor = kMainColor;
    
    addLabel.font = AllFont(12);
    
    [addButton addSubview:addLabel];
    
    UIView *topLine = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, OnePX)];
    
    topLine.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [addButton addSubview:topLine];
    
    UIView *bottomLine = [[UIView alloc]initWithFrame:CGRectMake(0, addButton.height-OnePX, MSW, OnePX)];
    
    bottomLine.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [addButton addSubview:bottomLine];
    
    self.tableView.tableFooterView = addButton;
    
    self.tableView.tableFooterView.hidden = YES;
    
    [addButton addTarget:self action:@selector(addGym) forControlEvents:UIControlEventTouchUpInside];
    
    [self.tableView registerClass:[GymCell class] forCellReuseIdentifier:identifier];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return (long)Height320(72);
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.gymInfo.services.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.gymInfo.services[indexPath.row];
    
    cell.title = [NSString stringWithFormat:@"%@ | %@",gym.name,gym.brand.name];
    
    cell.subtitle = gym.city.length?[NSString stringWithFormat:@"%@  %@",gym.city,gym.contact]:gym.contact;
    
    cell.imageUrl = gym.imgUrl;
    
    return cell;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymDetailController *svc = [[GymDetailController alloc]init];
    
    Gym *gym = self.gymInfo.services[indexPath.row];
    
    self.brand = ((AppDelegate*)[UIApplication sharedApplication].delegate).brand;
    
    svc.gym = gym;
    
    ((AppDelegate*)[UIApplication sharedApplication].delegate).brand = ((Gym*)self.gymInfo.services[indexPath.row]).brand;
    
    ((AppDelegate*)[UIApplication sharedApplication].delegate).gym = gym;
    
    PermissionInfo *permissionInfo = [PermissionInfo sharedInfo];
    
    [permissionInfo requestWithGym:AppGym result:^(BOOL success, NSString *error) {
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(void)addGym
{
    
    BrandListController *svc = [[BrandListController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)naviRightClick
{
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
