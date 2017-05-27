//
//  CoursePlanAddChooseCourseController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/15.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanAddChooseCourseController.h"

#import "CoursePlanCourseCell.h"

#import "CourseListInfo.h"

#import "CoursePlanAddController.h"

#import "CourseEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanAddChooseCourseController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CourseListInfo *info;

@end

@implementation CoursePlanAddChooseCourseController

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
    
    self.info = [[CourseListInfo alloc]init];
    
    [self.info requestWithCourseType:CourseTypeGroup andIsAdd:YES andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    CourseListInfo *info = [[CourseListInfo alloc]init];
    
    [info requestWithCourseType:CourseTypeGroup andIsAdd:YES andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.info = info;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择团课种类";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[CoursePlanCourseCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), self.tableView.bottom+Height320(8), MSW-Width320(24), Height320(40))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:@"+ 添加团课种类" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addClick
{
    
    CourseEditController *svc = [[CourseEditController alloc]init];
    
    svc.isAdd = YES;
    
    svc.course = [[Course alloc]init];
    
    svc.course.type = CourseTypeGroup;
    
    Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
    
    svc.gym = gym;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.courses.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoursePlanCourseCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Course *course = self.info.courses[indexPath.row];
    
    cell.imgURL = course.imgUrl;
    
    cell.title = course.name;
    
    cell.subtitle = [NSString stringWithFormat:@"%ldmin",(long)course.during];
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(82);
    
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
    
    CoursePlanAddController *svc = [[CoursePlanAddController alloc]init];
    
    Course *course = self.info.courses[indexPath.row];
    
    svc.course = course;
    
    svc.courseType = CourseTypeGroup;
    
    svc.gym = self.gym;
    
    [self.tableView reloadData];
    
    [self.navigationController pushViewController:svc animated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


@end
