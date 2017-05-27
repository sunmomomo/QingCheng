//
//  ReportShowController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/14.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ReportShowController.h"

#import "CourseReportCell.h"

#import "SellReportCell.h"

#import "CheckinReportCell.h"

#import "ChangeGymController.h"

#import "UIImage+Category.h"

#import "MOFormView.h"

#import "ReportFilterController.h"

#import "MOTableView.h"

#import "ScheduleReportDetailController.h"

static NSString *identifier = @"Cell";

static NSString *titleIdentifier = @"Title";

typedef enum : NSUInteger {
    ButtonTypeLeft,
    ButtonTypeRight,
} ButtonType;

@interface ReportBtn : UIButton

{
    
    UIImageView *_arrowImg;
    
}

@property(nonatomic,assign)ButtonType type;

@end

@implementation ReportBtn

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _arrowImg = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, Width320(6.7), Height320(10.7))];
        
        _arrowImg.center = CGPointMake(frame.size.width/2, frame.size.height/2);
        
        _arrowImg.userInteractionEnabled = NO;
        
        [self addSubview:_arrowImg];
        
    }
    
    return self;
    
}

-(void)setType:(ButtonType)type
{
    
    _type = type;
    
    if (_type == ButtonTypeLeft ) {
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrowleft"];
        
    }else
    {
        
        _arrowImg.image = [UIImage imageNamed:@"cellarrow"];
        
    }
    
}

-(void)setEnabled:(BOOL)enabled
{
    
    [super setEnabled:enabled];
    
    if (enabled) {
        
        if (_type == ButtonTypeLeft ) {
            
            _arrowImg.alpha = 1;
            
        }else
        {
            
            _arrowImg.alpha = 1;
            
        }
        
    }else
    {
        
        if (_type == ButtonTypeLeft ) {
            
            _arrowImg.alpha = 0.2;
            
        }else
        {
            
            _arrowImg.alpha = 0.2;
            
        }
        
    }
    
}

@end

@interface ReportShowController ()<MOTableViewDatasource,UITableViewDelegate,MONaviDelegate,UIScrollViewDelegate,MOFormViewDatasource>

@property(nonatomic,strong)ORDetailInfo *info;

@property(nonatomic,strong)MOTableView *tableView;

@property(nonatomic,strong)MOFormView *formView1;

@property(nonatomic,strong)MOFormView *formView2;

@property(nonatomic,strong)ReportBtn *leftBtn;

@property(nonatomic,strong)ReportBtn *rightBtn;

@property(nonatomic,strong)UILabel *timeLabel;

@property(nonatomic,strong)UILabel *countLabel;

@property(nonatomic,strong)NSArray *showArray;

@property(nonatomic,assign)NSInteger *timeNum;

@property(nonatomic,strong)UIScrollView *emptyView;

@property(nonatomic,strong)UIPageControl *pageControl;

@property(nonatomic,strong)NSArray *users;

@end

@implementation ReportShowController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self createUI];
    
    [self createData];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)createData
{
    
    self.info = [[ORDetailInfo alloc]init];
    
    [self.info requestWithFilter:self.filter andGym:self.gym result:^(BOOL success, NSString *error) {
        
        self.tableView.dataSuccess = success;
        
        if (success) {
            
            [self.info filterWithFilter:self.filter];
            
            self.showArray = self.info.showReports;
            
            if (self.filter.infoType == ReportInfoTypeSchedule) {
                
                self.title = self.isGym?@"课程报表":self.gym.name.length?self.gym.name:@"全部场馆";
                
            }else if (self.filter.infoType == ReportInfoTypeSell){
                
                self.title = self.isGym?@"销售报表":self.gym.name.length?self.gym.name:@"全部场馆";
                
            }else{
                
                self.title = self.isGym?@"签到报表":self.gym.name.length?self.gym.name:@"全部场馆";
                
            }
            
            [self.formView1 reloadData];
            
            [self.formView2 reloadData];
            
            if (!self.users) {
                
                self.users = [self.info.users copy];
                
            }
            
        }
        
        [self.tableView reloadData];
        
        [self.tableView.mj_header endRefreshing];
        
    }];
    
}

