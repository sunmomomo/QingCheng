//
//  StudentChooseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/17.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentChooseGymController.h"

#import "GymListInfo.h"

#import "GymCell.h"

#import "StudentEditController.h"

#import "StudentSellerController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface StudentChooseGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)NSMutableArray *allGyms;

@end

@implementation StudentChooseGymController


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
    
    self.allGyms = [self.info.gyms mutableCopy];
    
    for (Gym *tempGym in self.gyms) {
        
        Gym *sameGym = [tempGym containInArray:self.info.gyms];
        
        if (!sameGym) {
            
            [self.allGyms addObject:tempGym];
            
        }
        
    }
    
}

-(void)createUI
{
    
    self.title = @"选择所属场馆";
    
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
    
    return self.allGyms.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.allGyms[indexPath.row];
    
    cell.title = gym.name;
    
    cell.subtitle = gym.brand.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.havePower = gym.permissions.userPermission.addState || gym.permissions.personalUserPermission.addState;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.allGyms[indexPath.row];
    
    if (self.student) {
        
        StudentSellerController *svc = [[StudentSellerController alloc]init];
        
        svc.gym = gym;
        
        svc.student = self.student;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        if (gym.permissions.userPermission.addState||gym.permissions.personalUserPermission.addState) {
            
            StudentEditController *svc = [[StudentEditController alloc]init];
            
            svc.gym = gym;
            
            svc.isAdd = YES;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
            
        }
        
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
