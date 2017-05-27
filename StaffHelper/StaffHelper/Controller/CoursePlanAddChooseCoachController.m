//
//  CoursePlanAddChooseCoachController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanAddChooseCoachController.h"

#import "CoursePlanCoachCell.h"

#import "CoachListInfo.h"

#import "CoursePlanAddController.h"

#import "CoachEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanAddChooseCoachController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CoachListInfo *info;

@end

@implementation CoursePlanAddChooseCoachController

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
    
    self.info = [[CoachListInfo alloc]init];
    
    [self.info requestDataWithCourseType:CourseTypePrivate andIsAdd:YES andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    CoachListInfo *info = [[CoachListInfo alloc]init];
    
    [info requestDataWithCourseType:CourseTypePrivate andIsAdd:YES andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.info = info;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择私教教练";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[CoursePlanCoachCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];

    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), self.tableView.bottom+Height320(8), MSW-Width320(24), Height320(40))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:@"+ 添加教练" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(add) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)add
{
    
    CoachEditController *svc = [[CoachEditController alloc]init];
    
    svc.gym = self.gym;
    
    svc.isAdd = YES;
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
       
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.coaches.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanCoachCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Coach *coach = self.info.coaches[indexPath.row];
    
    cell.name = coach.name;
    
    cell.imgURL = coach.iconUrl;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(82);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Coach *coach = self.info.coaches[indexPath.row];
    
    CoursePlanAddController *svc = [[CoursePlanAddController alloc]init];
    
    svc.coach = coach;
    
    svc.gym = self.gym;
    
    svc.courseType = CourseTypePrivate;
    
    [self.tableView reloadData];
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
