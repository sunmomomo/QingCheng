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

#import "MessageInfo.h"

#import "MessageController.h"

#import "RootController.h"

#import "WebViewController.h"

#import "MOCalendarView.h"

#import "EventManager.h"

#import "MyGymInfo.h"

#import "ChangeGymController.h"

#import "AppDelegate.h"

#import "AgentInfo.h"

#import "AgentController.h"

#import "ServicesInfo.h"

#import "ProgrammeGymCell.h"

#import "MineHomePageController.h"

static NSString *identifier = @"Cell";

static NSString *titleIdentifier = @"Title";

static NSString *headIdentifier = @"Head";

static NSString *gymIdentifier = @"Gym";

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
        
        UIImageView *titleBack = [[UIImageView alloc]initWithFrame:CGRectMake(0, Height320(5), Width320(60), frame.size.height-Height320(10))];
        
        titleBack.image = [UIImage imageNamed:@"more_button_back"];
        
        titleBack.layer.shadowColor = UIColorFromRGB(0x000000).CGColor;
        
        titleBack.layer.shadowOpacity = 0.3;
        
        titleBack.layer.shadowRadius = 2;
        
        titleBack.layer.shadowOffset = CGSizeMake(0, 1);
        
        [self addSubview:titleBack];
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(5), Width320(60), frame.size.height-Height320(10))];
        
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
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

@interface ProgrammeController ()<CalendarViewDelegate,CalendarViewDatasource,MOMonthViewDelegate,UITableViewDataSource,UITableViewDelegate,UITextFieldDelegate>

{
    
    UIWindow *_gymWindow;
    
    UIWindow *_calenderWindow;
    
}

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)CalendarView *calendarView;

@property(nonatomic,strong)ProgrammeInfo *programmeInfo;

@property(nonatomic,strong)ProgrammeInfo *yesterdayInfo;

@property(nonatomic,strong)ProgrammeInfo *tomorrowInfo;

@property(nonatomic,strong)MessageInfo *msgInfo;

@property(nonatomic,strong)UIButton *moreBtn;

@property(nonatomic,strong)UIView *moreBtnBackView;

@property(nonatomic,strong)UIView *moreView;

@property(nonatomic,strong)UITextField *nullTF;

@property(nonatomic,strong)UIDatePicker *datePicker;

@property(nonatomic,strong)MOMonthView *monthView;

@property(nonatomic,strong)NSDate *currentDate;

@property(nonatomic,strong)MoreButton *restBtn;

@property(nonatomic,strong)MoreButton *courseBtn;

@property(nonatomic,strong)MoreButton *privateBtn;

@property(nonatomic,strong)UIImageView *guideView1;

@property(nonatomic,strong)UIImageView *guideView2;

@property(nonatomic,strong)UIImageView *noProgrammeGuideView;

@property(nonatomic,strong)ProgrammeInfo *thisWeekInfo;

@property(nonatomic,strong)ProgrammeInfo *lastWeekInfo;

@property(nonatomic,strong)ProgrammeInfo *nextWeekInfo;

@property(nonatomic,strong)NSArray *agentArray;

@property(nonatomic,copy)NSString *agentDate;

@property(nonatomic,assign)BOOL dataSuccess;

@property(nonatomic,strong)UIScrollView *emptyView;

@end

@implementation ProgrammeController

-(instancetype)init
{
    
    if (self = [super init]) {
        
        self.tabTitle = @"课程";
        
        self.selectedImg = [UIImage imageNamed:@"course_selected"];
        
        self.unselectImg = [UIImage imageNamed:@"course_unselect"];
        
        self.currentDate = [NSDate date];
        
    }
    
    return self;
    
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    
    [self creareUI];
    
    [self reloadData];
    
}

-(void)reloadTodayData
{
    
    [self createDataWithDate:_currentDate];
    
}

-(void)getDate
{
    
    _currentDate = self.calendarView.currentDate;
    
}

