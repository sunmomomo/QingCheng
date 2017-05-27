//
//  CourseListController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseListController.h"

#import "CourseCell.h"

#import "CourseListInfo.h"

#import "CourseEditController.h"

#import "MOTableView.h"

#import "CourseDetailController.h"

#import "ChooseView.h"

static NSString *identifier = @"Cell";

@interface CourseListController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CourseListInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CourseListController

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
    
    __weak typeof(self)weakS = self;
    
    CourseListInfo *info = [[CourseListInfo alloc]init];
    
    __weak typeof(CourseListInfo *)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        [weakS.tableView.mj_header endRefreshing];
        
        weakS.tableView.dataSuccess = success;
        
        weakS.info = weakInfo;
        
        [weakS.tableView reloadData];
        
    };
    
    [info requestAllDataWithGym:self.gym];
    
}

-(void)reloadData
{
    
    [self createData];
    
}

-(void)createUI
{
    
    self.title = @"课程种类";
    
    self.rightType = MONaviRightTypeAdd;
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CourseCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    [self.view addSubview:self.tableView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(void)addCourse
{
    
    Permission *permission = self.courseType == CourseTypeGroup?[PermissionInfo sharedInfo].permissions.groupPermission:[PermissionInfo sharedInfo].permissions.privatePermission;
    
    if (permission.addState) {
        
        CourseEditController *svc = [[CourseEditController alloc]init];
        
        Course *course = [[Course alloc]init];
        
        svc.course = course;
        
        svc.course.type = self.courseType;
        
        Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
        
        svc.gym = gym;
        
        svc.isAdd = YES;
        
        __weak typeof(self)weakS = self;
        
        svc.editFinish = ^{
            
            [weakS createData];
            
        };
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:self.courseType == CourseTypeGroup?@"抱歉，无团课种类添加权限":@"抱歉，无私教种类添加权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 2;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return self.courseType == CourseTypeGroup?self.info.groups.count:self.info.privates.count;
        
    }else{
        
        return 0;
        
    }
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Course *course = self.courseType == CourseTypeGroup?self.info.groups[indexPath.row]:self.info.privates[indexPath.row];
    
    cell.title = course.name;
    
    cell.subtitle = [NSString stringWithFormat:@"时长%ldmin",(long)course.during];
    
    cell.imgURL = course.imgUrl;
    
    cell.courseType = course.type;
    
    cell.tag = indexPath.row;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(81);
    
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

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (section == 1) {
        
        return Height320(40);
        
    }else{
        
        return 0;
        
    }
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (section == 0) {
        
        return nil;
        
    }
    
    UIView *footer = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    footer.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(MSW/2-Width320(37), 0, Width320(74), Height320(40))];
    
    label.text = [NSString stringWithFormat:@"共%ld种%@",(unsigned long)(self.courseType == CourseTypeGroup?self.info.groups.count:self.info.privates.count),self.courseType == CourseTypeGroup?@"团课":@"私教"];
    
    label.textColor = UIColorFromRGB(0xbbbbbb);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.font = AllFont(11);
    
    [footer addSubview:label];
    
    UIView *leftLine = [[UIView alloc]initWithFrame:CGRectMake(MSW/2-Width320(84), Height320(20), Width320(47), OnePX)];
    
    leftLine.backgroundColor = UIColorFromRGB(0xbbbbbb);
    
    [footer addSubview:leftLine];
    
    UIView *rightLine = [[UIView alloc]initWithFrame:CGRectMake(label.right, Height320(20),Width320(47), OnePX)];
    
    rightLine.backgroundColor = UIColorFromRGB(0xbbbbbb);
    
    [footer addSubview:rightLine];
    
    return footer;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isEditing) {
        
        return;
        
    }
    
    CourseDetailController *svc = [[CourseDetailController alloc]init];
    
    Course *course = self.courseType == CourseTypeGroup?self.info.groups[indexPath.row]:self.info.privates[indexPath.row];
    
    svc.course = course;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(88), Width320(190), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"course_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(18))];
    
    emptyLabel.text = self.courseType == CourseTypeGroup?@"暂无团课种类":@"暂无私教种类";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyLabel];
    
    UIButton *emptyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(69), emptyLabel.bottom+Height320(30), Width320(138), Height320(40))];
    
    emptyButton.backgroundColor = kMainColor;
    
    [emptyButton setTitle:self.courseType == CourseTypeGroup?@"+ 添加团课种类":@"添加私教种类" forState:UIControlStateNormal];
    
    [emptyButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    emptyButton.titleLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyButton];
    
    [emptyButton addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchUpInside];
    
    return emptyView;
    
}

-(void)naviRightClick
{
    
    [self addCourse];
    
}

@end
