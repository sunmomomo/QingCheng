//
//  ReportController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ReportController.h"

#import "ReportTitleCell.h"

#import "RootController.h"

#import "AllReportController.h"

static NSString *identifier = @"Cell";

@interface ReportController ()<UITableViewDataSource,UITableViewDelegate,MONaviDelegate>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation ReportController

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
    
    self.title = @"数据报表";
        
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[ReportTitleCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReportTitleCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    switch (indexPath.row) {
        case 0:
            
            cell.title = @"课程报表";
            
            cell.img = [UIImage imageNamed:@"course_report"];
            
            break;
            
        case 1:
            
            cell.title = @"销售报表";
            
            cell.img = [UIImage imageNamed:@"sell_report"];
            
            break;
            
        case 2:
            
            cell.title = @"签到报表";
            
            cell.img = [UIImage imageNamed:@"checkin_report"];
            
            break;
            
        default:
            break;
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    
    return Height320(71);
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (indexPath.row == 0) {
        
        if (![PermissionInfo sharedInfo].permissions.courseReportPermission.readState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }
    
    if (indexPath.row == 1) {
        
        if (![PermissionInfo sharedInfo].permissions.sellReportPermission.readState && ![PermissionInfo sharedInfo].permissions.personalSellReportPermission.readState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }
    
    if (indexPath.row == 2) {
        
        if (![PermissionInfo sharedInfo].permissions.checkinReportPermission.readState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }
    
    AllReportController *svc = [[AllReportController alloc]init];
    
    svc.type = indexPath.row;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


@end
