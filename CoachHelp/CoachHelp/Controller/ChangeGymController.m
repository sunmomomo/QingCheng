//
//  ChangeGymController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChangeGymController.h"

#import "MyGymInfo.h"

#import "ChangeGymCell.h"

#import "AppDelegate.h"

static NSString *identifier = @"Cell";

@interface ChangeGymController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)MyGymInfo *info;

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
    
    MyGymInfo *info = [[MyGymInfo alloc]init];
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(MyGymInfo*)weakInfo = info;
    
    info.request = ^(BOOL success){
        
        if (success) {
            
            weakS.info = weakInfo;
            
            [weakS.tableView reloadData];
            
        }
        
    };
    
    [info requestData];
    
}

-(void)createUI
{
    
    self.leftType = MONaviLeftTypeClose;
    
    self.title = @"选择健身房";
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
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
    
    return self.info.gyms.count+1;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChangeGymCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.isChoosed = NO;
    
    if (indexPath.row == 0) {
        
        cell.isAll = YES;
        
        cell.title = self.allTitle;
        
        if (!self.gym) {
            
            cell.isChoosed = YES;
            
        }
        
    }else
    {
        
        Gym *gym = self.info.gyms[indexPath.row-1];
        
        cell.isAll = NO;
        
        cell.title = gym.name;
        
        cell.subtitle = [NSString stringWithFormat:@"%@%@",gym.city.length?[gym.city stringByAppendingString:@"    "]:@"",gym.brandName.length?gym.brandName:@""];
        
        cell.imgUrl = gym.imgUrl;
        
        if (gym.gymId == self.gym.gymId && [gym.type isEqualToString:self.gym.type]) {
            
            cell.isChoosed = YES;
            
        }
        
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
    
    if (indexPath.row == 0) {
        
        self.gym = nil;
        
    }else
    {
        
        Gym *gym = self.info.gyms[indexPath.row-1];
        
        self.gym = gym;
        
    }
    
    if (self.changed) {
        self.changed(self.gym);
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    [self.navigationController popViewControllerAnimated:YES];
    
}


@end
