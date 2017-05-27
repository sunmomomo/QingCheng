//
//  ProgrammeController.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "ProgrammeController.h"

#import "CalendarView.h"

#import "ProgrammeCell.h"

#import "ProgrammeInfo.h"

#import "RootController.h"

#import "WebViewController.h"

#import "MOCalendarView.h"

#import "GymListInfo.h"

#import "Gym.h"

#import "ChangeGymController.h"

#import "AgentController.h"

static NSString *identifier = @"Cell";

static NSString *titleIdentifier = @"Title";

@interface MoreButton : UIButton

{
    
    UILabel *_titleLabel;
    
    UIImageView *_imgView;
    
}

@property(nonatomic,copy)NSString *title;

@property(nonatomic,strong)UIImage *image;

@end

@implementation MoreButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, Width320(110), frame.size.height)];
        
        _titleLabel.textAlignment = NSTextAlignmentRight;
        
        _titleLabel.textColor = UIColorFromRGB(0xffffff);
        
        _titleLabel.font = STFont(15);
        
        _titleLabel.userInteractionEnabled = NO;
        
        [self addSubview:_titleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(_titleLabel.right+Width320(11), 0, frame.size.height, frame.size.height)];
        
        _imgView.layer.cornerRadius = _imgView.width/2;
        
        _imgView.layer.shadowColor = [UIColor blackColor].CGColor;
        
        _imgView.layer.shadowOffset = CGSizeMake(0, 3);
        
        _imgView.layer.shadowOpacity = 0.4;
        
        _imgView.layer.shadowRadius = 2;
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title
{
    
    _title = title;
    
    _titleLabel.text = _title;
    
}

-(void)setImage:(UIImage *)image
{
    
    _image = image;
    
    _imgView.image = _image;
    
}


@end

@interface ProgrammeController ()<CalendarViewDelegate,CalendarViewDatasource,MOCalendarViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate,MONaviDelegate>

@property(nonatomic,strong)CalendarView *calendarView;

@property(nonatomic,strong)ProgrammeInfo *programmeInfo;

@property(nonatomic,strong)ProgrammeInfo *yesterdayInfo;

@property(nonatomic,strong)ProgrammeInfo *tomorrowInfo;

@property(nonatomic,strong)UIButton *moreBtn;

@property(nonatomic,strong)UIView *moreView;

@property(nonatomic,strong)UITextField *nullTF;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)MOCalendarView *calendarInput;

@property(nonatomic,strong)UIView *blackView;

@property(nonatomic,strong)NSDate *currentDate;

@property(nonatomic,assign)NSInteger dataNum;

@property(nonatomic,strong)MoreButton *restBtn;

@property(nonatomic,strong)MoreButton *courseBtn;

@property(nonatomic,strong)MoreButton *privateBtn;

@property(nonatomic,assign)BOOL isPop;

@property(nonatomic,strong)UIView *guideView;

@end

@implementation ProgrammeController

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.currentDate = [NSDate date];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self creareUI];
    
    [self reloadData];
    
}


-(void)viewWillAppear:(BOOL)animated
{
    
    [super viewWillAppear:animated];
    
}

-(void)viewDidDisappear:(BOOL)animated
{
    
    [super viewDidDisappear:animated];
    
    [self moreHide];
    
}

- (void)didReceiveMemoryWarning {
    
    [super didReceiveMemoryWarning];
    
}

-(void)reloadTodayData
{
    
    [self createDataWithDate:_currentDate];
    
}

-(void)getDate
{
    
    self.currentDate = self.calendarView.currentDate;
    
}

