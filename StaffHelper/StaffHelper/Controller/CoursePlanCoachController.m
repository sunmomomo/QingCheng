//
//  CoursePlanCoachController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanCoachController.h"

#import "CoursePlanCoachCell.h"

#import "CoachListInfo.h"

#import "CoachEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanCoachController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)CoachListInfo *info;

@end

@implementation CoursePlanCoachController

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
    
    self.info = [[CoachListInfo alloc]init];
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    [self.info requestDataWithCourseType:type andIsAdd:self.isAdd andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[CoursePlanCoachCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
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
    
    if (indexPath.row<self.info.coaches.count) {
        
        Coach *coach = self.info.coaches[indexPath.row];
        
        cell.name = coach.name;
        
        cell.imgURL = coach.iconUrl;
        
        if (self.plan) {
            
            cell.choosed = coach.coachId == self.plan.coach.coachId;
            
        }else{
            
            cell.choosed = coach.coachId == self.batch.coach.coachId;
            
        }
        
    }
    
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
    
    if (indexPath.row<self.info.coaches.count) {
        
        Coach *coach = self.info.coaches[indexPath.row];
        
        if (self.chooseFinish) {
            
            self.chooseFinish(coach);
            
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
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
    
    emptyLabel.text = @"暂无教练";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(13);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}
@end
