//
//  AllReportController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/12.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "AllReportController.h"

#import "ReportInfoCell.h"

#import "AllReportInfo.h"

#import "CustomReportController.h"

#import "ReportShowController.h"

#import "ChangeGymController.h"

#import "AppDelegate.h"

static NSString *identifier = @"Cell";

static NSString *titleIdentifier = @"Title";

@interface AllReportController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)AllReportInfo *reportInfo;

@property(nonatomic,strong)ReportInfo *showInfo;

@end

@implementation AllReportController

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
    
    self.reportInfo = [[AllReportInfo alloc]initWithType:self.type];
    
    self.showInfo = self.reportInfo.totalReportInfo;
    
    [self.reportInfo requestInfoWithGym:self.gym result:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.showInfo = self.reportInfo.totalReportInfo;
            
            [self.tableView reloadData];
            
        }
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}


-(void)createUI
{
    
    if (self.type == ReportInfoTypeSchedule) {
        
        self.title = @"课程报表";
        
    }else if (self.type == ReportInfoTypeSell){
        
        self.title = @"销售报表";
        
    }else{
        
        self.title = @"签到报表";
        
    }
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tag = 101;
    
    [self.tableView registerClass:[ReportInfoCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 4;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
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

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReportInfoCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if(indexPath.row == 0) {
        
        cell.imgText = @"今";
        
        cell.title = [NSString stringWithFormat:@"今日(%@)",self.showInfo.todayReport.fromDate];
        
        if (self.type == ReportInfoTypeSchedule) {
            
            cell.subtitle = [NSString stringWithFormat:@"%ld节课程，服务%ld人次",(long)self.showInfo.todayReport.courseNum,(long)self.showInfo.todayReport.serviceNum];
            
        }else if(self.type == ReportInfoTypeSell)
        {
            
            NSString *price = @"";
            
            if ([[NSString stringWithFormat:@"%.1f",self.showInfo.todayReport.cost] rangeOfString:@".0"].length) {
                
                price = [NSString stringWithFormat:@"%ld",(long)self.showInfo.todayReport.cost];
                
            }else{
                
                price = [NSString stringWithFormat:@"%.1f",self.showInfo.todayReport.cost];
                
            }
            
            cell.subtitle = [NSString stringWithFormat:@"销售额%@元",price];
            
        }else{
            
            cell.subtitle = [NSString stringWithFormat:@"签到%ld人次",(long)self.showInfo.todayReport.checkinNum];
            
        }
        
    }else if (indexPath.row == 1){
        
        cell.imgText = @"周";
        
        cell.title = [NSString stringWithFormat:@"本周(%@至%@)",self.showInfo.weekReport.fromDate ,self.showInfo.weekReport.toDate];
        
        if (self.type == ReportInfoTypeSchedule) {
            
            cell.subtitle = [NSString stringWithFormat:@"%ld节课程，服务%ld人次",(long)self.showInfo.weekReport.courseNum,(long)self.showInfo.weekReport.serviceNum];
            
        }else if(self.type == ReportInfoTypeSell)
        {
            
            NSString *price = @"";
            
            if ([[NSString stringWithFormat:@"%.1f",self.showInfo.weekReport.cost] rangeOfString:@".0"].length) {
                
                price = [NSString stringWithFormat:@"%ld",(long)self.showInfo.weekReport.cost];
                
            }else{
                
                price = [NSString stringWithFormat:@"%.1f",self.showInfo.weekReport.cost];
                
            }
            
            cell.subtitle = [NSString stringWithFormat:@"销售额%@元",price];
            
        }else{
            
            cell.subtitle = [NSString stringWithFormat:@"签到%ld人次",(long)self.showInfo.weekReport.checkinNum];
            
        }
        
    }else if (indexPath.row == 2){
        
        cell.imgText = @"月";
        
        cell.title = [NSString stringWithFormat:@"本月(%@至%@)",self.showInfo.monthReport.fromDate,self.showInfo.monthReport.toDate];
        
        if (self.type == ReportInfoTypeSchedule) {
            
            cell.subtitle = [NSString stringWithFormat:@"%ld节课程，服务%ld人次",(long)self.showInfo.monthReport.courseNum,(long)self.showInfo.monthReport.serviceNum];
            
        }else if(self.type == ReportInfoTypeSell)
        {
            
            NSString *price = @"";
            
            if ([[NSString stringWithFormat:@"%.1f",self.showInfo.monthReport.cost] rangeOfString:@".0"].length) {
                
                price = [NSString stringWithFormat:@"%ld",(long)self.showInfo.monthReport.cost];
                
            }else{
                
                price = [NSString stringWithFormat:@"%.1f",self.showInfo.monthReport.cost];
                
            }
            
            cell.subtitle = [NSString stringWithFormat:@"销售额%@元",price];
            
        }else{
            
            cell.subtitle = [NSString stringWithFormat:@"签到%ld人次",(long)self.showInfo.monthReport.checkinNum];
            
        }
        
    }else if (indexPath.row == 3){
        
        cell.img = [UIImage imageNamed:@"custom"];
        
        cell.title = @"自定义报表";
        
        cell.subtitle = @"根据自定义条件生成报表";
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 101) {
        
        if (indexPath.row == 3) {
            
            CustomReportController *svc = [[CustomReportController alloc]init];
            
            svc.gym = self.gym;
            
            svc.type = self.type;
            
            svc.filter = [[ReportFilter alloc]init];
            
            svc.filter.infoType = self.type;
            
            svc.filter.isCustom = YES;
            
            __weak typeof(self)weakS = self;
            
            svc.customFinish = ^(ReportFilter *filter){
                
                ReportShowController *svc = [[ReportShowController alloc]init];
                
                svc.type = ReportTypeOther;
                
                svc.isGym = self.isGym;
                
                if (self.isGym) {
                    
                    svc.gym = self.gym;
                    
                }
                
                svc.filter = filter;
                
                svc.minDate = filter.startDate;
                
                svc.maxDate = filter.endDate;
                
                [weakS.navigationController pushViewController:svc animated:YES];
                
            };
            
            [self presentViewController:svc animated:YES completion:^{
                
            }];
            
        }else
        {
            
            ReportShowController *svc = [[ReportShowController alloc]init];
            
            svc.isGym = self.isGym;
            
            if (self.isGym) {
                
                svc.gym = self.gym;
                
            }
            
            if (indexPath.row == 1) {
                
                svc.type = ReportTypeWeek;
                
                ReportFilter *filter = [[ReportFilter alloc]init];
                
                filter.startDate = self.showInfo.weekReport.fromDate;
                
                filter.endDate = self.showInfo.weekReport.toDate;
                
                filter.infoType = self.type;
                
                svc.filter = filter;
                
                svc.minDate = filter.startDate;
                
                svc.maxDate = filter.endDate;
                
            }else  if (indexPath.row == 0) {
                
                svc.type = ReportTypeDay;
                
                ReportFilter *filter = [[ReportFilter alloc]init];
                
                filter.startDate = self.showInfo.todayReport.fromDate;
                
                filter.endDate = self.showInfo.todayReport.toDate;
                
                filter.infoType = self.type;
                
                svc.filter = filter;
                
                svc.minDate = filter.startDate;
                
                svc.maxDate = filter.endDate;
                
            }else{
                
                svc.type = ReportTypeMonth;
                
                ReportFilter *filter = [[ReportFilter alloc]init];
                
                filter.startDate = self.showInfo.monthReport.fromDate;
                
                filter.endDate = self.showInfo.monthReport.toDate;
                
                filter.infoType = self.type;
                
                svc.filter = filter;
                
                svc.minDate = filter.startDate;
                
                svc.maxDate = filter.endDate;
                
            }
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
