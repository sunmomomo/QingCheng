//
//  IntegralListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "IntegralListController.h"

#import "MOTableView.h"

#import "IntegralCell.h"

#import "IntegralInfo.h"

#import "IntegralSettingInfo.h"

#import "IntegralSettingController.h"

#import "IntegralBasicSettingController.h"

#import "StudentDetailController.h"

static NSString *identifier = @"Cell";

@interface IntegralListController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)IntegralInfo *info;

@property(nonatomic,strong)NSMutableArray *users;

@property(nonatomic,assign)BOOL integralUsed;

@end

@implementation IntegralListController

-(void)viewDidLoad{
    
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

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    if ([PermissionInfo sharedInfo].permissions.integralRankPermission.readState) {
        
        IntegralSettingInfo *settingInfo = [[IntegralSettingInfo alloc]init];
        
        [settingInfo requestResult:^(BOOL success, NSString *error) {
            
            self.integralUsed = settingInfo.setting.used;
            
            if (self.integralUsed) {
                
                IntegralInfo *info = [[IntegralInfo alloc]init];
                
                [info requestListResult:^(BOOL success, NSString *error) {
                    
                    [self.tableView.mj_header endRefreshing];
                    
                    self.info = [info copy];
                    
                    self.tableView.dataSuccess = success;
                    
                    self.users = [self.info.users mutableCopy];
                    
                    [self.tableView reloadData];
                    
                }];
                
            }else{
                
                [self.tableView.mj_header endRefreshing];
                
                self.tableView.dataSuccess = success;
                
                self.users = [NSMutableArray array];
                
                [self.tableView reloadData];
                
            }
            
        }];
        
    }
    
}

-(void)updateData
{
    
    [self.info requestListResult:^(BOOL success, NSString *error) {
        
        if (self.info.users.count) {
            
            [self.tableView.mj_header endRefreshing];
            
            for (Student *user in self.info.users) {
                
                [self.users addObject:user];
                
            }
            
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"会员积分";
    
    self.rightType = MONaviRightTypeOtherSetting;
    
    if ([PermissionInfo sharedInfo].permissions.integralRankPermission.readState) {
        
        self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
        
        self.tableView.dataSource = self;
        
        self.tableView.delegate = self;
        
        [self.tableView registerClass:[IntegralCell class] forCellReuseIdentifier:identifier];
        
        self.tableView.tableFooterView = [UIView new];
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        
        [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
        
        [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
        
        header.stateLabel.textColor = [UIColor blackColor];
        
        self.tableView.mj_header = header;
        
        self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
        
        [self.view addSubview:self.tableView];
        
    }else{
        
        UIScrollView *noPremissionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
        
        noPremissionView.backgroundColor = UIColorFromRGB(0xffffff);
        
        UIImageView *noPremissionImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(117), Width320(168), Height320(132))];
        
        noPremissionImg.image = [UIImage imageNamed:@"no_premission"];
        
        [noPremissionView addSubview:noPremissionImg];
        
        UILabel *noPremissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, noPremissionImg.bottom+Height320(18), MSW, Height320(18))];
        
        noPremissionLabel.text = @"抱歉，您无权限查看该模块";
        
        noPremissionLabel.textAlignment = NSTextAlignmentCenter;
        
        noPremissionLabel.textColor = UIColorFromRGB(0x999999);
        
        noPremissionLabel.font = AllFont(14);
        
        [noPremissionView addSubview:noPremissionLabel];
        
        [self.view addSubview:noPremissionView];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.users.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(40);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    header.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    header.layer.borderWidth = OnePX;
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(20), Height320(12), Width320(11), Height320(16))];
    
    image.image = [UIImage imageNamed:@"integral_header"];
    
    [header addSubview:image];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(image.right+Width320(7), 0, Width320(100), Height320(40))];
    
    label.text = @"积分排行";
    
    label.textColor = UIColorFromRGB(0x666666);
    
    label.font = AllFont(13);
    
    [header addSubview:label];
    
    return header;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(64);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntegralCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Student *user = self.users[indexPath.row];
    
    cell.no = indexPath.row+1;
    
    cell.iconURL = user.avatar;
    
    cell.name = user.name;
    
    cell.sex = user.sex;
    
    cell.phone = user.phone;
    
    cell.integral = user.integral;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Student *user = self.users[indexPath.row];
    
    StudentDetailController *svc = [[StudentDetailController alloc]init];
    
    svc.student = user;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    view.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *image = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(41), Height320(70), Width320(238), Height320(190))];
    
    image.image = [UIImage imageNamed:@"user_integral_empty"];
    
    [view addSubview:image];
    
    UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(Width320(34), image.bottom+Height320(37), MSW-Width320(68), Height320(40))];
    
    button.backgroundColor = UIColorFromRGB(0x4CB28A);
    
    button.layer.cornerRadius = Width320(2);
    
    [button setTitle:@"开启会员积分" forState:UIControlStateNormal];
    
    [button setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    button.titleLabel.font = AllFont(16);
    
    [view addSubview:button];
    
    [button addTarget:self action:@selector(openIntegral:) forControlEvents:UIControlEventTouchUpInside];
    
    return view;
    
}

-(void)openIntegral:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.integralPermisson.readState) {
        
        button.userInteractionEnabled = NO;
        
        IntegralSettingInfo *info = [[IntegralSettingInfo alloc]init];
        
        [info changeUsed:YES result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                IntegralSettingInfo *basicInfo = [[IntegralSettingInfo alloc]init];
                
                [basicInfo requestBasicResult:^(BOOL success, NSString *error) {
                    
                    button.userInteractionEnabled = YES;
                    
                    if (basicInfo.setting.groupSetting.used || basicInfo.setting.privateSetting.used || basicInfo.setting.checkinSetting.used || basicInfo.setting.chargeUsed || basicInfo.setting.rechargeUsed) {
                        
                        IntegralSettingController *svc = [[IntegralSettingController alloc]init];
                        
                        [self.navigationController pushViewController:svc animated:YES];
                        
                    }else{
                        
                        IntegralSettingController *svc = [[IntegralSettingController alloc]init];
                        
                        [self.navigationController pushViewController:svc animated:NO];
                        
                        IntegralBasicSettingController *vc = [[IntegralBasicSettingController alloc]init];
                        
                        vc.setting = basicInfo.setting;
                        
                        vc.firstIn = YES;
                        
                        [self.navigationController pushViewController:vc animated:YES];
                        
                    }
                    
                    [self reloadData];
                    
                }];
                
            }else{
                
                button.userInteractionEnabled = YES;
                
            }
            
        }];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(void)naviRightClick
{
    
    if ([PermissionInfo sharedInfo].permissions.integralPermisson.readState) {
        
        IntegralSettingController *svc = [[IntegralSettingController alloc]init];
        
        [self.navigationController pushViewController:svc animated:NO];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
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
