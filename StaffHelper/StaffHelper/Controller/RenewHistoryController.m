//
//  RenewHistoryController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "RenewHistoryController.h"

#import "RenewHistoryInfo.h"

#import "RenewHistoryCell.h"

#import "MOTableView.h"

static NSString *identifier = @"Cell";

@interface RenewHistoryController ()<UITableViewDelegate,MOTableViewDatasource>

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSMutableArray *histories;

@property(nonatomic,strong)RenewHistoryInfo *info;

@end

@implementation RenewHistoryController

-(void)viewDidLoad{
    
    [super viewDidLoad];
    
    [self createUI];
    
    [self createData];
    
}

-(void)createData
{
    
    [self reloadData];
    
}

-(void)reloadData
{
    
    [self.tableView.mj_footer resetNoMoreData];
    
    RenewHistoryInfo *info = [[RenewHistoryInfo alloc]init];
    
    [info requestResult:^(BOOL success, NSString *error) {
        
        [self.tableView.mj_header endRefreshing];
        
        self.info = info;
        
        self.tableView.dataSuccess = success;
        
        self.histories = [info.histories mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)updateData
{
    
    [self.info requestResult:^(BOOL success, NSString *error) {
        
        if (self.info.histories.count) {
            
            [self.tableView.mj_header endRefreshing];
            
            for (RenewHistory *history in self.info.histories) {
                
                [self.histories addObject:history];
                
            }
            
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"场馆续费记录";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    [self.tableView registerClass:[RenewHistoryCell class] forCellReuseIdentifier:identifier];
    
    UILabel *footLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(66))];
    
    footLabel.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    footLabel.text = [NSString stringWithFormat:@"如有疑问，请联系青橙客服\n%@",QCPhone];
    
    footLabel.textColor = UIColorFromRGB(0x999999);
    
    footLabel.textAlignment = NSTextAlignmentCenter;
    
    footLabel.numberOfLines = 0;
    
    footLabel.font = AllFont(11);
    
    self.tableView.tableFooterView = footLabel;
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    MJRefreshAutoFooter *footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    
    self.tableView.mj_footer = footer;
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.histories.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(124);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    RenewHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    RenewHistory *history = self.histories[indexPath.row];
    
    cell.date = history.date;
    
    if (history.start && history.end) {
        
        cell.validTime = [NSString stringWithFormat:@"%@ 至 %@",history.start,history.end];
        
    }else{
        
        cell.validTime = @"";
        
    }
    
    cell.realPrice = [NSString stringWithFormat:@"%@元",history.realPrice];
    
    cell.historyType = history.type;
    
    cell.staffName = history.staff.name.length?[NSString stringWithFormat:@"操作人：%@",history.staff.name]:@"操作人：";
    
    cell.renewSuccess = history.success;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

@end
