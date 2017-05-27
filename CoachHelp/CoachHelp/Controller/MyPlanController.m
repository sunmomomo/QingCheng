//
//  MyPlanController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MyPlanController.h"

#import "MyPlanInfo.h"

#import "MyPlanCell.h"

#import "RootController.h"

#import "WebViewController.h"

#import "MOTableView.h"

#import "ChooseView.h"

static NSString *identifier = @"Cell";

@interface MyPlanController ()<MOTableViewDatasource,UITableViewDelegate,ChooseViewDatasource>

@property(nonatomic,strong)MOTableView *gymTableView;

@property(nonatomic,strong)MOTableView *studyTableView;

@property(nonatomic,strong)MOTableView *customTableView;

@property(nonatomic,strong)MyPlanInfo *planInfo;

@property(nonatomic,strong)ChooseView *chooseView;

@end

@implementation MyPlanController

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self createData];
    
    if ([self.gymTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.gymTableView setSeparatorInset:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([self.gymTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.gymTableView setLayoutMargins:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([self.studyTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.studyTableView setSeparatorInset:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([self.studyTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.studyTableView setLayoutMargins:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([self.customTableView respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [self.customTableView setSeparatorInset:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([self.customTableView respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [self.customTableView setLayoutMargins:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    MyPlanInfo *tempInfo = [[MyPlanInfo alloc]init];
    
    [tempInfo requestDataResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.planInfo = tempInfo;
            
        }
        
        [self.chooseView reloadTableViewDataWithSuccess:success];
        
    }];
    
}

-(void)createUI
{
    
    self.rightType = MONaviRightTypeAdd;
    
    self.title = @"我的课件";
        
    self.chooseView = [[ChooseView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    self.chooseView.rowWidth = Width(65);
    
    self.chooseView.rowHeight = Height320(40);
    
    self.chooseView.rowGap = Width(40);
    
    self.chooseView.datasource = self;
    
    [self.view addSubview:self.chooseView];
    
}

-(void)naviRightClick
{
    
    [self addNew];
    
}

-(NSInteger)numberOfRowInChooseView
{
    
    return 3;
    
}

-(NSString *)titleForButtonAtRow:(NSInteger)row
{
    
    return @[@"场馆",@"学习培训",@"自定义"][row];
    
}

-(UIScrollView *)viewForRow:(NSInteger)row
{
    
    if (row == 0) {
        
        if (!self.gymTableView) {
            
            self.gymTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40)) style:UITableViewStylePlain];
            
            self.gymTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.gymTableView.tag = row;
            
            self.gymTableView.dataSource = self;
            
            self.gymTableView.delegate = self;
            
            [self.gymTableView registerClass:[MyPlanCell class] forCellReuseIdentifier:identifier];
            
            self.gymTableView.tableFooterView = [UIView new];
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
            
            header.stateLabel.textColor = [UIColor blackColor];
            
            self.gymTableView.mj_header = header;
            
        }
        
        return self.gymTableView;
        
    }else if (row == 1){
        
        if (!self.studyTableView) {
            
            self.studyTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40)) style:UITableViewStylePlain];
            
            self.studyTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.studyTableView.tag = row;
            
            self.studyTableView.dataSource = self;
            
            self.studyTableView.delegate = self;
            
            [self.studyTableView registerClass:[MyPlanCell class] forCellReuseIdentifier:identifier];
            
            self.studyTableView.tableFooterView = [UIView new];
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
            
            header.stateLabel.textColor = [UIColor blackColor];
            
            self.studyTableView.mj_header = header;
            
        }
        
        return self.studyTableView;
        
    }else{
        
        if (!self.customTableView) {
            
            self.customTableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40)) style:UITableViewStylePlain];
            
            self.customTableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
            
            self.customTableView.tag = row;
            
            self.customTableView.dataSource = self;
            
            self.customTableView.delegate = self;
            
            [self.customTableView registerClass:[MyPlanCell class] forCellReuseIdentifier:identifier];
            
            self.customTableView.tableFooterView = [UIView new];
            
            MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
            
            header.lastUpdatedTimeLabel.hidden = YES;
            
            [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
            
            [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
            
            [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
            
            header.stateLabel.textColor = [UIColor blackColor];
            
            self.customTableView.mj_header = header;
            
        }
        
        return self.customTableView;
        
    }
    
}

-(void)addNew
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    svc.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/coaches/add/plans/",ROOT]];
    
    svc.leftType = MONaviLeftTypeBack;
    
    __weak typeof(self)weakS = self;
    
    svc.completeAction = ^{
       
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
        
        [cell setSeparatorInset:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
    if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
        
        [cell setLayoutMargins:UIEdgeInsetsMake(0, Width(15), 0, 0)];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    switch (tableView.tag) {
        case 0:
            
            return self.planInfo.gymPlans.count;
            
            break;
            
        case 1:
            
            return self.planInfo.studyPlans.count;
            
            break;
            
        case 2:
            
            return self.planInfo.customPlans.count;
            
            break;
            
        default:
            
            return 0;
            
            break;
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyPlanCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    NSArray *array;
    
    switch (tableView.tag) {
        case 0:
            
            array = self.planInfo.gymPlans;
            
            break;
            
        case 1:
            
            array = self.planInfo.studyPlans;
            
            break;
            
        case 2:
            
            array = self.planInfo.customPlans;
            
            break;
            
        default:
            
            array = nil;
            
            break;
    }
    
    if (indexPath.row<array.count) {
        
        Plan *plan = array[indexPath.row];
        
        cell.title = plan.planName;
        
        cell.tags = plan.tags;
        
        cell.type = plan.type;
        
        cell.gymName = plan.brandName;
        
    }
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(74.7);
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    NSArray *array;
    
    switch (tableView.tag) {
        case 0:
            
            array = self.planInfo.gymPlans;
            
            break;
            
        case 1:
            
            array = self.planInfo.studyPlans;
            
            break;
            
        case 2:
            
            array = self.planInfo.customPlans;
            
            break;
            
        default:
            
            array = nil;
            
            break;
    }
    
    Plan *plan = array[indexPath.row];
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    svc.url = plan.url;
    
    svc.deallocReload = YES;
    
    __weak typeof(self)weakS = self;
    
    svc.completeAction = ^{
        
        [weakS reloadData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *view = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(40))];
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/3, Height320(75.5), MSW/3, MSW/3)];
    
    emptyImg.image = tableView.tag == 1?[UIImage imageNamed:@"plan_coming_soon"]:[UIImage imageNamed:@"planempty"];
    
    [view addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(20, emptyImg.bottom+Height320(19.5), MSW-40, Height320(19.5))];
    
    emptyLabel.text = tableView.tag==0?@"场馆还没有添加任何课件":tableView.tag==1?@"敬请期待":@"您还没有添加任何自定义课件";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textColor = UIColorFromRGB(0x747474);
    
    emptyLabel.font = STFont(IPhone4_5_6_6P(15, 15, 16, 16));
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    [view addSubview:emptyLabel];
    
    if (tableView.tag == 2) {
        
        UIButton *addBtn1 = [UIButton buttonWithType:UIButtonTypeCustom];
        
        addBtn1.frame = CGRectMake(Width320(75.5), emptyLabel.bottom+Height320(19.5), MSW-Width320(151), Height320(42.7));
        
        addBtn1.backgroundColor = kMainColor;
        
        [addBtn1 setTitle:@"添加课件" forState:UIControlStateNormal];
        
        [addBtn1 setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
        
        addBtn1.titleLabel.font = STFont(IPhone4_5_6_6P(17, 17, 19, 19));
        
        addBtn1.tag = 201;
        
        addBtn1.layer.cornerRadius = 1;
        
        addBtn1.layer.masksToBounds = YES;
        
        [addBtn1 addTarget:self action:@selector(addNew) forControlEvents:UIControlEventTouchUpInside];
        
        [view addSubview:addBtn1];
        
    }
    
    return view;
    
}

@end