-(void)createDataWithDate:(NSDate *)date
{
    
    if (_currentDate) {
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        [df setDateFormat:@"yyyy-MM-dd"];
        
        if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:_currentDate]]) {
            
            self.currentDate = date;
            
            ProgrammeInfo *todayInfo = [[ProgrammeInfo alloc]initWithDate:self.currentDate];
            
            [todayInfo requestDataResult:^(BOOL success, NSString *error) {
                
                self.dataSuccess = YES;
                
                if (success) {
                
                    self.programmeInfo = [todayInfo copy];
                    
                    [[EventManager sharedManager]saveInfo:self.programmeInfo];
                    
                    if (![self.programmeInfo getShowDataWithGym:self.gym].count&& ![self.programmeInfo havePrivateWithGym:self.gym]) {
                        
                        [self showNoProgrammeView];
                        
                    }
                    
                }
                
                [self.calendarView reloadAtIndex:1];
                
                [self.calendarView reloadContent];
                
                [self.calendarView endRefresh];
                
            }];
            
            return;
            
        }
        
        if (self.dataSuccess) {
            
            if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:[NSDate dateWithTimeInterval:86400 sinceDate:_currentDate]]]) {
                
                self.yesterdayInfo = [self.programmeInfo copy];
                
                self.programmeInfo = [self.tomorrowInfo copy];
                
                if (![self.programmeInfo getShowDataWithGym:self.gym].count && ![self.programmeInfo havePrivateWithGym:self.gym]) {
                    
                    [self showNoProgrammeView];
                    
                }
                
                [self.calendarView reloadAtIndex:0];
                
                [self.calendarView reloadAtIndex:1];
                
                ProgrammeInfo *tempInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:self.programmeInfo.startDate]];
                
                [tempInfo requestDataResult:^(BOOL success, NSString *error) {
                    
                    self.dataSuccess = YES;
                    
                    if (success) {
                        
                        self.tomorrowInfo = [tempInfo copy];
                        
                    }
                    
                    [self.calendarView reloadAtIndex:2];
                    
                    [self.calendarView reloadContent];
                    
                    [self.calendarView endRefresh];
                    
                }];
                
                self.currentDate = date;
                
                return;
                
            }else if ([[df stringFromDate:date] isEqualToString:[df stringFromDate:[NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate]]])
            {
                
                self.tomorrowInfo = [self.programmeInfo copy];
                
                self.programmeInfo = [self.yesterdayInfo copy];
                
                if (![self.programmeInfo getShowDataWithGym:self.gym].count&& ![self.programmeInfo havePrivateWithGym:self.gym]) {
                    
                    [self showNoProgrammeView];
                    
                }
                
                [self.calendarView reloadAtIndex:1];
                
                [self.calendarView reloadAtIndex:2];
                
                ProgrammeInfo *tempInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:self.programmeInfo.startDate]];
                
                [tempInfo requestDataResult:^(BOOL success, NSString *error) {
                    
                    self.dataSuccess = YES;
                    
                    if (success) {
                        
                        self.yesterdayInfo = [tempInfo copy];
                        
                    }
                    
                    [self.calendarView reloadAtIndex:0];
                    
                    [self.calendarView reloadContent];
                    
                    [self.calendarView endRefresh];
                    
                }];
                
                self.currentDate = date;
                
                return;
                
            }
            
        }
        
    }
    
    self.currentDate = date;
    
    ProgrammeInfo *todayInfo = [[ProgrammeInfo alloc]initWithDate:self.currentDate];
    
    [todayInfo requestDataResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            self.programmeInfo = [todayInfo copy];
            
            [[EventManager sharedManager]saveInfo:self.programmeInfo];
            
            if (![self.programmeInfo getShowDataWithGym:self.gym].count&& ![self.programmeInfo havePrivateWithGym:self.gym]) {
                
                [self showNoProgrammeView];
                
            }
            
        }
        
        [self.calendarView reloadAtIndex:1];
        
        [self.calendarView reloadContent];
        
        [self.calendarView endRefresh];
        
    }];
    
    ProgrammeInfo *yesterdayInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:date]];
    
    [yesterdayInfo requestDataResult:^(BOOL success, NSString *error) {
        
        self.yesterdayInfo = [yesterdayInfo copy];
        
        [self.calendarView reloadAtIndex:0];
        
        [self.calendarView reloadContent];
        
    }];
    
    ProgrammeInfo *tomorrowInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:date]];
    
    [tomorrowInfo requestDataResult:^(BOOL success, NSString *error) {
        
        self.tomorrowInfo = [tomorrowInfo copy];
        
        [self.calendarView reloadAtIndex:2];
        
        [self.calendarView reloadContent];
        
    }];
    
    self.currentDate = date;
    
}

-(void)showGuide
{
    
    if (!self.guideView1) {
        
        self.guideView1 = [[UIImageView alloc]initWithFrame:CGRectMake(10, 64, Width320(191), Height320(34))];
        
        self.guideView1.image = [UIImage imageNamed:@"programme_guide_1"];
        
        self.guideView1.contentMode = UIViewContentModeScaleAspectFill;
        
        [self.view addSubview:self.guideView1];
        
    }
    
    if (!self.guideView2) {
        
        self.guideView2 = [[UIImageView alloc]initWithFrame:CGRectMake(MSW-Width320(165), MSH-49-Height320(110), Width320(155), Height320(33))];
        
        self.guideView2.image = [UIImage imageNamed:@"programme_guide_2"];
        
        self.guideView2.contentMode = UIViewContentModeScaleAspectFill;
        
        self.guideView2.hidden = YES;
        
        [self.view addSubview:self.guideView2];
        
    }
    
}

