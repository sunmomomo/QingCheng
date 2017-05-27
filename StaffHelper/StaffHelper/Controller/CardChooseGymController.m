//
//  CardChooseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/6/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardChooseGymController.h"

#import "GymListInfo.h"

#import "CardChooseStudentController.h"

#import "GymCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CardChooseGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation CardChooseGymController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [GymListInfo shareInfo];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.dataArray = [self.info getLocalGymsWithGyms:self.card.cardKind.gyms];
            
            self.dataArray = [[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.dataArray];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择会员所在场馆";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
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
    
    cell.havePower = gym.permissions.cardPermission.addState||gym.permissions.personalCardPermission.addState;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.dataArray[indexPath.row];
    
    if (gym.permissions.cardPermission.addState||gym.permissions.personalCardPermission.addState) {
        
        CardChooseStudentController *svc = [[CardChooseStudentController alloc]init];
        
        svc.gym = self.dataArray[indexPath.row];
        
        svc.isEdit = YES;
        
        svc.card = self.card;
        
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