-(void)createDataWithDate:(NSDate *)date
{
    
    __weak typeof(self)weakS = self;
    
    if (_currentDate) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        [df setDateFormat:@"yyyy-MM-dd"];
        
        if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:_currentDate]]) {
            
            self.currentDate = date;
            
            self.programmeInfo = [[ProgrammeInfo alloc]initWithDate:self.currentDate];
            
            self.programmeInfo.request = ^(BOOL success){
                
                if (success) {
                    
//                    [[EventManager sharedManager]saveInfo:weakS.programmeInfo];
                    
                    [weakS.calendarView reload];
                    
                    [weakS.calendarView reloadContent];
                    
                }
                
                [weakS.calendarView endRefresh];
                
            };
            
            [self.programmeInfo requestDataWithGym:self.gym];
            
            return;
            
        }
        
        if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:_currentDate]]]) {
            
            self.yesterdayInfo = self.programmeInfo;
            
            self.programmeInfo = self.tomorrowInfo;
            
//            [[EventManager sharedManager]saveInfo:self.programmeInfo];
            
            [self.calendarView reload];
            
            ProgrammeInfo *tempInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:date]];
            
            __weak typeof(ProgrammeInfo*)weakInfo = tempInfo;
            
            tempInfo.request = ^(BOOL success){
                
                weakS.tomorrowInfo = weakInfo;
                
                if (success) {
                    
                    [weakS.calendarView reload];
                    
                    [weakS.calendarView reloadContent];
                    
                }
                
                [weakS.calendarView endRefresh];
                
            };
            
            [tempInfo requestDataWithGym:self.gym];
            
            self.currentDate = date;
            
            return;
            
        }else if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:[NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate]]])
        {
            
            self.tomorrowInfo = self.programmeInfo;
            
            self.programmeInfo = self.yesterdayInfo;
            
//            [[EventManager sharedManager]saveInfo:self.programmeInfo];
            
            [self.calendarView reload];
            
            ProgrammeInfo *tempInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:date]];
            
            __weak typeof(ProgrammeInfo*)weakInfo = tempInfo;
            
            tempInfo.request = ^(BOOL success){
                
                weakS.yesterdayInfo = weakInfo;
                
                if (success) {
                    
                    [weakS.calendarView reload];
                    
                    [weakS.calendarView reloadContent];
                    
                }
                
                [weakS.calendarView endRefresh];
                
            };
            
            [tempInfo requestDataWithGym:self.gym];
            
            self.currentDate = date;
            
            return;
            
        }
    }
    
    self.dataNum = 0;
    
    self.programmeInfo = [[ProgrammeInfo alloc]initWithDate:date];
    
    self.programmeInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum++;
            
            [weakS dataFinish];
            
//            [[EventManager sharedManager]saveInfo:weakS.programmeInfo];
            
        }
        
        [weakS.calendarView endRefresh];
        
    };
    
    [self.programmeInfo requestDataWithGym:self.gym];
    
    self.yesterdayInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:date]];
    
    self.yesterdayInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum ++;
            
            [weakS dataFinish];
            
        }
        
    };
    
    [self.yesterdayInfo requestDataWithGym:self.gym];
    
    self.tomorrowInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:date]];
    
    self.tomorrowInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum ++;
            
            [weakS dataFinish];
            
        }
        
    };
    
    [self.tomorrowInfo requestDataWithGym:self.gym];
    
    self.currentDate = date;
    
}

-(void)showGuide
{
    
    if (!self.guideView) {
        
        self.guideView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
        
        self.guideView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.45];
        
        [self.view addSubview:self.guideView];
        
        [self.view bringSubviewToFront:self.moreBtn];
        
        UIImageView *guideImg = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(180), MSH-Height320(91), Width320(100), Height320(45))];
        
        guideImg.contentMode = UIViewContentModeScaleAspectFit;
        
        guideImg.image = [UIImage imageNamed:@"userguide1"];
        
        [self.guideView addSubview:guideImg];
        
    }
    
    self.guideView.hidden = NO;
    
}

-(void)reloadData
{
    
    __weak typeof(self)weakS = self;
    
    self.title = self.isGym?@"课程预约":self.gym.name.length?self.gym.name:@"全部场馆";
    
    self.dataNum = 0;
    
    self.programmeInfo = [[ProgrammeInfo alloc]initWithDate:_currentDate];
    
    self.programmeInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum++;
            
            [weakS dataFinish];
            
//            [[EventManager sharedManager]saveInfo:weakS.programmeInfo];
            
        }
        
    };
    
    [self.programmeInfo requestDataWithGym:self.gym];
    
    self.yesterdayInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate]];
    
    self.yesterdayInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum ++;
            
            [weakS dataFinish];
            
        }
        
    };
    
    [self.yesterdayInfo requestDataWithGym:self.gym];
    
    self.tomorrowInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:_currentDate]];
    
    self.tomorrowInfo.request = ^(BOOL success){
        
        if (success) {
            
            weakS.dataNum ++;
            
            [weakS dataFinish];
            
        }
        
    };
    
    [self.tomorrowInfo requestDataWithGym:self.gym];
    
}

-(void)dataFinish
{
    
    if (self.dataNum >= 3) {
        
        [self.calendarView reload];
        
        [self.calendarView reloadContent];
        
    }
    
}