-(void)reloadWeekDataWithType:(TimeType)timeType
{
    
    if (timeType == TimeTypeNow) {
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
        
        [calendar setTimeZone: timeZone];
        
        NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
        
        NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:self.currentDate]]];
        
        self.currentDate = [NSDate dateWithTimeInterval:(theComponents.weekday-1)*-86400 sinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:self.currentDate]]];

        [self.calendarView onlySetDate:self.currentDate];
        
        ProgrammeInfo *thisInfo = [[ProgrammeInfo alloc]init];
        
        [thisInfo requestWeekDataWithDate:self.currentDate result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.thisWeekInfo = [thisInfo copy];
                
            }
            
            [self.calendarView reloadWeekViewAtIndex:1];
            
            [self.calendarView reloadContent];
            
        }];
        
        ProgrammeInfo *lastInfo = [[ProgrammeInfo alloc]init];
        
        [lastInfo requestWeekDataWithDate:[NSDate dateWithTimeInterval:-7*86400 sinceDate:self.currentDate] result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.lastWeekInfo = [lastInfo copy];
                
            }
            
            [self.calendarView reloadWeekViewAtIndex:0];
            
        }];
        
        ProgrammeInfo *nextInfo = [[ProgrammeInfo alloc]init];
        
        [nextInfo requestWeekDataWithDate:[NSDate dateWithTimeInterval:7*86400 sinceDate:self.currentDate] result:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.nextWeekInfo = [nextInfo copy];
                
            }
            
            [self.calendarView reloadWeekViewAtIndex:2];
            
        }];
        
    }else if (timeType == TimeTypeFuture){
        
        ProgrammeInfo *nextInfo = [[ProgrammeInfo alloc]init];
        
        [nextInfo requestWeekDataWithDate:[NSDate dateWithTimeInterval:7*86400 sinceDate:self.currentDate] result:^(BOOL success, NSString *error) {
            
            self.lastWeekInfo = [self.thisWeekInfo copy];
            
            self.thisWeekInfo = [self.nextWeekInfo copy];
            
            if (success) {
                
                self.nextWeekInfo = [nextInfo copy];
                
            }
            
            [self.calendarView reloadWeekViewAtIndex:0];
            
            [self.calendarView reloadWeekViewAtIndex:1];
            
            [self.calendarView reloadWeekViewAtIndex:2];
            
            [self.calendarView reloadContent];
            
        }];
        
    }else{
        
        ProgrammeInfo *lastInfo = [[ProgrammeInfo alloc]init];
        
        [lastInfo requestWeekDataWithDate:[NSDate dateWithTimeInterval:-7*86400 sinceDate:self.currentDate] result:^(BOOL success, NSString *error) {
            
            self.nextWeekInfo = [self.thisWeekInfo copy];
            
            self.thisWeekInfo = [self.lastWeekInfo copy];
            
            if (success) {
                
                self.lastWeekInfo = [lastInfo copy];
                
            }
            
            [self.calendarView reloadWeekViewAtIndex:0];
            
            [self.calendarView reloadWeekViewAtIndex:1];
            
            [self.calendarView reloadWeekViewAtIndex:2];
            
            [self.calendarView reloadContent];
            
        }];
        
    }
    
}

-(void)weekViewChooseProgrammesWithDate:(NSDate *)date
{
    
    self.calendarView.type = CalendarViewTypeDay;
    
    self.calendarView.currentDate = date;
    
}

-(void)weekViewChooseProgramme:(Programme *)programme
{
    
    WebViewController *svc = [[WebViewController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.completeAction = ^{
        
        [weakS reloadData];
        
    };
    
    svc.url = programme.url;
    
    svc.leftType = MONaviLeftTypeBack;
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(NSArray *)programmesAtIndex:(NSInteger)index
{
    
    if (index == 0) {
        
        return [self.lastWeekInfo getShowDataWithGym:self.gym];
        
    }else if (index == 1){
        
        return [self.thisWeekInfo getShowDataWithGym:self.gym];
        
    }else{
        
        return [self.nextWeekInfo getShowDataWithGym:self.gym];
        
    }
    
}

-(void)reloadData
{
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        [[EventManager sharedManager]getEvent];
        
    });
    
    self.title = self.gym.name.length?self.gym.name:@"全部课程";
    
    if (self.calendarView.isWeek) {
        
        [self reloadWeekDataWithType:TimeTypeNow];
        
    }else{
        
        ProgrammeInfo *info = [[ProgrammeInfo alloc]initWithDate:_currentDate];
        
        [info requestDataResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.programmeInfo = [info copy];
                
                [self.calendarView reloadAtIndex:1];
                
                [self.calendarView reloadContent];
                
                [[EventManager sharedManager]saveInfo:self.programmeInfo];
                
                if (![self.programmeInfo getShowDataWithGym:self.gym].count&& ![self.programmeInfo havePrivateWithGym:self.gym]) {
                    
                    [self showNoProgrammeView];
                    
                }
                
            }
            
        }];
        
        ProgrammeInfo *yesterdayInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate]];
        
        [yesterdayInfo requestDataResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.yesterdayInfo = [yesterdayInfo copy];
                
                [self.calendarView reloadAtIndex:0];
                
                [self.calendarView reloadContent];
                
            }
            
        }];
        
        ProgrammeInfo *tomorrowInfo = [[ProgrammeInfo alloc]initWithDate:[NSDate dateWithTimeInterval:86400 sinceDate:_currentDate]];
        
        [tomorrowInfo requestDataResult:^(BOOL success, NSString *error) {
            
            if (success) {
                
                self.tomorrowInfo = [tomorrowInfo copy];
                
                [self.calendarView reloadAtIndex:2];
                
                [self.calendarView reloadContent];
                
            }
            
        }];
        
    }
    
    [self refreshMessage];
    
}

