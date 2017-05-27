//
//  CardConsumeRecordController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CardConsumeRecordController.h"

#import "ReportCell.h"

#import "CardRecordInfo.h"

#import "QCTextField.h"

#import "RecordCalendarView.h"

static NSString *identifier = @"Cell";

@interface CardConsumeRecordController ()<UITableViewDelegate,MOTableViewDatasource,RecordCalendarViewDelegate,RecordCalendarViewDatasource>

@property(nonatomic,strong)NSMutableArray *infos;

@property(nonatomic,strong)QCTextField *remainTF;

@property(nonatomic,strong)QCTextField *totalRechargeTF;

@property(nonatomic,strong)QCTextField *totalCostTF;

@property(nonatomic,strong)RecordCalendarView *calendarView;

@end

@implementation CardConsumeRecordController

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
    
    self.infos = [NSMutableArray array];
    
    for (NSInteger i = 0; i<12; i++) {
        
        CardRecordInfo *info = [[CardRecordInfo alloc]init];
        
        info.month = i+1;
        
        [self.infos addObject:info];
        
    }
    
    CardRecordInfo *currentInfo = self.infos[self.calendarView.currentMonth-1];
    
    __weak typeof(self)weakS = self;
    
    currentInfo.requestFinish = ^(BOOL success){
        
        [weakS.calendarView reloadDataAtMonth:self.calendarView.currentMonth];
        
    };
    
    [currentInfo requestWithCard:self.card withMonth:self.calendarView.currentMonth andYear:self.calendarView.year];
    
}

