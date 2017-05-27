//
//  ScheduleReportDetailController.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/5/10.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "ScheduleReportDetailController.h"

#import "MOTableView.h"

#import "MOStarRateView.h"

#import "ScheduleReportDetailCell.h"

#import "ScheduleReportDetailInfo.h"

static NSString *identifier = @"Cell";

@interface ScheduleReportDetailController ()<MOTableViewDatasource,UITableViewDelegate>

@property(nonatomic,strong)UIImageView *courseImgView;

@property(nonatomic,strong)UILabel *courseNameLabel;

@property(nonatomic,strong)UILabel *courseTimeLabel;

@property(nonatomic,strong)UIImageView *coachImgView;

@property(nonatomic,strong)UILabel *coachNameLabel;

@property(nonatomic,strong)MOStarRateView *coachRateView;

@property(nonatomic,strong)UILabel *courseCountLabel;

@property(nonatomic,strong)UILabel *coursePriceLabel;

@property(nonatomic,strong)UILabel *courseRealLabel;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

@end

@implementation ScheduleReportDetailController

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
    
    ScheduleReportDetailInfo *info = [[ScheduleReportDetailInfo alloc]init];
    
    [info requestWithReport:self.report result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        [self.courseImgView sd_setImageWithURL:info.course.imgUrl];
        
        self.courseNameLabel.text = info.course.name;
        
        NSString *time = info.course.start;
        
        if (time.length>17) {
            
            time = [time substringToIndex:17];
            
        }
        
        self.courseTimeLabel.text = [NSString stringWithFormat:@"%@，%@",time,info.gym.name];
        
        [self.coachImgView sd_setImageWithURL:info.coach.iconUrl];
        
        self.coachNameLabel.text = info.coach.name;
        
        self.coachRateView.scorePercent = info.coach.rateScore;
        
        NSMutableAttributedString *countAstr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"%ld 人次",(long)info.serviceCount]];
        
        [countAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(countAstr.length-2, 2)];
        
        self.courseCountLabel.attributedText = countAstr;
        
        if (info.allTimeCard) {
            
            self.coursePriceLabel.text = @"- -";
            
            self.courseRealLabel.text = @"- -";
            
        }else{
            
            NSMutableArray *priceArray = [NSMutableArray array];
            
            NSString *str1 = nil;
            
            NSString *str2 = nil;
            
            if (info.price) {
                
                str1 = [NSString stringWithFormat:@"%.2f元",info.price];
                
                [priceArray addObject:str1];
                
            }
            
            if (info.times) {
                
                str2 = [NSString stringWithFormat:@"%ld次",(long)info.times];
                
                [priceArray addObject:str2];
                
            }
            
            NSString *priceStr = [priceArray componentsJoinedByString:@"+"];
            
            if (!priceStr.length) {
                
                priceStr = @"0.00元";
                
            }
            
            NSMutableAttributedString *priceAstr = [[NSMutableAttributedString alloc]initWithString:priceStr];
            
            if (str1.length && str2.length) {
                
                [priceAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(str1.length-4, 5)];
                
                [priceAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(priceAstr.length-1, 1)];
                
            }else if (str1.length){
                
                [priceAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(str1.length-4, 4)];
                
            }else if(str2.length){
                
                [priceAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(priceAstr.length-1, 1)];
                
            }else{
                
                [priceAstr addAttribute:NSFontAttributeName value:AllFont(11) range:NSMakeRange(1, 4)];
                
            }
            
            self.coursePriceLabel.attributedText = priceAstr;
            
            NSString *realStr = [NSString stringWithFormat:@"￥%.2f",info.realPrice];
            
            self.courseRealLabel.text = realStr;
            
        }
        
        self.dataArray = info.orders;
        
        [self.tableView reloadData];
        
    }];
    
}