-(void)creareUI
{
    
    self.view.backgroundColor = UIColorFromRGB(0xffffff);
    
    self.leftTitle = @"我的主页";
    
    self.rightType = MONaviRightTypeRing;
    
    self.titleType = MONaviTitleTypeButton;
    
    self.title = self.gym.name.length?self.gym.name:@"全部课程";
    
    self.calendarView = [[CalendarView alloc]initWithFrame:CGRectMake(0, 64,MSW, MSH-64-49)];
    
    self.calendarView.datasource = self;
    
    self.calendarView.delegate = self;
    
    [self.view addSubview:self.calendarView];
    
    self.moreView = [[UIView alloc]initWithFrame:self.view.bounds];
    
    self.moreView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.9];
    
    [self.moreView addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(moreHide)]];
    
    [self.view addSubview:self.moreView];
    
    self.restBtn = [[MoreButton alloc]initWithFrame:CGRectMake(MSW-Width320(129), MSH-Height320(75)-49, Width320(108), Height320(38))];
    
    self.restBtn.title = @"设置休息";
    
    self.restBtn.image = [UIImage imageNamed:@"agent_rest"];
    
    self.restBtn.tag = 101;
    
    [self.restBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.restBtn];
    
    self.courseBtn = [[MoreButton alloc]initWithFrame:CGRectMake(self.restBtn.left, self.restBtn.top, self.restBtn.width, self.restBtn.height)];
    
    self.courseBtn.title = @"代约团课";
    
    self.courseBtn.image = [UIImage qingchengImageWithName:@"agent_group"];
    
    self.courseBtn.tag = 102;
    
    [self.courseBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.courseBtn];
    
    self.privateBtn = [[MoreButton alloc]initWithFrame:CGRectMake(self.restBtn.left, self.courseBtn.top, self.restBtn.width, self.restBtn.height)];
    
    self.privateBtn.title = @"代约私教";
    
    self.privateBtn.image = [UIImage qingchengImageWithName:@"agent_private"];
    
    self.privateBtn.tag = 103;
    
    [self.privateBtn addTarget:self action:@selector(agentClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreView addSubview:self.privateBtn];
    
    self.moreView.hidden = YES;
    
    self.moreBtnBackView = [[UIView alloc]initWithFrame:CGRectMake(MSW-Width320(64), MSH-Height320(75)-49, Width320(48), Height320(48))];
    
    self.moreBtnBackView.backgroundColor = kMainColor;
    
    self.moreBtnBackView.layer.cornerRadius = self.moreBtnBackView.width/2;
    
    self.moreBtnBackView.layer.shadowColor = [UIColor blackColor].CGColor;
    
    self.moreBtnBackView.layer.shadowOffset = CGSizeMake(0,1);
    
    self.moreBtnBackView.layer.shadowOpacity = 0.8;
    
    self.moreBtnBackView.layer.shadowRadius = 2;
    
    [self.view addSubview:self.moreBtnBackView];
    
    self.moreBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, self.moreBtnBackView.width, self.moreBtnBackView.height)];
    
    self.moreBtn.layer.cornerRadius = self.moreBtn.width/2;
    
    self.moreBtn.layer.masksToBounds = YES;
    
    self.moreBtn.backgroundColor = kMainColor;
    
    self.moreBtn.contentMode = UIControlContentVerticalAlignmentFill;
    
    [self.moreBtn setImage:[UIImage imageNamed:@"morebutton"] forState:UIControlStateNormal];
    
    [self.moreBtn addTarget:self action:@selector(more:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.moreBtnBackView addSubview:self.moreBtn];
    
}

-(void)monthViewSelectDate:(NSDate *)date
{
    
    self.calendarView.currentDate = date;
    
    [self createDataWithDate:date];
    
    [self closeMonthView];
    
}

-(void)naviTitleClick
{
    
    if (_calenderWindow) {
        
        [self closeMonthView];
        
    }
    
    ChangeGymController *svc = [[ChangeGymController alloc]init];
    
    __weak typeof(self)weakS = self;
    
    svc.gym = weakS.gym;
    
    svc.allTitle = @"全部课程";
    
    svc.changed = ^(Gym *gym){
        
        weakS.gym = gym;
        
        [weakS reloadTodayData];
        
        [weakS reloadWeekDataWithType:TimeTypeNow];
        
        weakS.title = weakS.gym.name.length?weakS.gym.name:@"全部课程";
        
    };
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)calendarClick
{
    
    _calenderWindow = [[UIWindow alloc]initWithFrame:CGRectMake(0, 64, MSW, MSH-64)];
    
    _calenderWindow.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
    
    [_calenderWindow makeKeyAndVisible];
    
    [_calenderWindow addGestureRecognizer:[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(closeMonthView)]];
    
    self.monthView = [[MOMonthView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(258))];
    
    self.monthView.delegate = self;
    
    self.monthView.date = self.currentDate;
    
    self.monthView.selectDate = self.currentDate;
    
    [_calenderWindow addSubview:self.monthView];
    
}

-(void)closeMonthView
{
    
    [_calenderWindow resignKeyWindow];
    
    _calenderWindow.hidden = YES;
    
    _calenderWindow = nil;
    
    _monthView = nil;
    
}

