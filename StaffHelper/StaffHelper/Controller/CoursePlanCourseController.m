//
//  CoursePlanCourseController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanCourseController.h"

#import "CoursePlanCourseCell.h"

#import "CourseListInfo.h"

#import "CourseEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanCourseController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CourseListInfo *info;

@property(nonatomic,strong)Course *selectCourse;

@end

@implementation CoursePlanCourseController

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
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    [self.info requestWithCourseType:type andIsAdd:self.isAdd andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    [self.info requestWithCourseType:type andIsAdd:self.isAdd andGym:self.gym result:^(BOOL success, NSString *error) {
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    self.title = type == CourseTypePrivate?@"选择私教种类":@"选择团课种类";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.tableView registerClass:[CoursePlanCourseCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), self.tableView.bottom+Height320(8), MSW-Width320(24), Height320(40))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:type == CourseTypePrivate?@"+ 添加私教种类":@"+ 添加团课种类" forState:UIControlStateNormal];
    
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
    
    svc.course.type = self.plan?self.plan.course.type:self.batch.course.type;
    
    Gym *gym = ((AppDelegate*)[UIApplication sharedApplication].delegate).gym;
    
    svc.gym = gym;
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS reloadData];
        
    };
    
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
    
    cell.choosed = course.courseId == self.selectCourse.courseId;
    
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
    
    Course *course = self.info.courses[indexPath.row];
    
    self.selectCourse = course;
    
    [self.tableView reloadData];
    
    if (self.chooseFinish) {
        self.chooseFinish(course);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}


-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(50), Height320(75.5), Width320(100), Height320(100))];
    
    emptyImg.image = [UIImage imageNamed:@"emptyreport"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(16), MSW, Height320(15))];
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    emptyLabel.text = type == CourseTypePrivate?@"暂无私教种类":@"暂无团课种类";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

@end
