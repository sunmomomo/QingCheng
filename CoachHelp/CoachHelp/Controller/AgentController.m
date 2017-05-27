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

@interface AgentController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation AgentController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
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
    
    cell.subtitle = gym.brandName;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.agentInfo.gyms[indexPath.row];
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    svc.url = gym.url;
    
    __weak typeof(self)weakS = self;
    
    svc.completeAction = ^{
       
        [weakS.navigationController popViewControllerAnimated:YES];
        
        if (weakS.agentFinish) {
            
            weakS.agentFinish();
            
        }
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