-(void)moreShow
{
    
    [self.calendarView hideAgent];
    
    if (self.guideView2) {
        
        self.guideView2.hidden = YES;
        
        [self.guideView2 removeFromSuperview];
        
        self.guideView2 = nil;
        
        if (self.noProgrammeGuideView) {
            
            [self showNoProgrammeView];
            
        }
        
    }
    
    self.moreBtn.selected = YES;
    
    self.moreView.hidden = NO;
    
    [self.view bringSubviewToFront:self.moreView];
    
    [UIView animateWithDuration:0.3f animations:^{
        
        [self.view bringSubviewToFront:self.moreBtnBackView];
        
        self.moreBtn.transform = CGAffineTransformMakeRotation(M_PI*3/4);
        
        [self.restBtn changeTop:MSH-Height320(248)-49];
        
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
        
        [self.restBtn changeTop:self.moreBtnBackView.top];
        
        [self.courseBtn changeTop:self.moreBtnBackView.top];
        
        [self.privateBtn changeTop:self.moreBtnBackView.top];
        
    } completion:^(BOOL finished) {
        
        self.moreView.hidden = YES;
        
        [RootController sharedSliderController].tabbarShadeView.hidden = YES;
        
    }];
    
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    
    return YES;
    
}

-(void)agentClick:(MoreButton*)btn
{
    
    [self moreHide];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy-MM-dd";
    
    [self agentClickWithType:btn.tag - 101 andDate:[df stringFromDate:self.currentDate]];
    
}

-(void)agentClickWithType:(AgentType)agentType andDate:(NSString *)date
{
    
    [[ServicesInfo shareInfo]requestSuccess:^{
        
        if ([ServicesInfo shareInfo].services.count==1) {
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            Gym *gym = [[ServicesInfo shareInfo].services firstObject];
            
            if(agentType == AgentTypeRest){
                
                svc.url = date.length?[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/rest/?model=%@&id=%ld&date=%@",ROOT,gym.type,(long)gym.gymId,date]]:[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/rest/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId]];
                
            }else if (agentType == AgentTypeGroup) {
                
                svc.url = date.length?[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/group/?model=%@&id=%ld&date=%@",ROOT,gym.type,(long)gym.gymId,date]]:[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/group/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId]];
                
            }else{
                
                svc.url = date.length?[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/private/?model=%@&id=%ld&date=%@",ROOT,gym.type,(long)gym.gymId,date]]:[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/private/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId]];
                
            }
            
            [self.navigationController pushViewController:svc animated:YES];
            
            if (self.guideView1) {
                
                self.guideView1.hidden = YES;
                
                [self.guideView1 removeFromSuperview];
                
                self.guideView1 = nil;
                
                self.guideView2.hidden = NO;
                
            }
            
        }else{
            
            _agentDate = date;
            
            _gymWindow = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen]bounds]];
            
            _gymWindow.backgroundColor = [UIColorFromRGB(0x000000) colorWithAlphaComponent:0.4];
            
            [_gymWindow makeKeyAndVisible];
            
            if (self.guideView1) {
                
                self.guideView1.hidden = YES;
                
            }
            
            if (agentType == AgentTypeRest) {
                
                UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(MSW/2-Width320(121), MSH/2-Height320(40) , Width320(242), Height320(40)) style:UITableViewStylePlain];
                
                tableView.backgroundColor = UIColorFromRGB(0xffffff);
                
                tableView.layer.cornerRadius = 2;
                
                tableView.layer.masksToBounds = YES;
                
                tableView.tag = 303;
                
                tableView.dataSource = self;
                
                tableView.delegate = self;
                
                tableView.tableFooterView = [UIView new];
                
                [tableView registerClass:[ProgrammeGymCell class] forCellReuseIdentifier:gymIdentifier];
                
                [_gymWindow addSubview:tableView];
                
                if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                    
                    [tableView setSeparatorInset:UIEdgeInsetsZero];
                    
                }
                
                if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                    
                    [tableView setLayoutMargins:UIEdgeInsetsZero];
                    
                }
                
                CGFloat height = 0;
                
                NSInteger count = [ServicesInfo shareInfo].services.count;
                
                if (count*Height320(55)+Height320(40)>Height320(300)) {
                    
                    height = Height320(300);
                    
                }else{
                    
                    height = count*Height320(55)+Height320(40);
                    
                }
                
                tableView.frame = CGRectMake(MSW/2-Width320(121), MSH/2-height/2 , Width320(242), height);
                
                [tableView reloadData];
                
            }else{
                
                AgentInfo *info = [[AgentInfo alloc]init];
                
                info.type = agentType;
                
                UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(MSW/2-Width320(121), MSH/2-Height320(40) , Width320(242), Height320(40)) style:UITableViewStylePlain];
                
                tableView.backgroundColor = UIColorFromRGB(0xffffff);
                
                tableView.layer.cornerRadius = 2;
                
                tableView.layer.masksToBounds = YES;
                
                tableView.tag = 302;
                
                tableView.dataSource = self;
                
                tableView.delegate = self;
                
                tableView.tableFooterView = [UIView new];
                
                [tableView registerClass:[ProgrammeGymCell class] forCellReuseIdentifier:gymIdentifier];
                
                [_gymWindow addSubview:tableView];
                
                if ([tableView respondsToSelector:@selector(setSeparatorInset:)]) {
                    
                    [tableView setSeparatorInset:UIEdgeInsetsZero];
                    
                }
                
                if ([tableView respondsToSelector:@selector(setLayoutMargins:)]) {
                    
                    [tableView setLayoutMargins:UIEdgeInsetsZero];
                    
                }
                
                [info requestReult:^(BOOL success, NSString *error) {
                    
                    if (success) {
                        
                        self.agentArray = info.gyms;
                        
                        CGFloat height = 0;
                        
                        NSInteger count = self.agentArray.count;
                        
                        if (count*Height320(55)+Height320(40)>Height320(300)) {
                            
                            height = Height320(300);
                            
                        }else{
                            
                            height = count*Height320(55)+Height320(40);
                            
                        }
                        
                        tableView.frame = CGRectMake(MSW/2-Width320(121), MSH/2-height/2 , Width320(242), height);
                        
                        [tableView reloadData];
                        
                    }
                    
                }];
                
            }
            
        }
        
    } Failure:^{
        
    }];
    
}

