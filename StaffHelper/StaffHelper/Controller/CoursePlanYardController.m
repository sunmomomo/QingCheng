//
//  CoursePlanYardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanYardController.h"

#import "ChooseYardCell.h"

#import "YardListInfo.h"

#import "YardEditController.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface CoursePlanYardController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)YardListInfo *info;

@property(nonatomic,strong)NSMutableArray *choosedYards;

@end

@implementation CoursePlanYardController

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
    
    self.info = [[YardListInfo alloc]init];
    
    [self.info requestDataWithCourseType:self.batch.course.type andIsAdd:self.isAdd andGym:AppGym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
    if (self.plan) {
        
        if (self.plan.yards) {
            
            self.choosedYards = [self.plan.yards mutableCopy];
            
        }else
        {
            
            self.choosedYards = [NSMutableArray array];
            
        }
        
    }else{
        
        if (self.batch.yards) {
            
            self.choosedYards = [self.batch.yards mutableCopy];
            
        }else
        {
            
            self.choosedYards = [NSMutableArray array];
            
        }
        
    }
    
    [self.tableView reloadData];
    
}

-(void)createUI
{
    
    self.title = @"选择场地";
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (type == CourseTypePrivate) {
        
        self.rightTitle = @"确定";
        
    }
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(56)) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[ChooseYardCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(12), self.tableView.bottom+Height320(8), MSW-Width320(24), Height320(40))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:@"+ 添加新场地" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(addYard) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addYard
{
    
    YardEditController *svc = [[YardEditController alloc]init];
    
    svc.isAdd = YES;
    
    svc.gym = self.gym;
    
    svc.yard = [[Yard alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.editFinish = ^{
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    return type == CourseTypeGroup?self.info.groupYards.count:self.info.privateYards.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChooseYardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    Yard *yard = type == CourseTypeGroup?self.info.groupYards[indexPath.row]:self.info.privateYards[indexPath.row];
    
    cell.yardName = yard.name;
    
    cell.yardType = yard.type;
    
    cell.yardCapacity = yard.capacity;
    
    cell.courseType = self.plan?self.plan.course.type:self.batch.course.type;
    
    BOOL contains = NO;
    
    for (Yard *tempYard in self.choosedYards) {
        
        if (yard.yardId == tempYard.yardId) {
            
            contains = YES;
     
            break;
            
        }
        
    }
    
    cell.select = contains;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(69);
    
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
    
    CourseType type = self.plan?self.plan.course.type:self.batch.course.type;
    
    if (type == CourseTypeGroup) {
        
        Yard *yard = self.info.groupYards[indexPath.row];
        
        if (self.chooseFinish) {
            self.chooseFinish(@[yard]);
        }
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        
        Yard *yard = self.info.privateYards[indexPath.row];
        
        BOOL contains = NO;
        
        for (Yard *tempYard in self.choosedYards) {
            
            if (yard.yardId == tempYard.yardId) {
                
                contains = YES;
                
                [self.choosedYards removeObject:tempYard];
                
                break;
                
            }
            
        }
        
        if (!contains) {
            
            [self.choosedYards addObject:yard];
            
        }
        
        [self.tableView reloadData];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)naviRightClick
{
    
    if (!self.choosedYards.count) {
        
        [[[UIAlertView alloc]initWithTitle:@"至少选择一处场地" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
        
        return;
        
    }
    
    if (self.chooseFinish) {
        self.chooseFinish(self.choosedYards);
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(56))];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(107), Width320(180), Height320(149))];
    
    emptyImg.image = [UIImage imageNamed:@"yard_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), MSW, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"暂无场地";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

@end
