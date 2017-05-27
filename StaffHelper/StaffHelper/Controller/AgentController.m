//
//  AgentCourseController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AgentController.h"

#import "AgentCell.h"

#import "WebViewController.h"

static NSString *identifier = @"Cell";

@interface AgentController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource,MONaviDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AgentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    if (self.agentInfo.type != AgentTypeRest) {
        
        self.agentInfo.gyms = [[[PermissionInfo sharedInfo]getPermissionNotIgnoredWithGyms:self.agentInfo.gyms]mutableCopy];
        
    }
    
}

-(void)createUI
{
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[AgentCell class] forCellReuseIdentifier:identifier];
            
    self.tableView.separatorInset = UIEdgeInsetsZero;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.agentInfo.gyms.count;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    AgentCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.agentInfo.gyms[indexPath.row];
    
    cell.title = gym.name;
    
    cell.imgUrl = gym.imgUrl;
    
    cell.subtitle = gym.brand.name;
    
    cell.havePower = gym.permissions.courseOrderPermission.addState;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    Gym *gym = self.agentInfo.gyms[indexPath.row];
    
    if (self.agentInfo.type == AgentTypeGroup) {
        
        if(!gym.permissions.courseOrderPermission.addState){
            
            [[[UIAlertView alloc]initWithTitle:@"没有该场馆团课代约权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }else if (self.agentInfo.type == AgentTypePrivate){
        
        if(!gym.permissions.privateOrderPermission.addState){
            
            [[[UIAlertView alloc]initWithTitle:@"没有该场馆私教代约权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
            return;
            
        }
        
    }
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    svc.url = gym.url;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(72);
    
}

- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath

{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
}


@end