-(void)creareUI
{
    
    self.title = self.isGym?@"课程预约":@"全部场馆";
    
    self.titleType = self.isGym?MONaviTitleTypeLabel:MONaviTitleTypeButton;
    
    self.calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 64,MSW, MSH-64)];
    
    self.calendarView.datasource = self;
    
    self.calendarView.delegate = self;
    
    [self.view addSubview:self.calendarView];
    
    self.moreView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.moreView.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.6];
    
    [self.moreView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreHide)]];
    
    [self.view addSubview:self.moreView];
    
    self.restBtn = [[MoreButton alloc]initWithFrame:CGRectMake(MSW-Width320(192), MSH-Height320(75), Width320(163.7), Height320(42.7))];
    
    self.restBtn.title = @"设置休息";
    
    self.restBtn.image = [UIImage imageNamed:@"agentrest"];
    
    self.restBtn.tag = 101;
    
    [self.restBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.restBtn];
    
    self.courseBtn = [[MoreButton alloc]initWithFrame:CGRectMake(self.restBtn.left, self.restBtn.top, self.restBtn.width, self.restBtn.height)];
    
    self.courseBtn.title = @"代约团课";
    
    self.courseBtn.image = [UIImage imageNamed:@"agentcourse"];
    
    self.courseBtn.tag = 102;
    
    [self.courseBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.courseBtn];
    
    self.privateBtn = [[MoreButton alloc]initWithFrame:CGRectMake(self.restBtn.left, self.courseBtn.top, self.restBtn.width, self.restBtn.height)];
    
    self.privateBtn.title = @"代约私教";
    
    self.privateBtn.image = [UIImage imageNamed:@"agentprivate"];
    
    self.privateBtn.tag = 103;
    
    [self.privateBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.privateBtn];
    
    self.moreView.hidden = YES;
    
    self.moreBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    self.moreBtn.frame = CGRectMake(MSW-Width320(75), MSH-Height320(75), Width320(49), Height320(49));
    
    self.moreBtn.layer.cornerRadius = self.moreBtn.width/2;
    
    self.moreBtn.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.moreBtn.layer.shadowOffset = CGSizeMake(0,1);
    
    self.moreBtn.layer.shadowOpacity = 0.8;
    
    self.moreBtn.layer.shadowRadius = 2;
    
    self.moreBtn.backgroundColor = kMainColor;
    
    self.moreBtn.contentMode = UIControlContentVerticalAlignmentFill;
    
    [self.moreBtn setImage:[UIImage imageNamed:@"morebutton"] forState:UIControlStateNormal];
    
    [self.moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:self.moreBtn];
    
    self.nullTF = [[UITextField alloc]initWithFrame:CGRectZero];
    
    self.nullTF.delegate = self;
    
    [self.view addSubview:self.nullTF];
    
    self.calendarInput = [[MOCalendarView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(258))];
    
    self.calendarInput.delegate = self;
    
    self.nullTF.inputView = self.calendarInput;
    
    self.blackView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, MSH)];
    
    self.blackView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.3];
    
    self.blackView.hidden = YES;
    
    [self.blackView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(blackViewTap:)]];
    
    [self.view addSubview:self.blackView];
    
}

-(void)dateSelected:(CalendarButton *)btn
{
    
    self.calendarView.currentDate = btn.date;
    
    self.blackView.hidden = YES;
    
    [self.nullTF resignFirstResponder];
    
}

-(void)naviTitleClick
{
    
    ChangeGymController *svc = [[ChangeGymController alloc]init];
    
    svc.gym = self.gym;
    
    __weak typeof(self)weakS = self;
    
    svc.changed = ^(Gym *gym){
        
        weakS.gym = gym;
        
        [weakS reloadData];
        
    };
    
    svc.permission = [Permission courseOrderPermission];
    
    [self presentViewController:svc animated:YES completion:nil];

}

-(void)blackViewTap:(UITapGestureRecognizer*)tap
{
    
    self.blackView.hidden = YES;
    
    [self.nullTF resignFirstResponder];
    
}

-(void)calendarClick
{
    
    [self.nullTF becomeFirstResponder];
    
    [self.view bringSubviewToFront:self.blackView];
    
}


-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    
    self.blackView.hidden = NO;
    
    self.calendarInput.currentDate = [NSDate date];
    
    [self.calendarInput reload];
    
    return YES;
    
}

-(void)moreShow
{
    
    self.guideView.hidden = YES;
    
    self.moreBtn.selected = YES;
    
    self.moreView.hidden = NO;
    
    [self.view bringSubviewToFront:self.moreView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.moreBtn.transform = CGAffineTransformMakeRotation(M_PI*3/4);
        
        [self.restBtn changeTop:MSH-Height320(248)];
        
        [self.courseBtn changeTop:self.restBtn.bottom+Height320(15.5)];
        
        [self.privateBtn changeTop:self.courseBtn.bottom+Height320(15.5)];
        
    } completion:^(BOOL finished) {
        
        
    }];
    
    
}

