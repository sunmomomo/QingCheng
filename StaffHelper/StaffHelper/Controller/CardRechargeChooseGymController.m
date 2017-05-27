//
//  CardRechargeChooseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardRechargeChooseGymController.h"

#import "GymCell.h"

#import "CardRechargeChooseSpecController.h"

static NSString *identifier = @"Cell";

@interface CardRechargeChooseGymController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation CardRechargeChooseGymController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
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
    
    self.dataArray = [self.info getLocalGymsWithGyms:self.card.cardKind.gyms];
    
    self.dataArray = [[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.dataArray];
    
}

-(void)createUI
{
    
    self.title = @"选择充值场馆";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GymCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.dataArray[indexPath.row];
    
    cell.title = gym.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.subtitle = gym.brand.name;
    
    cell.havePower = gym.permissions.cardPermission.addState;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.dataArray[indexPath.row];
    
    if (gym.permissions.cardPermission.addState) {
        
        CardRechargeChooseSpecController *svc = [[CardRechargeChooseSpecController alloc]init];
        
        svc.card = self.card;
        
        svc.gym = self.dataArray[indexPath.row];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"无该场馆开卡权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
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
