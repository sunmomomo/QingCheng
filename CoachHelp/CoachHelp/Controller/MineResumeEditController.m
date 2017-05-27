//
//  MineResumeEditController.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "MineResumeEditController.h"

#import "IntroEditController.h"

#import "ChangeInfoController.h"

#import "QualityListController.h"

#import "WorkListController.h"

#import "MyCell.h"

static NSString *identifier = @"Cell";

@interface MineResumeEditController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@end

@implementation MineResumeEditController

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
    
    self.title = @"编辑我的简历";
    
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
    
    return 4;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(40);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    MyCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    cell.title = indexPath.row == 0?@"基本信息":indexPath.row == 1?@"学习培训":indexPath.row==2?@"工作经历":@"个人介绍";
    
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
        
    }else if(indexPath.row == 1){
        
        QualityListController *svc = [[QualityListController alloc]init];
        
        svc.url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/mobile/educations/",ROOT]];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else if (indexPath.row == 2){
        
        WorkListController *svc = [[WorkListController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        IntroEditController *svc = [[IntroEditController alloc]init];
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

@end