-(void)createUI
{
    
    self.view.backgroundColor =  UIColorFromRGB(0xf4f4f4);
    
    self.title = @"课程预约";
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64) style:UITableViewStylePlain];
    
    self.tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    [self.tableView registerClass:[ScheduleReportDetailCell class] forCellReuseIdentifier:identifier];
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(215))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height(200))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    topView.layer.borderWidth = OnePX;
    
    [tableHeader addSubview:topView];
    
    self.courseImgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width(15), Height(15), Width(90), Height(90))];
    
    self.courseImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [topView addSubview:self.courseImgView];
    
    self.courseNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.courseImgView.right+Width(15), Height(15), MSW-Width(30)-self.courseImgView.right, Height(24))];
    
    self.courseNameLabel.textColor = UIColorFromRGB(0x333333);
    
    self.courseNameLabel.font = AllBFont(17);
    
    [topView addSubview:self.courseNameLabel];
    
    self.courseTimeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.courseNameLabel.left, self.courseNameLabel.bottom+Height(5), self.courseNameLabel.width, Height(20))];
    
    self.courseTimeLabel.textColor = UIColorFromRGB(0x888888);
    
    self.courseTimeLabel.font = AllFont(13);
    
    [topView addSubview:self.courseTimeLabel];
    
    self.coachImgView = [[UIImageView alloc]initWithFrame:CGRectMake(self.courseNameLabel.left, self.courseTimeLabel.bottom+Height(9), Width(24), Height(24))];
    
    self.coachImgView.layer.cornerRadius = self.coachImgView.width/2;
    
    self.coachImgView.layer.masksToBounds = YES;
    
    self.coachImgView.contentMode = UIViewContentModeScaleAspectFit;
    
    [topView addSubview:self.coachImgView];
    
    self.coachNameLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.coachImgView.right+Width(8), self.courseTimeLabel.bottom+Height(6), MSW-Width(23)-self.coachImgView.right, Height(18))];
    
    self.coachNameLabel.textColor = UIColorFromRGB(0x888888);
    
    self.coachNameLabel.font = AllFont(12);
    
    [topView addSubview:self.coachNameLabel];
    
    self.coachRateView = [[MOStarRateView alloc]initWithFrame:CGRectMake(self.coachNameLabel.left, self.coachNameLabel.bottom, Width(60), Height(10)) numberOfStars:5];
    
    [topView addSubview:self.coachRateView];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, Height(120)-OnePX, MSW, OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [topView addSubview:sep];
    
    UILabel *serviceLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height(136), MSW/3, Height(17))];
    
    serviceLabel.text = @"服务人次";
    
    serviceLabel.textColor = UIColorFromRGB(0xbbbbbb);
    
    serviceLabel.textAlignment = NSTextAlignmentCenter;
    
    serviceLabel.font = AllFont(11);
    
    [topView addSubview:serviceLabel];
    
    self.courseCountLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, serviceLabel.bottom+Height(3), (long)(MSW/3), Height(28))];
    
    self.courseCountLabel.textColor = UIColorFromRGB(0x333333);
    
    self.courseCountLabel.textAlignment = NSTextAlignmentCenter;
    
    self.courseCountLabel.font = AllFont(20);
    
    [topView addSubview:self.courseCountLabel];
    
    UILabel *priceLabel  = [[UILabel alloc]initWithFrame:CGRectMake((long)(MSW/3), serviceLabel.top, (long)(MSW/3), Height(17))];
    
    priceLabel.text = @"课程收入";
    
    priceLabel.textColor = UIColorFromRGB(0xbbbbbb);
    
    priceLabel.textAlignment = NSTextAlignmentCenter;
    
    priceLabel.font = AllFont(11);
    
    [topView addSubview:priceLabel];
    
    self.coursePriceLabel = [[UILabel alloc]initWithFrame:CGRectMake(priceLabel.left, priceLabel.bottom+Height(3), (long)(MSW/3), Height(28))];
    
    self.coursePriceLabel.textColor = UIColorFromRGB(0x333333);
    
    self.coursePriceLabel.textAlignment = NSTextAlignmentCenter;
    
    self.coursePriceLabel.font = AllFont(20);
    
    [topView addSubview:self.coursePriceLabel];
    
    UILabel *realLabel = [[UILabel alloc]initWithFrame:CGRectMake((long)(MSW/3*2), priceLabel.top, (long)(MSW/3), Height(17))];
    
    realLabel.text = @"实际收入";
    
    realLabel.textAlignment = NSTextAlignmentCenter;
    
    realLabel.textColor = UIColorFromRGB(0xbbbbbb);
    
    realLabel.font = AllFont(11);
    
    [topView addSubview:realLabel];
    
    self.courseRealLabel = [[UILabel alloc]initWithFrame:CGRectMake(realLabel.left, realLabel.bottom+Height(3), (long)(MSW/3), Height(28))];
    
    self.courseRealLabel.textColor = UIColorFromRGB(0xf9944e);
    
    self.courseRealLabel.textAlignment = NSTextAlignmentCenter;
    
    self.courseRealLabel.font = AllFont(20);
    
    [topView addSubview:self.courseRealLabel];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.dataArray.count;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return Height(173);
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ScheduleReportDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    SecheduleReportDetailModel *model = self.dataArray[indexPath.row];
    
    cell.icon = model.user.iconURL.absoluteString;
    
    cell.name = model.user.username;
    
    cell.sex = model.user.sex;
    
    cell.status = model.status;
    
    cell.phone = model.user.phone;
    
    cell.time = model.time;
    
    cell.type = model.type;
    
    if (model.type == ScheduleReportDetailPayTypeCard) {
        
        cell.card = model.card;
        
    }
    
    cell.count = model.count;
    
    cell.price = model.price;
    
    cell.realPrice = model.realPrice;
    
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
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


@end
