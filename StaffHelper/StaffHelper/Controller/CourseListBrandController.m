//
//  CourseListBrandController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/6.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseListBrandController.h"

#import "CourseCell.h"

#import "CourseListInfo.h"

#import "CourseEditController.h"

#import "MOTableView.h"

#import "CourseDetailController.h"

#import "ChooseView.h"

static NSString *groupIdentifier = @"Group";

static NSString *privateIdentifier = @"Private";

@interface CourseListBrandController ()<UITableViewDelegate,MOTableViewDatasource,UIAlertViewDelegate,ChooseViewDatasource>

@property(nonatomic,strong)ChooseView *chooseView;

@property(nonatomic,strong)MOTableView *groupTableView;

@property(nonatomic,strong)MOTableView *privateTableView;

@property(nonatomic,strong)CourseListInfo *info;

@property(nonatomic,strong)MBProgressHUD *hud;

@end

@implementation CourseListBrandController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
    if ([self.groupTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.groupTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.groupTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.groupTableView setLayoutMargins:UIEdgeInsetsZero];
        
    }
    
    if ([self.privateTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.privateTableView setSeparatorInset:UIEdgeInsetsZero];
        
    }
    
    if ([self.privateTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.privateTableView setLayoutMargins:UIEdgeInsetsZero];
        
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
        
        weakS.groupTableView.dataSuccess = success;
        
        weakS.privateTableView.dataSuccess = success;
        
        weakS.info = weakInfo;
        
        [weakS.chooseView reloadTableViewDataWithSuccess:success];
        
    };
    
    [info requestAllDataWithGym:nil];
    
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
    
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.chooseView.rowHeight = Height320(40);
    
    self.chooseView.rowWidth = MSW/2;
    
    self.chooseView.datasource = self;
    
    [self.view addSubview:self.chooseView];
    
    self.hud = [[MBProgressHUD alloc]initWithView:self.view];
    
    [self.view addSubview:self.hud];
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 2;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"团课种类",@"私教种类"][row];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    if (row == 0) {
        
        if ([PermissionInfo sharedInfo].permissions.groupPermission.readState) {
            
            self.groupTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40)) style:UITableViewStylePlain];
            
            self.groupTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.groupTableView.dataSource = self;
            
            self.groupTableView.delegate = self;
            
            [self.groupTableView registerClass:[CourseCell class] forCellReuseIdentifier:groupIdentifier];
            
            self.groupTableView.tableFooterView = [UIView new];
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
            
            header.stateLabel.textColor = [UIColor blackColor];
            
            self.groupTableView.mj_header = header;
            
            return self.groupTableView;
            
        }else{
            
            UIScrollView *noPremissionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40))];
            
            noPremissionView.backgroundColor = UIColorFromRGB(0xffffff);
            
            UIImageView *noPremissionImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(117), Width320(168), Height320(132))];
            
            noPremissionImg.image = [UIImage imageNamed:@"no_premission"];
            
            [noPremissionView addSubview:noPremissionImg];
            
            UILabel *noPremissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, noPremissionImg.bottom+Height320(18), MSW, Height320(18))];
            
            noPremissionLabel.text = @"抱歉，您无权限查看该模块";
            
            noPremissionLabel.textAlignment = NSTextAlignmentCenter;
            
            noPremissionLabel.textColor = UIColorFromRGB(0x999999);
            
            noPremissionLabel.font = AllFont(14);
            
            [noPremissionView addSubview:noPremissionLabel];
            
            return noPremissionView;
            
        }
        
    }else{
        
        if ([PermissionInfo sharedInfo].permissions.privatePermission.readState) {
            
            self.privateTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40)) style:UITableViewStylePlain];
            
            self.privateTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.privateTableView.dataSource = self;
            
            self.privateTableView.delegate = self;
            
            [self.privateTableView registerClass:[CourseCell class] forCellReuseIdentifier:privateIdentifier];
            
            self.privateTableView.tableFooterView = [UIView new];
                        
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
            
            header.stateLabel.textColor = [UIColor blackColor];
            
            self.privateTableView.mj_header = header;
            
            return self.privateTableView;
            
        }else{
            
            UIScrollView *noPremissionView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40))];
            
            noPremissionView.backgroundColor = UIColorFromRGB(0xffffff);
            
            UIImageView *noPremissionImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(76), Height320(117), Width320(168), Height320(132))];
            
            noPremissionImg.image = [UIImage imageNamed:@"no_premission"];
            
            [noPremissionView addSubview:noPremissionImg];
            
            UILabel *noPremissionLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, noPremissionImg.bottom+Height320(18), MSW, Height320(18))];
            
            noPremissionLabel.text = @"抱歉，您无权限查看该模块";
            
            noPremissionLabel.textAlignment = NSTextAlignmentCenter;
            
            noPremissionLabel.textColor = UIColorFromRGB(0x999999);
            
            noPremissionLabel.font = AllFont(14);
            
            [noPremissionView addSubview:noPremissionLabel];
            
            return noPremissionView;
            
        }
        
    }
    
}

-(void)addCourse
{
    
    CourseEditController *svc = [[CourseEditController alloc]init];
    
    Course *course = [[Course alloc]init];
    
    svc.course = course;
    
    svc.course.type = self.chooseView.selectNum == 0?CourseTypeGroup:CourseTypePrivate;
    
    Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
    
    svc.gym = gym;
    
    svc.isAdd = YES;
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return tableView == self.groupTableView?self.info.groups.count:self.info.privates.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseCell *cell = [tableView dequeueReusableCellWithIdentifier:tableView == self.groupTableView?groupIdentifier:privateIdentifier];
    
    Course *course = tableView == self.groupTableView?self.info.groups[indexPath.row]:self.info.privates[indexPath.row];
    
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

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (self.isEditing) {
        
        return;
        
    }
    
    CourseDetailController *svc = [[CourseDetailController alloc]init];
    
    Course *course = tableView == self.groupTableView?self.info.groups[indexPath.row]:self.info.privates[indexPath.row];
    
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
    
    emptyLabel.text = tableView == self.groupTableView?@"暂无团课种类":@"暂无私教种类";
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyLabel];
    
    UIButton *emptyButton = [[UIButton alloc]initWithFrame:CGRectMake(MSW/2-Width320(69), emptyLabel.bottom+Height320(30), Width320(138), Height320(40))];
    
    emptyButton.backgroundColor = kMainColor;
    
    [emptyButton setTitle:tableView == self.groupTableView?@"+ 添加团课种类":@"添加私教种类" forState:UIControlStateNormal];
    
    [emptyButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    emptyButton.titleLabel.font = AllFont(14);
    
    emptyButton.tag = tableView == self.groupTableView?0:1;
    
    [emptyView addSubview:emptyButton];
    
    [emptyButton addTarget:self action:@selector(addCourse) forControlEvents:UIControlEventTouchUpInside];
    
    return emptyView;
    
}

-(void)naviRightClick
{
    
    Permission *permission = self.chooseView.selectNum == 0?[PermissionInfo sharedInfo].permissions.groupPermission:[PermissionInfo sharedInfo].permissions.privatePermission;
    
    if (permission.addState) {
        
        [self addCourse];
        
    }else{
        
        [[[UIAlertView alloc]initWithTitle:self.chooseView.selectNum == 0?@"抱歉，无团课种类添加权限":@"抱歉，无私教种类添加权限" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
    }
    
}

@end
