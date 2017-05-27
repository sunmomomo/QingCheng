//
//  GymPayHistoryController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymPayHistoryController.h"

#import "MOTableView.h"

#import "GymPayHistoryCell.h"

#import "GymPayHistoryInfo.h"

static NSString *identifier = @"Cell";

@interface GymPayHistoryController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *histories;

@end

@implementation GymPayHistoryController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    GymPayHistoryInfo *info = [[GymPayHistoryInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        self.histories = info.histories;
        
        self.tableView.dataSuccess = success;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"高级版付费记录";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[GymPayHistoryCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
 
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(60))];
    
    label.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    label.text = [NSString stringWithFormat:@"如有疑问，请联系青橙客服\n%@",QCPhone];
    
    label.textColor = UIColorFromRGB(0x999999);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 0;
    
    label.font = AllFont(12);
    
    self.tableView.tableHeaderView = label;
    
    [self.view addSubview:self.tableView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.histories.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(123);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    GymPayHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    GymPayHistory *history = self.histories[indexPath.row];
    
    cell.time = history.time;
    
    cell.valid = [NSString stringWithFormat:@"有效期：%@ 至 %@",history.fromDate,history.toDate];
    
    cell.price = [NSString stringWithFormat:@"支付金额：%ld元",(long)history.price];
    
    cell.summary = history.remarks.length?[NSString stringWithFormat:@"%@        操作人：%@",history.remarks,history.staff.name.length?history.staff.name:@""]:[NSString stringWithFormat:@"操作人：%@",history.staff.name.length?history.staff.name:@""];
    
    cell.success = history.success;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIView *emptyView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(58), MSW, MSH-Height320(50)-64)];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW/2-Width320(40), Height320(72), Width320(80), Height320(80))];
    
    emptyImg.image = [UIImage imageNamed:@"gym_pay_empty"];
    
    [emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(15), MSW, Height320(16))];
    
    emptyLabel.text = @"暂无续费记录";
    
    emptyLabel.textColor = UIColorFromRGB(0x333333);
    
    emptyLabel.textAlignment = NSTextAlignmentCenter;
    
    emptyLabel.font = AllFont(14);
    
    [emptyView addSubview:emptyLabel];
    
    return emptyView;
    
}

@end