-(void)moreHide
{
    
    self.moreBtn.selected = NO;
    
    [UIView animateWithDuration:0.3f animations:^{
        
        self.moreBtn.transform = CGAffineTransformMakeRotation(0);
        
        [self.restBtn changeTop:self.moreBtn.top];
        
        [self.courseBtn changeTop:self.moreBtn.top];
        
        [self.privateBtn changeTop:self.moreBtn.top];
        
    } completion:^(BOOL finished) {
        
        self.moreView.hidden = YES;
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    self.blackView.hidden = YES;
    
    return YES;
    
}

-(void)agentClick:(MoreButton*)btn
{
    
    if (btn.tag==102) {
        
        if (![PermissionInfo sharedInfo].permissions.courseOrderPermission.addState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }else if (btn.tag == 103){
        
        if (![PermissionInfo sharedInfo].permissions.courseOrderPermission.addState) {
            
            [self showNoPermissionAlert];
            
            return;
            
        }
        
    }
    
    AgentInfo *info = [[AgentInfo alloc]init];
    
    info.type = btn.tag -101;
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(AgentInfo*)weakInfo = info;
    
    info.requestFinish = ^(BOOL success){
        
        [weakS moreHide];
        
        if (success) {
            
            if (weakInfo.gyms.count == 1) {
                
                Gym *gym = [weakInfo.gyms firstObject];
                
                WebViewController *svc = [[WebViewController alloc]init];
                
                svc.url = gym.url;
                
                svc.completeAction = ^{
                    
                    [weakS reloadData];
                    
                };
                
                [weakS.navigationController pushViewController:svc animated:YES];
                
            }else if (weakS.isGym){
                
                for (Gym *tempGym in weakInfo.gyms) {
                    
                    if (tempGym.shopId == weakS.gym.shopId && tempGym.brand.brandId == weakS.gym.brand.brandId) {
                        
                        WebViewController *svc = [[WebViewController alloc]init];
                        
                        svc.url = tempGym.url;
                        
                        svc.completeAction = ^{
                            
                            [weakS reloadData];
                            
                        };
                        
                        [weakS.navigationController pushViewController:svc animated:YES];
                        
                        break;
                        
                    }
                    
                }
                
            }
            else
            {
                
                AgentController *svc = [[AgentController alloc]init];
                
                svc.agentInfo = weakInfo;
                
                svc.title = btn.title;
                
                [weakS.navigationController pushViewController:svc animated:YES];
                
            }
            
        }
        
    };
    
    [info requestWithDate:self.calendarView.currentDate andStudent:nil];
    
}


-(void)more:(UIButton*)btn
{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        [self moreShow];
        
    }else
    {
        
        [self moreHide];
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if(tableView.tag == 201)
    {
        
        return self.yesterdayInfo.programmes.count;
        
    }else if (tableView.tag == 202)
    {
        
        return self.programmeInfo.programmes.count;
        
    }else
    {
        
        return self.tomorrowInfo.programmes.count;
        
    }
    
}

-(UIView*)emptyViewForTableView:(MOTableView *)tableView
{
    
    UIScrollView *emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.calendarView.height-Height320(54))];
    
    emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    __weak typeof(self)weakS = self;
    
    __weak typeof(UIScrollView*)weakView = emptyView;
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        
        [weakView.mj_header endRefreshing];
        
        [weakS reloadTodayData];
        
    }];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    emptyView.mj_header = header;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(106), Height320(75), Width320(105), Height320(105))];
    
    imgView.image = [UIImage imageNamed:@"programmeempty"];
    
    [emptyView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(50, imgView.bottom+Height320(19.5), MSW-100, Height320(17))];
    
    label.font = STFont(16);
    
    label.textColor = UIColorFromRGB(0x747474);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.text = @"暂无日程安排";
    
    [emptyView addSubview:label];
    
    UIButton *refreshBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    refreshBtn.frame = CGRectMake(MSW/2-Width320(58), label.bottom+Height320(19.5), Width320(116), Height320(39));
    
    refreshBtn.layer.cornerRadius = 4;
    
    refreshBtn.layer.masksToBounds = YES;
    
    refreshBtn.layer.borderColor = kMainColor.CGColor;
    
    refreshBtn.layer.borderWidth = 1;
    
    [refreshBtn setTitle:@"重 试" forState:UIControlStateNormal];
    
    [refreshBtn setTitleColor:kMainColor forState:UIControlStateNormal];
    
    [refreshBtn addTarget:self action:@selector(refresh:) forControlEvents:UIControlEventTouchUpInside];
    
    refreshBtn.hidden = YES;
    
    [emptyView addSubview:refreshBtn];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == AFNetworkReachabilityStatusNotReachable) {
             
             refreshBtn.hidden = NO;
             
             label.text = @"网络连接失败";
             
             imgView.image = [UIImage imageNamed:@"fail"];
             
         }
         
     }];
    
    return emptyView;
    
}

