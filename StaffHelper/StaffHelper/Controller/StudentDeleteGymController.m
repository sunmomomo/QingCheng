//
//  StudentDeleteGymController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentDeleteGymController.h"

#import "GymCell.h"

#import "StudentDetailInfo.h"

#import "GymListInfo.h"

#import "MOTableView.h"

#import "YFStudentListVC.h"

static NSString *identifier = @"Cell";

@interface StudentDeleteGymController ()<MOTableViewDatasource,UITableViewDelegate,UIAlertViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)Gym *deleteGym;

@property(nonatomic,strong)NSArray *dataArray;

@property(nonatomic,strong)MBProgressHUD *hud;

@property(nonatomic,strong)GymListInfo *info;

@end

@implementation StudentDeleteGymController

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
    
    self.info = [GymListInfo shareInfo];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.dataArray = [self.info getLocalGymsWithGyms:self.student.gyms];
            
            self.dataArray = [[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.dataArray];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择场馆";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[GymCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
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
    
    cell.subtitle = gym.brand.name;
    
    cell.imageUrl = gym.imgUrl;
    
    cell.havePower = gym.permissions.userPermission.deleteState || gym.permissions.personalUserPermission.deleteState;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.dataArray[indexPath.row];
    
    if (gym.permissions.userPermission.deleteState || gym.permissions.personalUserPermission.deleteState) {
        
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"是否确认删除会员" message:@"该会员的上课记录、会员卡、跟进记录等均会被删除" delegate:self cancelButtonTitle:@"否" otherButtonTitles:@"是",nil];
        
        [alert show];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:@"无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"知道了" otherButtonTitles:nil]show];
        
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

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex == 1) {
        
        StudentDetailInfo *info = [[StudentDetailInfo alloc]init];
        
        self.hud.mode = MBProgressHUDModeIndeterminate;
        
        self.hud.label.text = @"";
        
        [self.hud showAnimated:YES];
        
        self.rightButtonEnable = NO;
        
        [info deleteStudent:self.student withGyms:@[self.deleteGym] result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = @"删除成功";
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    
                    for (UIViewController *vc in self.navigationController.viewControllers) {
                        
                        if ([vc isKindOfClass:[YFStudentListVC class]]) {
                            
                            [[NSNotificationCenter defaultCenter] postNotificationName:kPostDeleteMemberIdtifierYF object:nil];
                            
                            [self.navigationController popToViewController:vc animated:YES];
                            
                        }
                        
                    }
                    
                });
                
            }else{
                
                self.rightButtonEnable = YES;
                
                self.hud.mode = MBProgressHUDModeText;
                
                self.hud.label.text = error;
                
                self.hud.label.numberOfLines = 0;
                
                [self.hud hideAnimated:YES afterDelay:1.5];
                
            }
            
        }];
        
    }
    
}


@end