-(void)createUI
{
    
    self.title = @"消费记录";
    
    UIView *headerView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, self.card.cardKind.type == CardKindTypeTime?Height320(40):Height320(108))];
    
    headerView.backgroundColor = UIColorFromRGB(0x797B7A);
    
    self.remainTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(12), 0, MSW-Width320(24), Height320(40))];
    
    self.remainTF.backgroundColor = [UIColor clearColor];
    
    self.remainTF.placeholder = @"余额：";
    
    self.remainTF.font = AllFont(14);
    
    self.remainTF.placeholderColor = UIColorFromRGB(0xffffff);
    
    self.remainTF.text = [NSString stringWithFormat:@"%@",self.remain];
    
    self.remainTF.textColor = UIColorFromRGB(0xffffff);
    
    self.remainTF.userInteractionEnabled = NO;
    
    self.remainTF.noLine = YES;
    
    [headerView addSubview:self.remainTF];
    
    if (self.card.cardKind.type != CardKindTypeTime) {
        
        UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, self.remainTF.bottom-1, MSW, 1)];
        
        line.backgroundColor = UIColorFromRGB(0xffffff);
        
        [headerView addSubview:line];
        
        self.totalRechargeTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(13), self.remainTF.bottom, MSW-Width320(26), Height320(34))];
        
        self.totalRechargeTF.backgroundColor = [UIColor clearColor];
        
        self.totalRechargeTF.placeholder = @"累积充值：";
        
        self.totalRechargeTF.text = [NSString stringWithFormat:@"%@%@",self.totalRecharge,self.card.cardKind.type == CardKindTypePrepaid?@"元":@"次"];
        
        self.totalRechargeTF.placeholderColor = UIColorFromRGB(0xffffff);
        
        self.totalRechargeTF.textColor = UIColorFromRGB(0xffffff);
        
        self.totalRechargeTF.userInteractionEnabled = NO;
        
        self.totalRechargeTF.noLine = YES;
        
        self.totalRechargeTF.font = AllFont(12);
        
        [headerView addSubview:self.totalRechargeTF];
        
        self.totalCostTF = [[QCTextField alloc]initWithFrame:CGRectMake(Width320(13), self.totalRechargeTF.bottom, self.totalRechargeTF.width, self.totalRechargeTF.height)];
        
        self.totalCostTF.backgroundColor = [UIColor clearColor];
        
        self.totalCostTF.placeholder = @"累积消费：";
        
        self.totalCostTF.text = [NSString stringWithFormat:@"%@%@",self.totalCost,self.card.cardKind.type == CardKindTypePrepaid?@"元":@"次"];
        
        self.totalCostTF.placeholderColor = UIColorFromRGB(0xffffff);
        
        self.totalCostTF.textColor = UIColorFromRGB(0xffffff);
        
        self.totalCostTF.userInteractionEnabled = NO;
        
        self.totalCostTF.noLine = YES;
        
        self.totalCostTF.font = AllFont(12);
        
        [headerView addSubview:self.totalCostTF];
        
    }
    
    [self.view addSubview:headerView];
    
    self.calendarView = [[RecordCalendarView alloc]initWithFrame:CGRectMake(0, headerView.bottom, MSW, MSH-headerView.bottom)];
    
    self.calendarView.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.calendarView.datasource = self;
    
    self.calendarView.delegate = self;
    
    [self.view addSubview:self.calendarView];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    CardRecordInfo *info = self.infos[tableView.tag];
    
    return info.records.count;
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    CardRecordInfo *info = self.infos[tableView.tag];
    
    CardRecord *record = info.records[indexPath.row];
    
    cell.sectionFirst = record.first;
    
    cell.month = [NSString stringWithFormat:@"%@月",record.month];
    
    cell.day = record.date;
    
    cell.rightTitle = record.cost;
    
    if (record.type ==2) {
        
        cell.title = record.course.name;
        
        cell.subtitle = [NSString stringWithFormat:@"%@  %@ %ld人",record.courseTime,record.courseUser,(long)record.courseUserCount];
        
        cell.imgUrl = record.course.imgUrl;
        
    }else
    {
        
        cell.imgUrl = record.imgURL;
        
        cell.title = record.typeName;
        
        cell.subtitle = record.seller.length?[NSString stringWithFormat:@"%@ 销售%@",record.createTime,record.seller]:record.createTime;
        
    }
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height320(63);
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    return Height320(37);
    
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(37))];
    
    CardRecordInfo *info = self.infos[tableView.tag];
    
    header.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    UILabel *monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(13), 0, Width320(150), Height320(37))];
    
    monthLabel.text = [NSString stringWithFormat:tableView.tag>9?@"%ld-%ld":@"%ld-0%ld",(long)self.calendarView.year,(long)(tableView.tag+1)];
    
    monthLabel.textColor = UIColorFromRGB(0x999999);
    
    monthLabel.font = AllFont(12);
    
    [header addSubview:monthLabel];
    
    UIImageView *upImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(159), Height320(12), Width320(13), Height320(13))];
    
    upImg.image = [UIImage imageNamed:@"record_increase"];
    
    [header addSubview:upImg];
    
    UILabel *upLabel = [[UILabel alloc]initWithFrame:CGRectMake(upImg.right+Width320(4), 0, Width320(53), Height320(37))];
    
    upLabel.text = info.totalCharge;
    
    upLabel.textColor = kMainColor;
    
    upLabel.font = AllFont(12);
    
    [header addSubview:upLabel];
    
    UIImageView *downImg = [[UIImageView alloc]initWithFrame:CGRectMake(upLabel.right+Width320(8), Height320(12), Width320(13), Height320(13))];
    
    downImg.image = [UIImage imageNamed:@"record_decrease"];
    
    [header addSubview:downImg];
    
    UILabel *downLabel = [[UILabel alloc]initWithFrame:CGRectMake(downImg.right+Width320(4), 0, Width320(53), Height320(37))];
    
    downLabel.text = info.totalCost;
    
    downLabel.textColor = UIColorFromRGB(0xEA6161);
    
    downLabel.font = AllFont(12);
    
    [header addSubview:downLabel];
    
    return header;
    
}

-(MOTableView *)tableViewForMonth:(NSInteger)month
{
    
    MOTableView *tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-Height320(166)-64) style:UITableViewStylePlain];
    
    tableView.tag = month-1;
    
    tableView.delegate = self;
    
    tableView.dataSource = self;
    
    [tableView registerClass:[ReportCell class] forCellReuseIdentifier:identifier];
    
    tableView.tableFooterView = [UIView new];
    
    __weak typeof(self)weakS = self;
    
    tableView.mj_footer = [MJRefreshAutoFooter footerWithRefreshingBlock:^{
        
        CardRecordInfo *info = weakS.infos[month-1];
        
        [info update];
        
    }];
    
    tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    return tableView;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

-(void)yearChanged
{
    
    [self createData];
    
}

-(void)changedMonth:(NSInteger)month
{
    
    CardRecordInfo *info = self.infos[month-1];
    
    __weak typeof(self)weakS = self;
    
    info.requestFinish = ^(BOOL success){
        
        [weakS.calendarView reloadDataAtMonth:month];
        
    };
    
    [info requestWithCard:self.card withMonth:month andYear:self.calendarView.year];
    
}

@end
