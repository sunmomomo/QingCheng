//
//  ChangeGymController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChangeGymController.h"

#import "GymListInfo.h"

#import "ChangeGymCell.h"

#import "AppDelegate.h"

#import "ServicesInfo.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface ChangeGymController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)GymListInfo *info;

@property(nonatomic,strong)NSArray *gyms;

@end

@implementation ChangeGymController

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
        
        ServicesInfo *servicesInfo = [ServicesInfo shareInfo];
        
        [servicesInfo requestSuccess:^{
        
            self.tableView.dataSuccess = YES;
            
            self.gyms = [self.info getLocalGymsWithGyms:servicesInfo.services];
            
            [self.tableView reloadData];
            
        } Failure:^{
            
            self.tableView.dataSuccess = NO;
            
        }];
        
    }];
    
}

-(void)createUI
{
    
    self.leftType = MONaviLeftTypeClose;
    
    self.title = @"选择场馆";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[ChangeGymCell class] forCellReuseIdentifier:identifier];
    
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

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.gyms.count+1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChangeGymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.isChoosed = NO;
    
    if (indexPath.row == 0) {
        
        cell.isAll = YES;
        
        cell.title = @"全部场馆";
        
        if (!self.gym) {
            
            cell.isChoosed = YES;
            
        }
        
    }else
    {
        
        Gym *gym = self.gyms[indexPath.row-1];
        
        cell.isAll = NO;
        
        cell.title = gym.name;
        
        cell.subtitle = [NSString stringWithFormat:@"%@%@",gym.city.length?[gym.city stringByAppendingString:@"    "]:@"",gym.brand.name.length?gym.brand.name:@""];
        
        cell.imgUrl = gym.imgUrl;
        
        if (gym.shopId == self.gym.shopId && gym.brand.brandId == self.gym.brand.brandId) {
            
            cell.isChoosed = YES;
            
        }
        
        cell.havePower = YES;
        
        if (self.permission) {
            
            NSArray *gyms = @[gym];
            
            [[PermissionInfo sharedInfo]getPermissionWithGyms:gyms];
            
            Gym *currentGym = [gyms firstObject];
            
            if ([self.permission.readKey isEqualToString:[Permission userPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission userPermission].readKey] || [permission.readKey isEqualToString:[Permission personalUserPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            cell.havePower = NO;
                            
                        }
                        
                    }
                    
                }
                
            }else if ([self.permission.readKey isEqualToString:[Permission cardPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission cardPermission].readKey] || [permission.readKey isEqualToString:[Permission personalCardPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            cell.havePower = NO;
                            
                        }
                        
                    }
                    
                }
                
            }else if ([self.permission.readKey isEqualToString:[Permission sellReportPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission sellReportPermission].readKey] || [permission.readKey isEqualToString:[Permission personalSellReportPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            cell.havePower = NO;
                            
                        }
                        
                    }
                    
                }
                
            }else{
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:self.permission.readKey]) {
                        
                        if (!permission.readState) {
                            
                            cell.havePower = NO;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        self.gym = nil;
        
        if (self.changed) {
            self.changed(self.gym);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }else
    {
        
        Gym *gym = self.gyms[indexPath.row-1];
        
        self.gym = gym;
        
        if (self.permission) {
            
            NSArray *gyms = @[gym];
            
            [[PermissionInfo sharedInfo]getPermissionWithGyms:gyms];
            
            Gym *currentGym = [gyms firstObject];
            
            if ([self.permission.readKey isEqualToString:[Permission userPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission userPermission].readKey] || [permission.readKey isEqualToString:[Permission personalUserPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            
                            return;
                            
                        }
                        
                    }
                    
                }
                
            }else if ([self.permission.readKey isEqualToString:[Permission cardPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission cardPermission].readKey] || [permission.readKey isEqualToString:[Permission personalCardPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            
                            return;
                            
                        }
                        
                    }
                    
                }
                
            }else if ([self.permission.readKey isEqualToString:[Permission sellReportPermission].readKey]) {
                
                NSInteger noPermissionNum = 0;
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:[Permission sellReportPermission].readKey] || [permission.readKey isEqualToString:[Permission personalSellReportPermission].readKey]) {
                        
                        if (!permission.readState) {
                            
                            noPermissionNum ++;
                            
                        }
                        
                        if (noPermissionNum >= 2) {
                            
                            [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            
                            return;
                            
                        }
                        
                    }
                    
                }
                
            }else{
                
                for (Permission *permission in currentGym.permissions.permissions) {
                    
                    if ([permission.readKey isEqualToString:self.permission.readKey]) {
                        
                        if (!permission.readState) {
                            
                            [[[UIAlertView alloc]initWithTitle:@"抱歉，您无该场馆权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
                            
                            return;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
        if (self.changed) {
            self.changed(self.gym);
        }
        
        [self dismissViewControllerAnimated:YES completion:nil];
        
    }
    
}

-(void)naviLeftClick
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


@end