-(void)setSliderable:(BOOL)able
{
    
    
    
}

-(void)refresh:(UIButton*)btn
{
    
    [self reloadData];
    
}

-(void)reloadCalendarData
{
    
    [self createDataWithDate:self.calendarView.currentDate];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ProgrammeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (!cell) {
        cell = [[ProgrammeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    
    Programme *programme;
    
    switch (tableView.tag) {
        case 201:
            
            if (indexPath.row<self.yesterdayInfo.programmes.count) {
                
                programme = self.yesterdayInfo.programmes[indexPath.row];

            }
            
            break;
        case 202:
            
            if (indexPath.row<self.programmeInfo.programmes.count) {
                
                programme = self.programmeInfo.programmes[indexPath.row];

            }
            
            break;
        case 203:
            
            if (indexPath.row<self.tomorrowInfo.programmes.count) {
                
                programme = self.tomorrowInfo.programmes[indexPath.row];

            }
            
            break;
        default:
            break;
    }
    
    cell.title = programme.title;
    
    cell.coach = programme.coach.name;
    
    cell.time = [programme.startTime substringWithRange:NSMakeRange(11, 5)];
    
    cell.gym = programme.style == ProgrammeStyleRest?programme.gym.name:programme.gym.name;
    
    cell.imgUrl = programme.imgUrl;
    
    if (programme.style != ProgrammeStyleRest) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSTimeInterval timeInterval = [[df dateFromString:programme.startTime] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]];
        
        if (timeInterval <= 0) {
            
            cell.style = ProgrammeStyleCompleted;
            
            cell.total = [NSString stringWithFormat:@"共报名%ld人",(long)programme.total];
            
            if (programme.orders.count == 1) {
                
                cell.total = [NSString stringWithFormat:@"%ld人：%@",(long)[programme.orders[0][@"count"] integerValue],programme.orders[0][@"username"]];
                
            }
            
        }else
        {
            
            cell.style = ProgrammeStyleIncompleted;
            
            cell.total = [NSString stringWithFormat:@"%ld人已预约",(long)programme.total];
            
            if (programme.orders.count == 1) {
                
                cell.total = [NSString stringWithFormat:@"%ld人：%@",(long)[programme.orders[0][@"count"] integerValue],programme.orders[0][@"username"]];
                
            }
            
        }
        
        df = nil;
        
    }else
    {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSTimeInterval timeInterval = [[df dateFromString:programme.startTime] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]];
        
        if (timeInterval <= 0) {
            
            cell.style = ProgrammeStyleRestandCompleted;
            
        }else
        {
            
            cell.style = ProgrammeStyleRest;
            
        }
        
        df = nil;
        
    }
    
    cell.completedColor = programme.completedColor;
    
    cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
    
    cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
    
    return cell;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    Programme *programme;
    
    switch (tableView.tag) {
        case 201:
            
            if (indexPath.row<self.yesterdayInfo.programmes.count) {
                
                programme = self.yesterdayInfo.programmes[indexPath.row];
                
            }
            
            break;
        case 202:
            
            if (indexPath.row<self.programmeInfo.programmes.count) {
                
                programme = self.programmeInfo.programmes[indexPath.row];
                
            }
            
            break;
        case 203:
            
            if (indexPath.row<self.tomorrowInfo.programmes.count) {
                
                programme = self.tomorrowInfo.programmes[indexPath.row];
                
            }
            
            break;
        default:
            break;
    }
    
    if (programme.style == ProgrammeStyleCompleted || programme.style == ProgrammeStyleIncompleted) {
        
        return Height320(117);
        
    }else
    {
        
        return Height320(105);
        
    }
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.completeAction = ^{
       
        [weakS reloadData];
        
    };
    
    if(tableView.tag != 202)
    {
        
        return;
        
    }
    
    if (self.programmeInfo.programmes.count) {
        
        Programme *programme = self.programmeInfo.programmes[indexPath.row];
        
        svc.url = programme.url;
        
        svc.leftType = MONaviLeftTypeBack;
        
        [self.navigationController pushViewController:svc animated:YES];
        
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
