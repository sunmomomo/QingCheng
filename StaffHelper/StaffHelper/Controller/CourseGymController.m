//
//  CourseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseGymController.h"

#import "GymListInfo.h"

#import "GymSuitCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CourseGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)NSMutableArray *allGyms;

@end

@implementation CourseGymController

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
    
    self.gyms = [self.course.gyms mutableCopy];
    
    self.info = [[GymListInfo alloc]init];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self getShowData];
        
        self.allGyms = [[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.allGyms] mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)getShowData
{
    
    self.allGyms = [self.info.gyms mutableCopy];
    
    for (Gym *tempGym in self.course.gyms) {
        
        Gym *sameGym = [tempGym containInArray:self.info.gyms];
        
        if (!sameGym) {
            
            [self.allGyms addObject:tempGym];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.title = @"选择适用场馆";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.rightTitle = @"确定";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GymSuitCell class] forCellReuseIdentifier:identifier];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(36))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIImageView *hintImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(16), Height320(13), Width320(14), Height320(14))];
    
    hintImg.image = [UIImage imageNamed:@"hint_circle"];
    
    [tableHeader addSubview:hintImg];
    
    UILabel *hintLabel = [[UILabel alloc]initWithFrame:CGRectMake(hintImg.right+Width320(8), 0, MSW-Width320(24)-hintImg.right, Height320(36))];
    
    hintLabel.text = @"您只能对具有管理员权限的场馆进行操作";
    
    hintLabel.textColor = UIColorFromRGB(0x999999);
    
    hintLabel.font = AllFont(12);
    
    [tableHeader addSubview:hintLabel];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.allGyms.count;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymSuitCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.allGyms[indexPath.row];
    
    cell.isChoosed = NO;
    
    for (Gym *tempGym in self.gyms) {
        
        if ((tempGym.gymId == gym.gymId && [tempGym.type isEqualToString:gym.type])||tempGym.shopId == gym.shopId) {
            
            cell.isChoosed = YES;
            
        }
        
    }
    
    cell.title = gym.name;
    
    cell.imgUrl = gym.imgUrl;
    
    cell.subtitle = gym.brand.name;
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [Permission groupPermission];
        
    }else{
        
        permission = [Permission privatePermission];
        
    }
    
    cell.havePower = self.isAdd?[[PermissionInfo sharedInfo]getPermissionStateWithGyms:@[gym] andPermission:permission andType:PermissionTypeAdd]:[[PermissionInfo sharedInfo]getPermissionStateWithGyms:@[gym] andPermission:permission andType:PermissionTypeEdit];
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    Gym *gym = self.allGyms[indexPath.row];
    
    Permission *permission;
    
    if (self.course.type == CourseTypeGroup) {
        
        permission = [Permission groupPermission];
        
    }else{
        
        permission = [Permission privatePermission];
        
    }
    
    if (self.isAdd?![[PermissionInfo sharedInfo]getPermissionStateWithGyms:@[gym] andPermission:permission andType:PermissionTypeAdd]:![[PermissionInfo sharedInfo]getPermissionStateWithGyms:@[gym] andPermission:permission andType:PermissionTypeEdit]) {
        
        [[[UIAlertView alloc]initWithTitle:@"无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }else{
        
        BOOL contains = NO;
        
        for (Gym *tempGym in self.gyms) {
            
            if ((tempGym.gymId == gym.gymId && [tempGym.type isEqualToString:gym.type])||tempGym.shopId == gym.shopId) {
                
                contains = YES;
                
                [self.gyms removeObject:tempGym];
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [self.gyms addObject:gym];
            
        }
        
        [self.tableView reloadData];
        
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

-(void)naviRightClick
{
    
    if (!self.gyms.count) {
        
        [[[UIAlertView alloc]initWithTitle:@"至少选择一家场馆" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }else{
        
        self.course.gyms = [self.gyms mutableCopy];
        
        if (self.chooseFinish) {
            
            self.chooseFinish();
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}


@end
