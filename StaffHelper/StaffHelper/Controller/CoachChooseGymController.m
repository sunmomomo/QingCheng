//
//  CoachChooseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/4/25.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "CoachChooseGymController.h"

#import "GymListInfo.h"

#import "GymCell.h"

#import "ServicesInfo.h"

#import "CoachDistributeListController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoachChooseGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *gymArray;

@end

@implementation CoachChooseGymController

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
    
    GymListInfo *info = [[GymListInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        ServicesInfo *servicesInfo = [ServicesInfo shareInfo];
        
        [servicesInfo requestSuccess:^{
            
            self.tableView.dataSuccess = YES;
            
            self.gymArray = [info getLocalGymsWithGyms:servicesInfo.services];
            
            [[PermissionInfo sharedInfo]getPermissionWithGyms:self.gymArray];
            
            [self.tableView reloadData];
            
        } Failure:^{
            
            self.tableView.dataSuccess = NO;
            
        }];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择场馆";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GymCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.gymArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.gymArray[indexPath.row];
    
    cell.title = gym.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.subtitle = gym.brand.name;
    
    cell.havePower = gym.permissions.userPermission.editState;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Gym *gym = self.gymArray[indexPath.row];
    
    if (gym.permissions.userPermission.editState) {
        
        [[PermissionInfo sharedInfo]requestWithGym:gym result:^(BOOL success, NSString *error) {
            
            CoachDistributeListController *svc = [[CoachDistributeListController alloc]init];
            
            svc.gym = gym;
            
            AppGym = gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }];
        
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