-(void)createUI
{
    
    if(self.filter.infoType == ReportInfoTypeSchedule) {
        
        self.title = @"课程报表";
        
    }else if (self.filter.infoType == ReportInfoTypeSell){
        
        self.title =@"销售报表";
        
    }else{
        
        self.title = @"签到报表";
        
    }
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 64, MSW, Height320(44))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    topView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    topView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    [self.view addSubview:topView];
    
    self.leftBtn = [[ReportBtn alloc]initWithFrame:CGRectMake(0, 0, Width320(44), topView.height)];
    
    self.leftBtn.type = ButtonTypeLeft;
    
    [self.leftBtn addTarget:self action:@selector(subDate) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:self.leftBtn];
    
    self.rightBtn = [[ReportBtn alloc]initWithFrame:CGRectMake(MSW-Width320(44), 0, Width320(44), topView.height)];
    
    self.rightBtn.type = ButtonTypeRight;
    
    [self.rightBtn addTarget:self action:@selector(addDate) forControlEvents:UIControlEventTouchUpInside];
    
    self.rightBtn.enabled = NO;
    
    [topView addSubview:self.rightBtn];
    
    if (self.type == ReportTypeOther) {
        
        self.leftBtn.enabled = NO;
        
        self.rightBtn.enabled = NO;
        
    }
    
    self.timeLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.leftBtn.right,0, MSW-self.leftBtn.width*2, Height320(44))];
    
    self.timeLabel.font = AllFont(13);
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",self.filter.startDate,self.filter.endDate];
    
    self.timeLabel.textAlignment = NSTextAlignmentCenter;
    
    self.timeLabel.textColor = UIColorFromRGB(0x666666);
    
    [topView addSubview:self.timeLabel];
    
    self.tableView = [[MOTableView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, MSH-topView.bottom) style:UITableViewStylePlain];
    
    self.tableView.dataSource = self;
    
    self.tableView.delegate = self;
    
    self.tableView.tag = 101;
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.tableFooterView = [UIView new];
    
    [self.view addSubview:self.tableView];
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.tableView.mj_header = header;
    
    if (self.filter.infoType == ReportInfoTypeSchedule) {
        
        [self.tableView registerClass:[CourseReportCell class] forCellReuseIdentifier:identifier];
        
    }else if (self.filter.infoType == ReportInfoTypeSell)
    {
        
        [self.tableView registerClass:[SellReportCell class] forCellReuseIdentifier:identifier];
        
    }else{
        
        [self.tableView registerClass:[CheckinReportCell class] forCellReuseIdentifier:identifier];
        
    }
    
    UIView *tableHeader = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.filter.infoType == ReportInfoTypeSchedule?Height320(286): self.filter.infoType == ReportInfoTypeSell?Height320(287):Height320(252))];
    
    tableHeader.backgroundColor = UIColorFromRGB(0xf4f4f4);
    
    self.tableView.tableHeaderView = tableHeader;
    
    UIView *formBackView = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(6), MSW, tableHeader.height-Height320(38))];
    
    formBackView.backgroundColor = UIColorFromRGB(0xffffff);
    
    formBackView.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    formBackView.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    [tableHeader addSubview:formBackView];
    
    UIScrollView *tableScrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, formBackView.width, formBackView.height)];
    
    tableScrollView.contentSize = self.filter.infoType == ReportInfoTypeCheckin?CGSizeMake(0, 0):CGSizeMake(MSW*2, 0);
    
    tableScrollView.pagingEnabled = YES;
    
    tableScrollView.delegate = self;
    
    tableScrollView.tag = 999;
    
    tableScrollView.showsHorizontalScrollIndicator = NO;
    
    [formBackView addSubview:tableScrollView];
    
    self.formView1 = [[MOFormView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.filter.infoType == ReportInfoTypeCheckin?Height320(36)*5:Height320(36)*6)];
    
    self.formView1.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
    
    self.formView1.layer.borderWidth = 1/[UIScreen mainScreen].scale;
    
    self.formView1.lineColor = UIColorFromRGB(0xdddddd);
    
    self.formView1.tag = 101;
    
    self.formView1.datasource = self;
    
    [tableScrollView addSubview:self.formView1];
    
    if (self.filter.infoType != ReportInfoTypeCheckin) {
        
        self.formView2 = [[MOFormView alloc]initWithFrame:CGRectMake(MSW, 0, MSW, self.filter.infoType == ReportInfoTypeSchedule?Height320(36)*4:Height320(36)*5)];
        
        self.formView2.layer.borderColor = UIColorFromRGB(0xdddddd).CGColor;
        
        self.formView2.layer.borderWidth = 1/[UIScreen mainScreen].scale;
        
        self.formView2.lineColor = UIColorFromRGB(0xdddddd);
        
        self.formView2.tag = 102;
        
        self.formView2.datasource = self;
        
        [tableScrollView addSubview:self.formView2];
        
        self.pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(MSW/2-Width320(30), formBackView.height-Height320(30), Width320(60), Height320(30))];
        
        self.pageControl.numberOfPages = 2;
        
        self.pageControl.pageIndicatorTintColor = UIColorFromRGB(0xdddddd);
        
        self.pageControl.currentPageIndicatorTintColor = kMainColor;
        
        self.pageControl.userInteractionEnabled = NO;
        
        [formBackView addSubview:self.pageControl];
        
    }
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, formBackView.bottom, MSW, tableHeader.height-formBackView.bottom)];
    
    headerLabel.text = @"/报表明细/";
    
    headerLabel.textColor = UIColorFromRGB(0x999999);
    
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    headerLabel.font = AllFont(12);
    
    [tableHeader addSubview:headerLabel];
    
    UIButton *filterButton = [[UIButton alloc]initWithFrame:CGRectMake(Width320(250), MSH-Height320(69), Width320(48), Height320(48))];
    
    filterButton.layer.cornerRadius = filterButton.width/2;
    
    [filterButton setImage:[UIImage imageNamed:@"report_filter"] forState:UIControlStateNormal];
    
    filterButton.layer.shadowColor = [UIColor blackColor].CGColor;
    
    filterButton.layer.shadowOffset = CGSizeMake(0,1);
    
    filterButton.layer.shadowOpacity = 0.8;
    
    filterButton.layer.shadowRadius = 2;
    
    filterButton.contentMode = UIControlContentVerticalAlignmentFill;
    
    [self.view addSubview:filterButton];
    
    [filterButton addTarget:self action:@selector(filterClick:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)filterClick:(UIButton*)button
{
    
    ReportFilterController *svc = [[ReportFilterController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.info = self.info;
    
    svc.filter = self.filter;
    
    svc.maxDate = self.maxDate;
    
    svc.minDate = self.minDate;
    
    svc.customFinish = ^(ReportFilter* filter){
        
        weakS.filter = filter;
        
        weakS.leftBtn.enabled = NO;
        
        weakS.rightBtn.enabled = NO;
        
        [weakS.info filterWithFilter:filter];
        
        weakS.showArray = weakS.info.showReports;
        
        weakS.timeLabel.text = [NSString stringWithFormat:@"%@至%@",weakS.filter.startDate,weakS.filter.endDate];
        
        [weakS.tableView reloadData];
        
        [weakS.formView1 reloadData];
        
        [weakS.formView2 reloadData];
        
    };
    
    [self presentViewController:svc animated:YES completion:^{
        
    }];
    
}

-(NSInteger)numberOfRowsOfFormView:(MOFormView *)formView
{
    
    if (formView.tag == 101) {
        
        return  self.filter.infoType == ReportInfoTypeSchedule?4:3;
        
    }else{
        
        return  self.filter.infoType == ReportInfoTypeSchedule?3:4;
        
    }
    
}

-(NSInteger)numberOfSectionsOfFormView:(MOFormView *)formView
{
    
    if (formView.tag == 101) {
        
        return  self.filter.infoType == ReportInfoTypeCheckin?5:6;
        
    }else{
        
        return  self.filter.infoType == ReportInfoTypeSchedule?4:5;
        
    }
    
}

-(UIColor *)formView:(MOFormView *)formView colorForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.section == 0) {
        
        return UIColorFromRGB(0x999999);
        
    }else if (indexPath.section == [self numberOfSectionsOfFormView:formView]-1){
        
        return UIColorFromRGB(0x333333);
        
    }else{
        
        if (indexPath.row == 0) {
            
            return UIColorFromRGB(0x333333);
            
        }else if (((indexPath.row == 2||indexPath.row == 1)&& self.filter.infoType == ReportInfoTypeSchedule)||(self.filter.infoType == ReportInfoTypeSell && indexPath.row == 1 && formView.tag ==101)||(self.filter.infoType == ReportInfoTypeCheckin&&indexPath.row ==1)||(self.filter.infoType == ReportInfoTypeSell && (indexPath.row == 2||indexPath.row == 1) && formView.tag ==102)){
            
            return kMainColor;
            
        }else if (formView.tag == 101 && self.filter.infoType == ReportInfoTypeSell && indexPath.section == 4 && indexPath.row ==2){
            
            return UIColorFromRGB(0xEA6161);
            
        }else{
            
            return UIColorFromRGB(0xF9944E);
            
        }
        
    }
    
}

-(NSString *)formView:(MOFormView *)formView titleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (formView.tag == 101) {
        
        if (self.filter.infoType == ReportInfoTypeSchedule) {
            
            if (indexPath.section == 0) {
                
                return @[@"卡类型",@"服务人次",@"课程收入",@"实际收入"][indexPath.row];
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    return @[@"期限类型",@"次卡类型",@"储值类型",@"在线支付",@"合计"][indexPath.section-1];
                    
                }else{
                    
                    if (indexPath.section == 5 && indexPath.row == 2) {
                        
                        return nil;
                        
                    }else if (indexPath.section == 1 && indexPath.row != 1){
                        
                        return nil;
                        
                    }else{
                        
                        if (indexPath.section-1<self.info.reportCardKinds.count) {
                            
                            CourseReportCardKind *report = self.info.reportCardKinds[indexPath.section-1];
                            
                            if (indexPath.row == 1) {
                                
                                return [NSString stringWithFormat:@"%ld人次",(long)report.serviceCount];
                                
                            }else if (indexPath.row == 2){
                                
                                NSString *price = @"";
                                
                                if (report.cardKindType == CardKindTypePrepaid||report.cardKindType == CardKindTypeOnline) {
                                    
                                    if ([[NSString stringWithFormat:@"%.2f",report.price] rangeOfString:@".00"].length) {
                                        
                                        price = [NSString stringWithFormat:@"%ld",(long)report.price];
                                        
                                    }else{
                                        
                                        price = [NSString stringWithFormat:@"%.2f",report.price];
                                        
                                    }
                                    
                                }else{
                                    
                                    price = [NSString stringWithFormat:@"%ld",(long)report.price];
                                    
                                }
                                
                                return [NSString stringWithFormat:report.cardKindType == CardKindTypeCount?@"%@次":@"%@元",price];
                                
                            }else{
                                
                                NSString *price = @"";
                                
                                if (report.cardKindType == CardKindTypePrepaid || report.cardKindType == CardKindTypeOnline|| report.cardKindType == CardKindTypeNone) {
                                    
                                    if ([[NSString stringWithFormat:@"%.2f",report.receive] rangeOfString:@".00"].length) {
                                        
                                        price = [NSString stringWithFormat:@"%ld",(long)report.receive];
                                        
                                    }else{
                                        
                                        price = [NSString stringWithFormat:@"%.2f",report.receive];
                                        
                                    }
                                    
                                }else{
                                    
                                    price = [NSString stringWithFormat:@"%ld",(long)report.receive];
                                    
                                }
                                
                                return [NSString stringWithFormat:@"%@元",price];
                                
                            }
                            
                        }else{
                            
                            return nil;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }else if (self.filter.infoType == ReportInfoTypeSell){
            
            if (indexPath.section == 0) {
                
                return @[@"交易类型",@"交易笔数",@"实际收入"][indexPath.row];
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    return @[@"新购卡",@"充值",@"赠送",@"扣费",@"合计"][indexPath.section-1];
                    
                }else{
                    
                    if (indexPath.section-1<self.info.reportTrades.count) {
                        
                        SellReportTrade *report = self.info.reportTrades[indexPath.section-1];
                        
                        if (indexPath.row == 1) {
                            
                            return [NSString stringWithFormat:@"%ld笔",(long)report.tradeCount];
                            
                        }else{
                            
                            NSString *price = @"";
                            
                            if ([[NSString stringWithFormat:@"%.2f",report.receive] rangeOfString:@".00"].length) {
                                
                                price = [NSString stringWithFormat:@"%ld",(long)report.receive];
                                
                            }else{
                                
                                price = [NSString stringWithFormat:@"%.2f",report.receive];
                                
                            }
                            
                            return [NSString stringWithFormat:@"￥%@",price];
                            
                        }
                        
                    }else{
                        
                        return nil;
                        
                    }
                    
                }
                
            }
            
        }else{
            
            if (indexPath.section == 0) {
                
                return @[@"卡类型",@"签到人次",@"实际收入"][indexPath.row];
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    return @[@"期限类型",@"次卡类型",@"储值类型",@"合计"][indexPath.section-1];
                    
                }else{
                    
                    if (indexPath.row == 2 && indexPath.section == 1) {
                        
                        return nil;
                        
                    }else{
                        
                        if (indexPath.section-1<self.info.reportCardKinds.count) {
                            
                            CheckinReportCardKind *report = self.info.reportCardKinds[indexPath.section-1];
                            
                            if (indexPath.row == 1) {
                                
                                return [NSString stringWithFormat:@"%ld人次",(long)report.checkinCount];
                                
                            }else{
                                
                                NSString *price = @"";
                                
                                if ([[NSString stringWithFormat:@"%.2f",report.receive] rangeOfString:@".00"].length) {
                                    
                                    price = [NSString stringWithFormat:@"%ld",(long)report.receive];
                                    
                                }else{
                                    
                                    price = [NSString stringWithFormat:@"%.2f",report.receive];
                                    
                                }
                                
                                return [NSString stringWithFormat:@"￥%@",price];
                                
                            }
                            
                        }else{
                            
                            return nil;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }else{
        
        if (self.filter.infoType == ReportInfoTypeSchedule) {
            
            if (indexPath.section == 0) {
                
                return @[@"课程类型",@"节数",@"服务人次"][indexPath.row];
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    return @[@"团课",@"私教",@"合计"][indexPath.section-1];
                    
                }else{
                    
                    if(indexPath.section-1<self.info.reportCourses.count){
                        
                        CourseReportCourse *report = self.info.reportCourses[indexPath.section-1];
                        
                        if (indexPath.row == 1) {
                            
                            return [NSString stringWithFormat:@"%ld节",(long)report.courseCount];
                            
                        }else{
                            
                            return [NSString stringWithFormat:@"%ld人次",(long)report.serviceCount];
                            
                        }
                        
                    }else{
                        
                        return nil;
                        
                    }
                    
                }
                
            }
            
        }else{
            
            if (indexPath.section == 0) {
                
                return @[@"卡类型",@"交易笔数",@"充值",@"实际收入"][indexPath.row];
                
            }else{
                
                if (indexPath.row == 0) {
                    
                    return @[@"期限类型",@"次卡类型",@"储值类型",@"合计"][indexPath.section-1];
                    
                }else{
                    
                    if (indexPath.section == 4 && indexPath.row == 2) {
                        
                        return nil;
                        
                    }else{
                        
                        if (indexPath.section-1< self.info.reportCardKinds.count) {
                            
                            SellReportCardKind *report = self.info.reportCardKinds[indexPath.section-1];
                            
                            if (indexPath.row == 1) {
                                
                                return [NSString stringWithFormat:@"%ld笔",(long)report.tradeCount];
                                
                            }else if (indexPath.row == 2){
                                
                                NSString *price = @"";
                                
                                if (report.cardKindType == CardKindTypePrepaid) {
                                    
                                    if ([[NSString stringWithFormat:@"%.2f",report.charge] rangeOfString:@".00"].length) {
                                        
                                        price = [NSString stringWithFormat:@"%ld",(long)report.charge];
                                        
                                    }else{
                                        
                                        price = [NSString stringWithFormat:@"%.2f",report.charge];
                                        
                                    }
                                    
                                }else{
                                    
                                    price = [NSString stringWithFormat:@"%ld",(long)report.charge];
                                    
                                }
                                
                                return [NSString stringWithFormat:report.cardKindType == CardKindTypeTime?@"%@天":report.cardKindType == CardKindTypeCount?@"%@次":@"%@元",price];
                                
                            }else{
                                
                                NSString *price = @"";
                                
                                if ([[NSString stringWithFormat:@"%.2f",report.receive] rangeOfString:@".00"].length) {
                                    
                                    price = [NSString stringWithFormat:@"%ld",(long)report.receive];
                                    
                                }else{
                                    
                                    price = [NSString stringWithFormat:@"%.2f",report.receive];
                                    
                                }
                                
                                return [NSString stringWithFormat:@"￥%@",price];
                                
                            }
                            
                        }else{
                            
                            return nil;
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }
        
    }
    
}

-(UIFont *)fontOfRowOfFormView:(MOFormView *)formView
{
    
    return AllFont(13);
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 999) {
        
        self.pageControl.currentPage = scrollView.contentOffset.x/MSW;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    
    if ([self.showArray count]&&self.showArray[section]) {
        
        return [self.showArray[section][@"data"] count];
        
    }else{
        
        return 0;
        
    }
    
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return self.showArray.count;
    
}

-(UIView *)emptyViewForTableView:(MOTableView *)tableView
{
    
    self.emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH-64-Height320(65.3))];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(createData)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.emptyView.mj_header = header;
    
    UIImageView *emptyImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(64), Height320(47), Width320(180), Height320(144))];
    
    emptyImg.image = [UIImage imageNamed:@"report_empty"];
    
    [self.emptyView addSubview:emptyImg];
    
    UILabel *emptyLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, emptyImg.bottom+Height320(18), self.emptyView.width, Height320(16))];
    
    emptyLabel.textColor = UIColorFromRGB(0x999999);
    
    emptyLabel.font = STFont(14);
    
    emptyLabel.text = @"无报表数据";
    
    emptyLabel.numberOfLines = 1;
    
    emptyLabel.textAlignment  = NSTextAlignmentCenter;
    
    [self.emptyView addSubview:emptyLabel];
    
    return self.emptyView;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.filter.infoType == ReportInfoTypeSchedule) {
        
        return Height320(83);
        
    }else if (self.filter.infoType == ReportInfoTypeCheckin){
        
        return Height320(97);
        
    }else{
        
        SellReport *report = self.showArray[indexPath.section][@"data"][indexPath.row];
        
        CGSize size = [report.userName boundingRectWithSize:CGSizeMake(Width320(215), MAXFLOAT) options:NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:AllFont(12)} context:nil].size;
        
        return Height320(87)+size.height;
        
    }
    
}

-(void)setTimeNum:(NSInteger *)timeNum
{
    
    _timeNum = timeNum;
    
    if (_timeNum <= 0) {
        
        self.rightBtn.enabled = NO;
        
    }else
    {
        
        self.rightBtn.enabled = YES;
        
    }
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (self.filter.infoType == ReportInfoTypeSchedule) {
        
        CourseReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        OrderReport *report = self.showArray[indexPath.section][@"data"][indexPath.row];
        
        if (indexPath.row == 0) {
            
            cell.sectionFirst = YES;
            
            cell.month = [[[report.date componentsSeparatedByString:@"-"] objectAtIndex:1] stringByAppendingString:@"月"];
            
            cell.day = [[report.date componentsSeparatedByString:@"-"] lastObject];
            
        }else
        {
            
            cell.sectionFirst = NO;
            
        }
        
        if ([self.showArray[indexPath.section][@"data"] count] == 1) {
            
            cell.sectionLast = YES;
            
        }else{
            
            cell.sectionLast = indexPath.row == [self.showArray[indexPath.section][@"data"] count]-1;
            
        }
        
        cell.title = report.coach.name.length?[NSString stringWithFormat:@"%@ - %@",report.course.name,report.coach.name]:report.course.name;
        
        cell.startTime = [[report.start componentsSeparatedByString:@"T"] lastObject];
        
        cell.endTime = [[report.end componentsSeparatedByString:@"T"] lastObject];
        
        cell.shopName = report.gymName;
        
        cell.imgUrl = report.course.imgUrl;
        
        cell.userText = report.users;
        
        cell.courseType = report.course.type;
        
        cell.realPrice = report.realPrice;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else if (self.filter.infoType == ReportInfoTypeSell)
    {
        
        SellReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        SellReport *report = self.showArray[indexPath.section][@"data"][indexPath.row];
        
        if (indexPath.row == 0) {
            
            cell.sectionFirst = YES;
            
            cell.month = [[[report.date componentsSeparatedByString:@"-"] objectAtIndex:1] stringByAppendingString:@"月"];
            
            cell.day = [[report.date componentsSeparatedByString:@"-"] lastObject];
            
        }else
        {
            
            cell.sectionFirst = NO;
            
        }
        
        cell.sectionLast = [self.showArray[indexPath.section][@"data"] count] == 1?YES:indexPath.row == [self.showArray[indexPath.section][@"data"] count]-1;
        
        cell.title = [NSString stringWithFormat:@"%@(%ld)",report.card.cardKind.cardKindName,(long)report.card.cardId];
        
        cell.cardKindType = report.card.cardKind.type;
        
        cell.seller = report.seller.name;
        
        cell.users = report.userName;
        
        cell.payWay = report.payWay;
        
        cell.tradeType = report.tradeType;
        
        [cell setPrice:report.account andCost:report.cost];
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }else{
        
        CheckinReportCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        CheckinReport *report = self.showArray[indexPath.section][@"data"][indexPath.row];
        
        if (indexPath.row == 0) {
            
            cell.sectionFirst = YES;
            
            cell.month = [[[report.date componentsSeparatedByString:@"-"] objectAtIndex:1] stringByAppendingString:@"月"];
            
            cell.day = [[report.date componentsSeparatedByString:@"-"] lastObject];
            
        }else
        {
            
            cell.sectionFirst = NO;
            
        }
        
        cell.sectionLast = [self.showArray[indexPath.section][@"data"] count] == 1?YES:indexPath.row == [self.showArray[indexPath.section][@"data"] count]-1;
        
        cell.title = report.user.name;
        
        cell.imgURL = report.user.photo;
        
        cell.subtitle = [NSString stringWithFormat:@"%@ %@",report.createTime,report.gymName];
        
        if (report.card.cardKind.type == CardKindTypeTime) {
            
            cell.cardText = report.card.cardKind.cardKindName;
            
        }else if (report.card.cardKind.type == CardKindTypePrepaid){
            
            cell.cardText = [NSString stringWithFormat:@"%@，%ld元",report.card.cardKind.cardKindName,(long)report.cost];
            
        }else{
            
            cell.cardText = [NSString stringWithFormat:@"%@，%ld次",report.card.cardKind.cardKindName,(long)report.cost];
            
        }
        
        cell.checkinType = report.checkinType;
        
        cell.checkoutTime = report.checkoutTime;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(void)subDate
{
    
    self.timeNum = _timeNum-1;
    
    if (_timeNum <= 0) {
        
        self.rightBtn.enabled = NO;
        
    }else
    {
        
        self.rightBtn.enabled = YES;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    if (_type == ReportTypeDay) {
        
        [self setStart:[df stringFromDate:[NSDate dateWithTimeInterval:-86400 sinceDate:[df dateFromString:self.filter.startDate]]]];
        
        [self setEnd:[df stringFromDate:[NSDate dateWithTimeInterval:-86400 sinceDate:[df dateFromString:self.filter.endDate]]]];
        
    }else if (_type == ReportTypeWeek)
    {
        
        [self setStart:[df stringFromDate:[NSDate dateWithTimeInterval:-7*86400 sinceDate:[df dateFromString:self.filter.startDate]]]];
        
        [self setEnd:[df stringFromDate:[NSDate dateWithTimeInterval:-7*86400 sinceDate:[df dateFromString:self.filter.endDate]]]];
        
    }else
    {
        
        [self setEnd:[df stringFromDate:[NSDate dateWithTimeInterval:-86400 sinceDate:[df dateFromString:self.filter.startDate]]]];
        
        [self setStart:[[self.filter.endDate substringToIndex:self.filter.endDate.length-2] stringByAppendingString:@"01"]];
        
    }
    
    [self createData];
    
}

-(void)setStart:(NSString *)start
{
    
    self.filter.startDate = start;
    
    self.minDate = start;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",self.filter.startDate,self.filter.endDate];
    
}

-(void)setEnd:(NSString *)end
{
    
    self.filter.endDate = end;
    
    self.maxDate = end;
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@至%@",self.filter.startDate,self.filter.endDate];
    
}

-(void)addDate
{
    
    self.timeNum = _timeNum+1;
    
    if (_timeNum <= 0) {
        
        self.rightBtn.enabled = NO;
        
    }else
    {
        
        self.rightBtn.enabled = YES;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    if (_type == ReportTypeDay) {
        
        [self setStart:[df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:[df dateFromString:self.filter.startDate]]]];
        
        [self setEnd:[df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:[df dateFromString:self.filter.endDate]]]];
        
    }else if (_type == ReportTypeWeek)
    {
        
        [self setStart:[df stringFromDate:[NSDate dateWithTimeInterval:7*86400 sinceDate:[df dateFromString:self.filter.startDate]]]];
        
        [self setEnd:[df stringFromDate:[NSDate dateWithTimeInterval:7*86400 sinceDate:[df dateFromString:self.filter.endDate]]]];
        
    }else if(_type == ReportTypeMonth)
    {
        
        [self setStart:[df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:[df dateFromString:self.filter.endDate]]]];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
        
        NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:[df dateFromString:self.filter.startDate]];
        
        NSUInteger numberOfDaysInMonth = range.length;
        
        [self setEnd:[NSString stringWithFormat:@"%@%ld",[self.filter.startDate substringToIndex:self.filter.startDate.length-2],(unsigned long)numberOfDaysInMonth]];
        
    }
    
    [self createData];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if (self.filter.infoType == ReportInfoTypeSchedule) {
        
        ScheduleReportDetailController *svc = [[ScheduleReportDetailController alloc]init];
        
        OrderReport *report = self.showArray[indexPath.section][@"data"][indexPath.row];
        
        svc.report = report;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
}

@end
