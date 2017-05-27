//
//  MeasureChooseGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MeasureChooseGymController.h"

#import "GymCell.h"

#import "MeasureEditController.h"

#import "GymListInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface MeasureChooseGymController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation MeasureChooseGymController

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
    
    GymListInfo *info = [GymListInfo shareInfo];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        NSMutableArray *array = [info.gyms mutableCopy];
        
        for (Gym *gym in info.gyms) {
            
            BOOL contains = NO;
            
            for (Gym *stuGym in self.student.gyms) {
                
                if (stuGym.shopId == gym.shopId) {
                    
                    contains = YES;
                    
                    break;
                    
                }
                
            }
            
            if (!contains) {
                
                [array removeObject:gym];
                
            }
            
        }
        
        self.dataArray = array;
        
        [[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.dataArray];
        
        [self.tableView reloadData];
        
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
    
    return self.dataArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.dataArray[indexPath.row];
    
    cell.title = gym.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.subtitle = gym.brand.name;
    
    cell.havePower = gym.permissions.userPermission.editState||gym.permissions.personalUserPermission.editState;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.dataArray[indexPath.row];
    
    if (gym.permissions.userPermission.editState||gym.permissions.personalUserPermission.editState) {
        
        MeasureEditController *svc = [[MeasureEditController alloc]init];
        
        svc.stu = self.student;
        
        svc.gym = gym;
        
        svc.isAdd = YES;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
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
