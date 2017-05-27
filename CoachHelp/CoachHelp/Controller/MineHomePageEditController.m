//
//  MineHomePageEditController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/2/22.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MineHomePageEditController.h"

#import "MOCell.h"

#import "IntroEditController.h"

#import "ChangeInfoController.h"

#import "MinePhototController.h"

#import "MyCell.h"

static NSString *identifier = @"Cell";

@interface MineHomePageEditController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MineHomePageEditController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    
    
}

-(void)createUI
{
    
    self.title = @"编辑主页";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[MyCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return 3;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.title = indexPath.row == 0?@"基本信息":indexPath.row == 1?@"照片墙":@"个人介绍";
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    if (indexPath.row == 0) {
        
        ChangeInfoController *svc = [[ChangeInfoController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (indexPath.row == 1){
        
        MinePhototController *svc = [[MinePhototController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (indexPath.row == 2){
        
        IntroEditController *svc = [[IntroEditController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}


@end
