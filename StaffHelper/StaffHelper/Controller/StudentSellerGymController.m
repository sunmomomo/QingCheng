//
//  StudentSellerGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentSellerGymController.h"

#import "GymCell.h"

#import "StudentSellerController.h"

#import "StudentCoachController.h"

#import "GymListInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface StudentSellerGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)NSMutableArray *allGyms;

@end

@implementation StudentSellerGymController

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
    
    self.info = [GymListInfo shareInfo];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self getShowData];
        
        self.allGyms = [[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.allGyms]mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)getShowData
{
    
    self.allGyms = [NSMutableArray array];
    
    for (Gym *tempGym in self.student.gyms) {
        
        Gym *sameGym = [tempGym containInArray:self.info.gyms];
        
        if (sameGym) {
            
            [self.allGyms addObject:sameGym];
            
        }
        
    }
    
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
    
    return self.allGyms.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.allGyms[indexPath.row];
    
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
    
    Gym *gym = self.allGyms[indexPath.row];
    
    if (gym.permissions.userPermission.editState) {
        
        if (self.isCoach) {
            
            StudentCoachController *svc = [[StudentCoachController alloc]init];
            
            svc.gym = gym;
            
            svc.isEdit = YES;
            
            svc.student = self.student;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            StudentSellerController *svc = [[StudentSellerController alloc]init];
            
            svc.gym = gym;
            
            svc.isEdit = YES;
            
            svc.student = self.student;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
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
