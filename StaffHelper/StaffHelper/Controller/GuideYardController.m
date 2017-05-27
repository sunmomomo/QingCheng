//
//  GuideYardController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideYardController.h"

#import "ChooseYardCell.h"

#import "GuideAddYardController.h"

static NSString *identifier = @"Cell";

@interface GuideYardController ()<UITableViewDataSource,UITableViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *yards;

@end

@implementation GuideYardController

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
    
    AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
    
    self.yards = [delegate.course.yards mutableCopy];
    
    [self.tableView reloadData];
    
}

-(void)createUI
{
    
    self.title = @"选择场地";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64-Height320(60)) style:UITableViewStylePlain];
    
    self.tableView.delegate = self;
    
    self.tableView.dataSource = self;
    
    [self.tableView registerClass:[ChooseYardCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, self.tableView.bottom, MSW, 1)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [self.view addSubview:sep];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(16), self.tableView.bottom+Height320(8), MSW-Width320(32), Height320(44))];
    
    addButton.backgroundColor = kMainColor;
    
    [addButton setTitle:@"添加新场地" forState:UIControlStateNormal];
    
    [addButton setTitleColor:UIColorFromRGB(0xffffff) forState:UIControlStateNormal];
    
    addButton.layer.cornerRadius = 2;
    
    addButton.titleLabel.font = AllFont(14);
    
    [self.view addSubview:addButton];
    
    [addButton addTarget:self action:@selector(add:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)add:(UIButton*)button
{
    
    GuideAddYardController *svc = [[GuideAddYardController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.addSuccess = ^(Yard *yard){
        
        [weakS createData];
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.yards.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChooseYardCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    Yard *yard = self.yards[indexPath.row];
    
    cell.courseType = CourseTypeGroup;
    
    cell.yardCapacity = yard.capacity;
    
    cell.yardName = yard.name;
    
    cell.yardType = yard.type;
    
    cell.select = yard.choosed;
        
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    CourseType type = ((AppDelegate *)[UIApplication sharedApplication].delegate).course.type;
    
    if (type == CourseTypeGroup) {
        
        Yard *yard = self.yards[indexPath.row];
        
        if (yard.type == YardTypeGroup || yard.type == YardTypeUnlimited) {
            
            for (Yard *tempYard in self.yards) {
                
                tempYard.choosed = [self.yards indexOfObject:tempYard] == indexPath.row;
                
            }
            
            [self.tableView reloadData];
            
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            
            delegate.course.yards = [self.yards mutableCopy];
            
            if (self.chooseFinish) {
                self.chooseFinish();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"该场地只适用于私教课程" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }else{
        
        Yard *yard = self.yards[indexPath.row];
        
        if (yard.type == YardTypePrivate || yard.type == YardTypeUnlimited) {
            
            for (Yard *tempYard in self.yards) {
                
                tempYard.choosed = [self.yards indexOfObject:tempYard] == indexPath.row;
                
            }
            
            [self.tableView reloadData];
            
            AppDelegate *delegate = (AppDelegate*)[UIApplication sharedApplication].delegate;
            
            delegate.course.yards = [self.yards mutableCopy];
            
            if (self.chooseFinish) {
                self.chooseFinish();
            }
            
            [self.navigationController popViewControllerAnimated:YES];
            
        }else{
            
            [[[UIAlertView alloc]initWithTitle:@"该场地只适用于团课课程" message:nil delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil]show];
            
        }
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(80);
    
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