-(void)more:(UIButton*)btn
{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        
        [self moreShow];
        
        [RootController sharedSliderController].tabbarShadeView.backgroundColor = [UIColorFromRGB(0xffffff) colorWithAlphaComponent:0.9];
        
        [RootController sharedSliderController].tabbarShadeView.hidden = NO;
        
    }else
    {
        
        [self moreHide];
        
    }

}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag != 301 && tableView.tag != 302&& tableView.tag != 303) {
        
        return nil;
        
    }
    
    UIView *header = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(242), Height320(40))];
    
    header.backgroundColor = UIColorFromRGB(0xffffff);
    
    UILabel *headerLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(40), 0, Width320(162), Height320(40))];
    
    headerLabel.backgroundColor = UIColorFromRGB(0xffffff);
    
    headerLabel.text = @"请选择场馆";
    
    headerLabel.textColor = kMainColor;
    
    headerLabel.textAlignment = NSTextAlignmentCenter;
    
    headerLabel.font = AllFont(16);
    
    [header addSubview:headerLabel];
    
    UIButton *hintCloseButton = [[UIButton alloc]initWithFrame:CGRectMake(header.width-Width320(40), 0, Width320(32), Height320(40))];
    
    [header addSubview:hintCloseButton];
    
    [hintCloseButton addTarget:self action:@selector(closeAlert) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *buttonImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(14), Height320(14), Width320(12), Height320(12))];
    
    buttonImg.image = [UIImage imageNamed:@"app_alert_close"];
    
    [hintCloseButton addSubview:buttonImg];
    
    UIView *line = [[UIView alloc]initWithFrame:CGRectMake(0, Height320(40)-OnePX, header.width, OnePX)];
    
    line.backgroundColor = kMainColor;
    
    [header addSubview:line];
    
    return  header;
    
}

-(void)closeAlert
{
    
    [_gymWindow resignKeyWindow];
    
    _gymWindow.hidden = YES;
    
    _gymWindow = nil;
    
    if (self.guideView1) {
        
        [self.guideView1 removeFromSuperview];
        
        self.guideView1 = nil;
        
        self.guideView2.hidden = NO;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    
    if (tableView.tag == 301||tableView.tag == 302 || tableView.tag == 303) {
        
        return Height320(40);
        
    }else{
        
        return 0;
        
    }
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    if (tableView.tag == 301||tableView.tag == 303) {
        
        return [ServicesInfo shareInfo].services.count;
        
    }else if (tableView.tag == 302){
        
        return self.agentArray.count;
        
    }
    
    ProgrammeInfo *info;
    
    switch (tableView.tag) {
        case 201:
            
            info = self.yesterdayInfo;
            
            break;
        case 202:
            
            info = self.programmeInfo;
            
            break;
        case 203:
            
            info = self.tomorrowInfo;
            
            break;
        default:
            break;
    }
    
    return [info havePrivateWithGym:self.gym]?[info getShowDataWithGym:self.gym].count:[info getShowDataWithGym:self.gym].count+1;
    
}

-(void)endRefresh
{
    
    [self.emptyView.mj_header endRefreshing];
    
    [self reloadTodayData];
    
}

-(UIView*)customViewForEmptyDataSet:(UIScrollView *)scrollView
{
    
    self.emptyView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, MSW, self.calendarView.height-Height320(87))];
    
    self.emptyView.backgroundColor = UIColorFromRGB(0xffffff);
    
    MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(endRefresh)];
    
    header.lastUpdatedTimeLabel.hidden = YES;
    
    [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
    
    [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
    
    [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
    
    header.stateLabel.textColor = [UIColor blackColor];
    
    self.emptyView.mj_header = header;
    
    UIImageView *imgView = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(106), Height320(75), Width320(105), Height320(105))];
    
    imgView.image = [UIImage imageNamed:@"programmeempty"];
    
    [self.emptyView addSubview:imgView];
    
    UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(20, imgView.bottom+Height320(19.5), MSW-40, Height320(40))];
    
    label.font = AllFont(14);
    
    label.textColor = UIColorFromRGB(0x747474);
    
    label.textAlignment = NSTextAlignmentCenter;
    
    label.numberOfLines = 0;
    
    label.text = @"本日无课程安排\n请在[ 健身房 ] - [ 私教 ]或[ 团课 ]排课";
    
    [self.emptyView addSubview:label];
    
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
    
    [self.emptyView addSubview:refreshBtn];
    
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
    
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status)
     {
         if (status == AFNetworkReachabilityStatusNotReachable) {
             
             refreshBtn.hidden = NO;
             
             label.text = @"网络连接失败";
             
             imgView.image = [UIImage imageNamed:@"nonet"];
             
         }
         
     }];
    
    return self.emptyView;
    
}

