//
//  MeasuresListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "MeasuresListController.h"

#import "MeasuresListInfo.h"

#import "MeasureDetailController.h"

#import "MeasureEditController.h"

#import "MeasureChooseGymController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface MeasuresListController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MeasuresListInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@end

@implementation MeasuresListController

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
    
    MeasuresListInfo *info = [[MeasuresListInfo alloc]init];
    
    [info requestWithStuId:self.student.stuId result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        self.info = info;
        
        [self.tableView.mj_header endRefreshing];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    [self createData];
    
}

-(void)createUI
{
    
    self.title = @"体测数据";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), self.tableView.bottom+Height320(8), MSW-Width320(24), Height320(40))];
    
    addButton.backgroundColor = kMainColor;
    
    addButton.layer.cornerRadius = 2;
    
    [addButton setTitle:@"+ 添加体测数据" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)add:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState || [PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
        
        if (gym) {
            
            MeasureEditController *svc = [[MeasureEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.stu = self.student;
            
            svc.gym = gym;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else if(self.student.gyms.count == 1)
        {
            
            MeasureEditController *svc = [[MeasureEditController alloc]init];
            
            svc.isAdd = YES;
            
            svc.stu = self.student;
            
            svc.gym = [self.student.gyms firstObject];
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }else
        {
            
            MeasureChooseGymController *svc = [[MeasureChooseGymController alloc]init];
            
            svc.student = self.student;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.measures.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Measure *measure = self.info.measures[indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@体测数据",measure.date];
    
    cell.textLabel.textColor = UIColorFromRGB(0x212121);
    
    cell.textLabel.font = AllFont(12);
    
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MeasureDetailController *svc = [[MeasureDetailController alloc]init];
    
    svc.measure = self.info.measures[indexPath.row];
    
    svc.measure.student = self.student;
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
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
