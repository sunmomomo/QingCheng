//
//  CourseRateController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/28.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CourseRateController.h"

#import "CourseRateCell.h"

#import "MOStarRateView.h"

#import "CourseRateInfo.h"

#import "CourseCoachRateController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CourseRateController ()<UITableViewDelegate,MOTableViewDatasource,CourseRateCellDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)MOStarRateView *coachRateView;

@property(nonatomic,strong)MOStarRateView *courseRateView;

@property(nonatomic,strong)MOStarRateView *serviceRateView;

@property(nonatomic,strong)UILabel *coachGradeLabel;

@property(nonatomic,strong)UILabel *courseGradeLabel;

@property(nonatomic,strong)UILabel *serviceGradeLabel;

@property(nonatomic,strong)CourseRateInfo *info;

@end

@implementation CourseRateController

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
    
    self.info = [[CourseRateInfo alloc]init];
    
    [self.info requestWithCourse:self.course result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            self.coachRateView.scorePercent = self.course.rate.coachRate;
            
            self.courseRateView.scorePercent = self.course.rate.courseRate;
            
            self.serviceRateView.scorePercent = self.course.rate.serviceRate;
            
            self.coachGradeLabel.text = [NSString stringWithFormat:@"%.1f",self.course.rate.coachRate];
            
            self.courseGradeLabel.text = [NSString stringWithFormat:@"%.1f",self.course.rate.courseRate];
            
            self.serviceGradeLabel.text = [NSString stringWithFormat:@"%.1f",self.course.rate.serviceRate];
            
            [self.tableView reloadData];
            
        }
        
    }];
    
}

-(void)createUI
{
    
    self.title = self.course.name;
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[CourseRateCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    self.tableView.tableHeaderView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(85))];
    
    [self.tableView sendSubviewToBack:self.tableView.tableHeaderView];
    
    UIView *headerBack = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(142))];
    
    headerBack.backgroundColor = UIColorFromRGB(0x4E4E4E);
    
    [self.tableView.tableHeaderView addSubview:headerBack];
    
    UILabel *coachLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(22), Height320(11), Width320(72), Height320(16))];
    
    coachLabel.text = @"教练评分";
    
    coachLabel.textColor = UIColorFromRGB(0xffffff);
    
    coachLabel.textAlignment = NSTextAlignmentCenter;
    
    coachLabel.font = AllFont(12);
    
    [headerBack addSubview:coachLabel];
    
    self.coachGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.left, coachLabel.bottom+Height320(7), coachLabel.width, Height320(27))];
    
    self.coachGradeLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.coachGradeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.coachGradeLabel.font = AllFont(24);
    
    [headerBack addSubview:self.coachGradeLabel];
    
    self.coachRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), self.coachGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
    
    self.coachRateView.center = CGPointMake(self.coachGradeLabel.center.x, self.coachRateView.center.y);
    
    self.coachRateView.starColor = UIColorFromRGB(0xF9944E);
    
    [headerBack addSubview:self.coachRateView];
    
    UILabel *courseLabel = [[UILabel alloc]initWithFrame:CGRectMake(coachLabel.right+Width320(30), coachLabel.top, Width320(72), Height320(16))];
    
    courseLabel.text = @"课程评分";
    
    courseLabel.textColor = UIColorFromRGB(0xffffff);
    
    courseLabel.textAlignment = NSTextAlignmentCenter;
    
    courseLabel.font = AllFont(12);
    
    [headerBack addSubview:courseLabel];
    
    self.courseGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseLabel.left, courseLabel.bottom+Height320(7), courseLabel.width, Height320(27))];
    
    self.courseGradeLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.courseGradeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.courseGradeLabel.font = AllFont(24);
    
    [headerBack addSubview:self.courseGradeLabel];
    
    self.courseRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), self.courseGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
    
    self.courseRateView.center = CGPointMake(self.courseGradeLabel.center.x, self.courseRateView.center.y);
    
    self.courseRateView.starColor = UIColorFromRGB(0xF9944E);
    
    [headerBack addSubview:self.courseRateView];
    
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(courseLabel.right+Width320(30), courseLabel.top, Width320(72), Height320(16))];
    
    serviceLabel.text = @"服务评分";
    
    serviceLabel.textColor = UIColorFromRGB(0xffffff);
    
    serviceLabel.textAlignment = NSTextAlignmentCenter;
    
    serviceLabel.font = AllFont(12);
    
    [headerBack addSubview:serviceLabel];
    
    self.serviceGradeLabel = [[UILabel alloc]initWithFrame:CGRectMake(serviceLabel.left, serviceLabel.bottom+Height320(7), serviceLabel.width, Height320(27))];
    
    self.serviceGradeLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.serviceGradeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.serviceGradeLabel.font = AllFont(24);
    
    [headerBack addSubview:self.serviceGradeLabel];
    
    self.serviceRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(Width320(32), self.serviceGradeLabel.bottom+Height320(6), Width320(44), Height320(8))];
    
    self.serviceRateView.center = CGPointMake(self.serviceGradeLabel.center.x, self.serviceRateView.center.y);
    
    self.serviceRateView.starColor = UIColorFromRGB(0xF9944E);
    
    [headerBack addSubview:self.serviceRateView];
    
    self.tableView.tableFooterView = [UIView new];
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseRateCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Gym *gym = self.info.gyms[indexPath.row];
    
    cell.rates = gym.rate.rates;
    
    cell.title = gym.name;
    
    cell.imgURL = gym.imgUrl;
    
    [cell setCoachRate:gym.rate.coachRate andCourseRate:gym.rate.courseRate andServiceRate:gym.rate.serviceRate];
    
    cell.rates = gym.rate.rates;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    cell.tag = indexPath.row;
    
    cell.delegate = self;
    
    return cell;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.info.gyms.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Gym *gym = self.info.gyms[indexPath.row];
    
    return [CourseRateCell getHeightWithRates:gym.rate.rates];
    
}

-(void)showDetailOfCourseRateCell:(CourseRateCell*)cell
{
    
    CourseCoachRateController *svc = [[CourseCoachRateController alloc]init];
    
    svc.course = self.course;
    
    Gym *gym = self.info.gyms[cell.tag];
    
    svc.gym = gym; 
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

@end