-(void)refresh:(UIButton*)btn
{
    
    [self reloadData];
    
}

-(void)refreshMessage
{
    
    self.msgInfo = [[MessageInfo alloc]init];
    
    [self.msgInfo requestResult:^(BOOL success, NSString *error) {
        
        self.rightNum = self.msgInfo.unReadCount;
        
        [[UIApplication sharedApplication]setApplicationIconBadgeNumber:self.msgInfo.unReadCount];
        
    }];
    
}

-(void)reloadCalendarData
{
    
    [self createDataWithDate:self.calendarView.currentDate];
    
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 301||tableView.tag == 303) {
        
        ProgrammeGymCell *cell = [tableView dequeueReusableCellWithIdentifier:gymIdentifier];
        
        Gym *gym = [ServicesInfo shareInfo].services[indexPath.row];
        
        cell.title = gym.name;
        
        cell.imgURL = gym.imgUrl;
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else if (tableView.tag == 302){
        
        ProgrammeGymCell *cell = [tableView dequeueReusableCellWithIdentifier:gymIdentifier];
        
        Gym *gym = self.agentArray[indexPath.row];
        
        cell.title = gym.name;
        
        cell.imgURL = gym.imgUrl;
        
        cell.havePermission = gym.havePermission;
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
    ProgrammeInfo *info;
    
    switch (tableView.tag) {
        case 201:
            
            info = self.yesterdayInfo;
            
            break;
        case 202:
            
            info = self.programmeInfo;
            
            break;
        case 203:
            
            info = self.tomorrowInfo;
            
            break;
        default:
            
            info = self.programmeInfo;
            
            break;
    }
    
    if (![info havePrivateWithGym:self.gym] && indexPath.row == 0) {
        
        NoPrivateProgrammeCell *cell = [tableView dequeueReusableCellWithIdentifier:headIdentifier];
        
        if (!cell) {
            
            cell = [[NoPrivateProgrammeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:headIdentifier];
            
        }
        
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
        return cell;
        
    }else{
        
        NSInteger index = [info havePrivateWithGym:self.gym]?indexPath.row:indexPath.row-1;
        
        ProgrammeCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
        
        if (!cell) {
            cell = [[ProgrammeCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
        }
        
        Programme *programme = [info getShowDataWithGym:self.gym][index];
        
        cell.title = programme.style == ProgrammeStyleNormal?programme.title:[NSString stringWithFormat:@"%@ - %@休息",[programme.startTime substringWithRange:NSMakeRange(11, 5)],[programme.endTime substringWithRange:NSMakeRange(11, 5)]];
        ;
        
        cell.time = [programme.startTime substringWithRange:NSMakeRange(11, 5)];
        
        cell.gym = programme.style == ProgrammeStyleRest?programme.gym.name:programme.gym.name;
        
        cell.imgUrl = programme.imgUrl;
        
        cell.clash = programme.clash;
        
        cell.style = programme.style;
        
        NSDateFormatter *df = [[NSDateFormatter alloc]init];
        
        [df setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
        
        df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        NSTimeInterval timeInterval = [[df dateFromString:programme.startTime] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]];
        
        cell.completed = timeInterval <= 0;
        
        cell.orderCount = programme.total;
        
        if (programme.orders.count == 1) {
            
            cell.total = [NSString stringWithFormat:@"%ld人：%@",(long)[programme.orders[0][@"count"] integerValue],programme.orders[0][@"username"]];
            
        }else{
            
            cell.total = [NSString stringWithFormat:@"共%ld人预约",(long)programme.total];
            
        }
        
        cell.selectedBackgroundView = [[UIView alloc]initWithFrame:cell.frame];
        
        cell.selectedBackgroundView.backgroundColor = UIColorFromRGB(0xf2f2f2);
        
        return cell;
        
    }
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 301||tableView.tag ==302||tableView.tag == 303) {
        
        return Height320(55);
        
    }
    
    ProgrammeInfo *info;
    
    switch (tableView.tag) {
        case 201:
            
            info = self.yesterdayInfo;
            
            break;
        case 202:
            
            info = self.programmeInfo;
            
            break;
        case 203:
            
            info = self.tomorrowInfo;
            
            break;
        default:
            
            info = self.programmeInfo;
            
            break;
    }
    
    if (![info havePrivateWithGym:self.gym] && indexPath.row == 0) {
        
        return Height320(52);
        
    }else{
        
        NSInteger index = [info havePrivateWithGym:self.gym]?indexPath.row:indexPath.row-1;
        
        Programme *programme = [info getShowDataWithGym:self.gym][index];
        
        if (programme.style == ProgrammeStyleNormal) {
            
            return programme.clash?Height320(114):Height320(90);
            
        }else
        {
            
            return Height320(72);
            
        }
        
    }
    
}

-(void)naviLeftClick
{
    
    if (_calenderWindow) {
        
        [self closeMonthView];
        
    }
    
    [self userCourse];
    
}

-(void)naviRightClick
{
    
    if (_calenderWindow) {
        
        [self closeMonthView];
        
    }
    
    MessageController *svc = [[MessageController alloc]init];
    
    [self.navigationController pushViewController:svc animated:YES];
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
    if(tableView.tag == 301 || tableView.tag == 303){
        
        Gym *gym = [ServicesInfo shareInfo].services[indexPath.row];
        
        WebViewController *svc = [[WebViewController alloc]init];
        
        NSURL *url;
        
        if (tableView.tag == 301) {
            
            url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/gym/welcome/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId]];
            
            svc.rootRightTitle = @"发送给会员";
            
        }else{
            
            url = _agentDate.length?[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/rest/?model=%@&id=%ld&date=%@",ROOT,gym.type,(long)gym.gymId,_agentDate]]:[NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coach/rest/?model=%@&id=%ld",ROOT,gym.type,(long)gym.gymId]];
            
        }
        
        __weak typeof(self)weakS = self;
        
        svc.completeAction = ^{
            
            [weakS reloadData];
            
        };
        
        svc.url = url;
        
        [self.navigationController pushViewController:svc animated:YES];
        
        [self closeAlert];
        
        if (self.guideView1) {
            
            [self.guideView1 removeFromSuperview];
            
            self.guideView1 = nil;
            
            self.guideView2.hidden = NO;
            
        }
        
    }else if (tableView.tag == 302){
        
        [self closeAlert];
        
        Gym *gym = self.agentArray[indexPath.row];
        
        if (!gym.havePermission) {
            
            [self showNoPermissionAlert];
            
        }else{
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = _agentDate.length?[NSURL URLWithString:[NSString stringWithFormat:@"%@&date=%@",gym.url.absoluteString,_agentDate]]:gym.url;
            
            __weak typeof(self)weakS = self;
            
            svc.completeAction = ^{
                
                [weakS reloadData];
                
            };
            
            [self.navigationController pushViewController:svc animated:YES];
            
            if (self.guideView1) {
                
                [self.guideView1 removeFromSuperview];
                
                self.guideView1 = nil;
                
                self.guideView2.hidden = NO;
                
            }
            
        }
        
    }else{
        
        ProgrammeInfo *info;
        
        switch (tableView.tag) {
            case 201:
                
                info = self.yesterdayInfo;
                
                break;
            case 202:
                
                info = self.programmeInfo;
                
                break;
            case 203:
                
                info = self.tomorrowInfo;
                
                break;
            default:
                
                info = self.programmeInfo;
                
                break;
        }
        
        if (![info havePrivateWithGym:self.gym] && indexPath.row == 0) {
            
            return;
            
        }else{
            
            NSInteger index = [info havePrivateWithGym:self.gym]?indexPath.row:indexPath.row-1;
            
            NSArray *array = [info getShowDataWithGym:self.gym];
            
            Programme *programme = array[index];
            
            WebViewController *svc = [[WebViewController alloc]init];
            
            svc.url = programme.url;
            
            __weak typeof(self)weakS = self;
            
            svc.completeAction = ^{
                
                [weakS reloadData];
                
            };
            
            svc.leftType = MONaviLeftTypeBack;
            
            [self.navigationController pushViewController:svc animated:YES];
            
        }
        
    }
    
}

