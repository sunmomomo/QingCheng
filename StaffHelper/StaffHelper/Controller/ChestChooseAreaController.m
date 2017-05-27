//
//  ChestChooseAreaController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/21.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ChestChooseAreaController.h"

#import "ChestAreaListInfo.h"

#import "ChestAreaCell.h"

#import "ChestAreaEditController.h"

#import "MOTableView.h"

static  NSString *identifier = @"Cell";

@interface ChestChooseAreaController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)ChestAreaListInfo *info;

@end

@implementation ChestChooseAreaController

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
    
    self.info = [[ChestAreaListInfo alloc]init];
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)reloadData
{
    
    [self.info requestDataResult:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"选择区域";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[ChestAreaCell class] forCellReuseIdentifier:identifier];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(40))];
    
    addButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [addButton setTitle:@"+ 添加新区域" forState:UIControlStateNormal];
    
    [addButton setTitleColor:kMainColor forState:UIControlStateNormal];
    
    addButton.titleLabel.font = AllFont(14);
    
    self.tableView.tableFooterView = addButton;
    
    [self.view addSubview:self.tableView];
    
    [addButton addTarget:self action:@selector(addArea) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)addArea
{
    
    ChestAreaEditController *svc = [[ChestAreaEditController alloc]init];
    
    svc.isAdd = YES;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    return self.info.areas.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestAreaCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    ChestArea *area = self.info.areas[indexPath.row];
    
    cell.name = area.areaName;
    
    cell.choosed = area.areaId == self.area.areaId;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ChestArea *area = self.info.areas[indexPath.row];
    
    if (self.chooseFinish) {
        
        self.chooseFinish(area);
        
    }
    
    [self.navigationController popViewControllerAnimated:YES];
    
}

@end
