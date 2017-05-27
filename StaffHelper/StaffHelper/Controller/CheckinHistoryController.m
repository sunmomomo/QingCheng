//
//  CheckinHistoryController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CheckinHistoryController.h"

#import "CheckinHistoryCell.h"

#import "CheckinHistoryInfo.h"

#import "CheckinDetailController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CheckinHistoryController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CheckinHistoryInfo *info;

@end

@implementation CheckinHistoryController

- (void)viewDidLoad {
    
    [super viewDidLoad];

    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[CheckinHistoryInfo alloc]init];
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"签到记录";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(76), 0, 0);
    
    self.tableView.tableFooterView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(90))];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(Width320(76), 0, MSW-Width320(76), OnePX)];
    
    line.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [self.tableView.tableFooterView addSubview:line];
    
    UILabel *bottomLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(14), MSW, Height320(42))];
    
    bottomLabel.text = @"只能查看3小时内的签到/签出记录\n更多信息请查看签到/签出报表";
    
    bottomLabel.textColor = UIColorFromRGB(0x999999);
    
    bottomLabel.textAlignment = NSTextAlignmentCenter;
    
    bottomLabel.numberOfLines = 0;
    
    bottomLabel.font = AllFont(11);
    
    [self.tableView.tableFooterView addSubview:bottomLabel];
    
    [self.tableView registerClass:[CheckinHistoryCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.checkins.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CheckinHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    Checkin *checkin = self.info.checkins[indexPath.row];
    
    cell.name = checkin.student.name;
    
    cell.sex = checkin.student.sex;
    
    cell.imageURL = checkin.student.photo;
    
    cell.haveCanceled = checkin.canceled;
    
    cell.checkinTime = checkin.createTime;
    
    cell.checkoutTime = checkin.checkoutTime;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(82.5);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Checkin *checkin = self.info.checkins[indexPath.row];
    
    CheckinDetailController *svc = [[CheckinDetailController alloc]init];
    
    svc.checkin = checkin;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
