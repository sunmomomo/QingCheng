//
//  GuideCoachController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideCoachController.h"

#import "CoachCell.h"

#import "GuideAddCoachController.h"

static NSString *identifier = @"Cell";

@interface GuideCoachController ()<UITableViewDataSource,UITableViewDelegate,DZNEmptyDataSetSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *coachArray;

@property(nonatomic,assign)BOOL havePushed;

@end

@implementation GuideCoachController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        
        
    }
    return self;
}

-(void)createData
{
    
    self.coachArray = [NSMutableArray array];
    
    for (Coach *coach in self.course.coaches) {
        
        Coach *tempCoach = [coach copy];
        
        [self.coachArray addObject:tempCoach];
        
    }
    
    if (!self.coachArray.count && !self.havePushed) {
        
        GuideAddCoachController *svc = [[GuideAddCoachController alloc]init];
        
        __weak typeof(self)weakS = self;
        
        svc.addSuccess = ^(){
            
            [weakS createData];
            
        };
        
        self.havePushed = YES;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [self.tableView reloadData];
    
}

-(void)createUI
{
    
    self.title = @"选择教练";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(60)) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    self.tableView.emptyDataSetSource = self;
    
    [self.tableView registerClass:[CoachCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    self.tableView.separatorInset = UIEdgeInsetsMake(0, Width320(75), 0, 0);
    
    [self.view addSubview:self.tableView];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, MSW, 1)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [self.view addSubview:sep];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.tableView.bottom+Height320(8), MSW-Width320(32), Height320(44))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:@"添加新教练" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.layer.cornerRadius = 2;
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)add:(UIButton*)button
{
    
    GuideAddCoachController *svc = [[GuideAddCoachController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.addSuccess = ^(){
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.coachArray.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CoachCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Coach *coach = self.coachArray[indexPath.row];
    
    cell.name = coach.name;
    
    cell.phone = coach.phone;
    
    cell.sex = coach.sex;
    
    cell.imgUrl = coach.iconUrl;
    
    cell.select = coach.choosed;
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(80);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    for (Coach *coach in self.coachArray) {
        
        coach.choosed = [self.coachArray indexOfObject:coach]==indexPath.row;
        
    }
    
    self.course.coaches = self.coachArray;
    
    if (self.chooseFinish) {
        self.chooseFinish();
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

-(UIView *)customViewForEmptyDataSet:(UIScrollView *)scrollView
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