-(void)showNoProgrammeView
{
    
    if (![[NSUserDefaults standardUserDefaults]boolForKey:@"noProgrammeHaveShew"]) {
        
        if (!self.noProgrammeGuideView) {
            
            self.noProgrammeGuideView = [[UIImageView alloc]initWithFrame:CGRectMake(MSW*3/8-Width320(88), MSH-49-Height320(36), Width320(176), Height320(34))];
            
            self.noProgrammeGuideView.image = [UIImage imageNamed:@"programme_guide_3"];
            
            self.noProgrammeGuideView.contentMode = UIViewContentModeScaleAspectFill;
            
        }
        
        if (!self.guideView1 && !self.guideView2 && self.noProgrammeGuideView) {
            
            [self.view addSubview:self.noProgrammeGuideView];
            
        }
        
    }
    
}

-(void)hideGuide
{
    
    if (self.noProgrammeGuideView) {
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"noProgrammeHaveShew"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self.noProgrammeGuideView removeFromSuperview];
        
        self.noProgrammeGuideView = nil;
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"noProgrammeFirst"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
    }
    
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (tableView.tag == 301||tableView.tag == 302||tableView.tag == 303) {
        
        if ([cell respondsToSelector:@selector(setSeparatorInset:)]) {
            
            [cell setSeparatorInset:UIEdgeInsetsZero];
            
        }
        
        if ([cell respondsToSelector:@selector(setLayoutMargins:)]) {
            
            [cell setLayoutMargins:UIEdgeInsetsZero];
            
        }
        
    }
    
}


-(void)userCourse
{
    
    MineHomePageController *svc = [[MineHomePageController alloc]init];
    
    NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"%@/fitness/redirect/coaches/%ld/saas/share/",ROOT,CoachId]];
    
    svc.URL = url;
    
    [self.navigationController pushViewController:svc animated:YES];
    
    if (self.guideView1) {
        
        self.guideView1.hidden = YES;
        
        [self.guideView1 removeFromSuperview];
        
        self.guideView1 = nil;
        
        self.guideView2.hidden = NO;
        
    }
    
}

@end
