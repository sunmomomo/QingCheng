//
//  StudentIntegralController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "StudentIntegralController.h"

#import "MOTableView.h"

#import "IntegralHistoryInfo.h"

#import "IntegralHistoryCell.h"

#import "StudentIntegralChangeController.h"

static NSString *identifier = @"Cell";

@interface StudentIntegralController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)UILabel *integralLabel;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSMutableArray *integralHistories;

@property(nonatomic,strong)IntegralHistoryInfo *info;

@end

@implementation StudentIntegralController

-(void)viewDidLoad{
    
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

-(void)createData
{
    
    [self reloadData];

}

-(void)reloadData
{
    
    IntegralHistoryInfo *info = [[IntegralHistoryInfo alloc]init];
    
    [info requestHistoriesWithStudent:self.user result:^(BOOL success, NSString *error) {
        
        [self.tableView.mj_footer resetNoMoreData];
        
        [self.tableView.mj_header endRefreshing];
        
        self.tableView.dataSuccess = success;
        
        self.info = info;
        
        self.integralHistories = [self.info.histories mutableCopy];
        
        [self.tableView reloadData];
        
    }];
    
    IntegralHistoryInfo *integralInfo = [[IntegralHistoryInfo alloc]init];
    
    [integralInfo requestWithStudent:self.user result:^(BOOL success, NSString *error) {
        
        self.integralLabel.text = [NSString formatStringWithFloat:integralInfo.integral];
        
    }];
    
}

-(void)updateData
{
    
    [self.info requestHistoriesWithStudent:self.user result:^(BOOL success, NSString *error) {
        
        if (self.info.histories.count) {
            
            [self.tableView.mj_footer endRefreshing];
            
            for (IntegralHistory *history in self.info.histories) {
                
                [self.integralHistories addObject:history];
                
            }
            
        }else{
            
            [self.tableView.mj_footer endRefreshingWithNoMoreData];
            
        }
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.title = @"积分详情";
    
    self.view.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UIImageView *headerBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(120))];
    
    headerBack.image = [UIImage imageNamed:@"student_integral_back"];
    
    headerBack.userInteractionEnabled = YES;
    
    [self.view addSubview:headerBack];
    
    UILabel *nameLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(28), Width320(80), Height320(34))];
    
    nameLabel.textColor = UIColorFromRGB(0xffffff);
    
    nameLabel.text = [NSString stringWithFormat:@"%@\n当前积分",self.user.name];
    
    nameLabel.numberOfLines = 0;
    
    nameLabel.font = AllFont(12);
    
    [headerBack addSubview:nameLabel];
    
    self.integralLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(17), nameLabel.bottom, Width320(150), Height320(50))];
    
    self.integralLabel.textColor = UIColorFromRGB(0xffffff);
    
    self.integralLabel.font = AllFont(50);
    
    [headerBack addSubview:self.integralLabel];
    
    UIButton *subButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(168), Height320(44), Width320(60), Height320(60))];

    subButton.tag = 0;
    
    [subButton setBackgroundImage:[UIImage createImageWithColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.2]] forState:UIControlStateNormal];
    
    [subButton setBackgroundImage:[UIImage createImageWithColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4]] forState:UIControlStateHighlighted];
    
    [headerBack addSubview:subButton];
    
    [subButton addTarget:self action:@selector(changeIntegral:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *subImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(22), Height320(14), Width320(16), Height320(16))];
    
    subImg.image = [UIImage imageNamed:@"button_white_sub"];
    
    subImg.contentMode = UIViewContentModeScaleAspectFit;
    
    [subButton addSubview:subImg];
    
    UILabel *subLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, subImg.bottom+Height320(6), Width320(60), Height320(17))];
    
    subLabel.text = @"扣除积分";
    
    subLabel.textColor = UIColorFromRGB(0xffffff);
    
    subLabel.textAlignment = NSTextAlignmentCenter;
    
    subLabel.font = AllFont(12);
    
    [subButton addSubview:subLabel];
    
    UIButton *addButton = [[UIButton alloc]initWithFrame:CGRectMake(subButton.right+Width320(16), Height320(44), Width320(60), Height320(60))];
    
    addButton.tag = 1;
    
    [addButton setBackgroundImage:[UIImage createImageWithColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.2]] forState:UIControlStateNormal];
    
    [addButton setBackgroundImage:[UIImage createImageWithColor:[UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.4]] forState:UIControlStateHighlighted];
    
    [headerBack addSubview:addButton];
    
    [addButton addTarget:self action:@selector(changeIntegral:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *addImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(22), Height320(14), Width320(16), Height320(16))];
    
    addImg.image = [UIImage imageNamed:@"button_white_add"];
    
    [addButton addSubview:addImg];
    
    UILabel *addLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, addImg.bottom+Height320(6), Width320(60), Height320(17))];
    
    addLabel.text = @"增加积分";
    
    addLabel.textColor = UIColorFromRGB(0xffffff);
    
    addLabel.textAlignment = NSTextAlignmentCenter;
    
    addLabel.font = AllFont(12);
    
    [addButton addSubview:addLabel];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, headerBack.bottom, MSW, MSH-headerBack.bottom)];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[IntegralHistoryCell class] forCellReuseIdentifier:identifier];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(35))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(16), Height320(10), Width320(200), Height320(17))];
    
    headerLabel.text = @"积分变动记录";
    
    headerLabel.textColor = UIColorFromRGB(0x666666);
    
    headerLabel.font = AllFont(12);
    
    [tableHeader addSubview:headerLabel];
    
    self.tableView.tableFooterView = [UIView new];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    self.tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingTarget:self refreshingAction:@selector(updateData)];
    
}

-(void)changeIntegral:(UIButton*)button
{
    
    if ([PermissionInfo sharedInfo].permissions.userPermission.editState || [PermissionInfo sharedInfo].permissions.personalUserPermission.editState) {
        
        StudentIntegralChangeController *svc = [[StudentIntegralChangeController alloc]init];
        
        svc.student = self.user;
        
        svc.isAdd = button.tag;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }else{
        
        [self showNoPermissionAlert];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.integralHistories.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntegralHistory *history = self.integralHistories[indexPath.row];
    
    CGSize size = [history.summary boundingRectWithSize:CGSizeMake(Width320(180), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
    
    return size.height+Height320(107);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    IntegralHistoryCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    IntegralHistory *history = self.integralHistories[indexPath.row];
    
    cell.title = history.title;
    
    cell.time = history.staffName.length?[NSString stringWithFormat:@"%@  %@",history.time,history.staffName]:history.time;
    
    cell.place = history.place;
    
    cell.summary = history.summary;
    
    cell.integral = history.integral;
    
    cell.award = history.award;
    
    cell.currentIntegral = history.currentIntegral;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
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
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}



@end
