//
//  CalendarView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "CalendarView.h"

#import "WeekScheduleHeader.h"

#define Font(a) [UIFont boldSystemFontOfSize:a]

#define kDateNum 21

@interface MOCalendarWeekButton : UIButton

{
    
    UIView *_lineView;
    
}

@property(nonatomic,assign)BOOL choosed;

@end

@implementation MOCalendarWeekButton

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        [self setTitleColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
        
        self.titleLabel.font = AllFont(12);
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(Width320(5), frame.size.height-1, frame.size.width-Width320(10), 1)];
        
        _lineView.backgroundColor = kMainColor;
        
        _lineView.hidden = YES;
        
        [self addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _lineView.hidden = !_choosed;
    
    [self setTitleColor:_choosed?kMainColor:UIColorFromRGB(0x999999) forState:UIControlStateNormal];
    
}

@end

@interface MOCalendarButton : UIButton

{
    
    UILabel *_weekLabel;
    
    UILabel *_dateLabel;
    
}

@property(nonatomic,copy)NSString *week;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation MOCalendarButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        _weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, Height320(6), frame.size.width, Height320(16))];
        
        _weekLabel.textColor = UIColorFromRGB(0x999999);
        
        _weekLabel.textAlignment = NSTextAlignmentCenter;
        
        _weekLabel.font = AllFont(12);
        
        [self addSubview:_weekLabel];
        
        _dateLabel = [[UILabel alloc]initWithFrame:CGRectMake(0, _weekLabel.bottom+Height320(4), frame.size.width, Height320(18))];
        
        _dateLabel.textColor = UIColorFromRGB(0x333333);
        
        _dateLabel.textAlignment = NSTextAlignmentCenter;
        
        _dateLabel.font = AllFont(15);
        
        [self addSubview:_dateLabel];
        
    }
    return self;
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _dateLabel.textColor = _choosed?kMainColor:UIColorFromRGB(0x333333);
    
    _weekLabel.textColor = _choosed?kMainColor:UIColorFromRGB(0x999999);
    
}

-(void)setWeek:(NSString *)week
{
    
    _week = week;
    
    _weekLabel.text = _week;
    
}

-(void)setDate:(NSString *)date
{
    
    _date = date;
    
    _dateLabel.text = _date;
    
}

@end

@interface ShowButton : UIButton

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
}

@end

@implementation ShowButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(14), 0, frame.size.width-Width320(31), frame.size.height)];
        
        _titleLabel.font = AllFont(12);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [self addSubview:_titleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(17), Height320(17), Width320(10), Height320(5))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.image = [UIImage imageNamed:@"down_arrow"];
        
        _imgView.userInteractionEnabled = NO;
        
        [self addSubview:_imgView];
        
    }
    
    return self;
    
}

-(void)setTitle:(NSString *)title forState:(UIControlState)state
{
    
    _titleLabel.text = title;
    
}

@end

@interface CalendarView ()<UIScrollViewDelegate,WeekScheduleHeaderDelegate>
{
    
    UIScrollView *_labelView;

    NSMutableArray *_labelArray;
    
    UIView *_lineView;
    
    NSMutableArray *_dateArray;
    
    UIView *_subCalendarView;
    
    UIView *_weekLineView;
    
    UIScrollView *_contentView;
    
    NSMutableArray *_views;
    
    ShowButton *_showButton;
    
    UIView *_weekView;
    
    WeekScheduleHeader *_weekHeaderView;
    
    UIScrollView *_weekScheduleView;
    
    MOCalendarWeekButton *_dayButton;
    
    MOCalendarWeekButton *_weekButton;
    
    TimeType _timeType;
    
}

@end

@implementation CalendarView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
        
    }
    
    return self;
    
}

-(void)setDatasource:(id<CalendarViewDatasource>)datasource
{
    
    _datasource = datasource;
    
    for (UITableView *tableView in _views) {
         
        tableView.dataSource = _datasource;
        
        tableView.emptyDataSetSource = _datasource;
        
    }
    
    for (UIView *subView in _weekScheduleView.subviews) {
        
        if ([subView isKindOfClass:[WeekScheduleView class]]) {
            
            ((WeekScheduleView *)subView).datasource = _datasource;
            
        }
        
    }
    
    self.currentDate = [NSDate date];
    
}

-(void)setDelegate:(id<CalendarViewDelegate>)delegate
{
    
    _delegate = delegate;
    
    for (UITableView *tableView in _views) {
        
        tableView.delegate = _delegate;
        
    }
    
}

-(void)load
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(87))];
    
    topView.backgroundColor = UIColorFromRGB(0xffffff);
    
    [self addSubview:topView];
    
    _dateArray = [NSMutableArray array];
    
    _showButton = [[ShowButton alloc]initWithFrame:CGRectMake(0, 0, Width320(97), Height320(38))];
    
    [_showButton addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [topView addSubview:_showButton];
    
    _dayButton = [[MOCalendarWeekButton alloc]initWithFrame:CGRectMake(MSW-Width320(100), Height320(10), Width320(45), Height320(18))];
    
    [_dayButton setTitle:@"日视图" forState:UIControlStateNormal];
    
    _dayButton.choosed = YES;
    
    _dayButton.tag = 1;
    
    [topView addSubview:_dayButton];
    
    [_dayButton addTarget:self action:@selector(weekButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    _weekButton = [[MOCalendarWeekButton alloc]initWithFrame:CGRectMake(_dayButton.right+Width320(4), _dayButton.top, _dayButton.width, _dayButton.height)];
    
    [_weekButton setTitle:@"周视图" forState:UIControlStateNormal];
    
    _weekButton.choosed = NO;
    
    _weekButton.tag = 2;
    
    [topView addSubview:_weekButton];
    
    [_weekButton addTarget:self action:@selector(weekButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *todayButton = [[UIButton alloc]initWithFrame:CGRectMake(0, _showButton.bottom, MSW/8, Height320(49))];
    
    todayButton.backgroundColor = UIColorFromRGB(0xffffff);
    
    [topView addSubview:todayButton];
    
    UIImageView *todayImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(17), Height320(17))];
    
    todayImg.image = [UIImage imageNamed:@"calendar_today"];
    
    [todayButton addSubview:todayImg];
    
    UIView *todayLine = [[UIView alloc]initWithFrame:CGRectMake(todayButton.width-OnePX, Height320(12), OnePX, todayButton.height-Height320(32))];
    
    todayLine.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [todayButton addSubview:todayLine];
    
    [todayButton addTarget:self action:@selector(todayClick) forControlEvents:UIControlEventTouchUpInside];
    
    _labelView = [[UIScrollView alloc]initWithFrame:CGRectMake(MSW/8, _showButton.bottom, MSW/8*7, Height320(49))];
    
    _labelView.showsHorizontalScrollIndicator = NO;
    
    _labelView.pagingEnabled = YES;
    
    _labelView.contentSize = CGSizeMake((MSW/8*7)*3, 0);
    
    _labelView.delegate = self;
    
    _labelView.tag = 102;
    
    [_labelView setContentOffset:CGPointMake((MSW/8*7), 0) animated:NO];
    
    [topView addSubview:_labelView];
    
    _labelArray = [NSMutableArray array];
    
    for (NSInteger i = 0; i<kDateNum; i++) {
        
        MOCalendarButton *btn = [[MOCalendarButton alloc]initWithFrame:CGRectMake(i*MSW/8, 0, MSW/8, Height320(49))];
        
        btn.tag = i;
        
        [btn addTarget:self action:@selector(labelClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [_labelView addSubview:btn];
        
        [_labelArray addObject:btn];
        
    }
    
    _lineView = [[UIView alloc]initWithFrame:CGRectMake(MSW/8, _labelView.bottom-3, MSW/8, 3)];
    
    _lineView.backgroundColor = kMainColor;
    
    [topView addSubview:_lineView];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, topView.height-OnePX, MSW, OnePX)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);

    [topView addSubview:sep];
    
    [self setlabelWithDate:[NSDate date]];
    
    _contentView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, topView.bottom, MSW, self.height-topView.bottom)];
    
    _contentView.contentSize = CGSizeMake(MSW*3, 0);
    
    _contentView.delegate = self;
    
    _contentView.tag = 101;
    
    _contentView.pagingEnabled = YES;
    
    _contentView.bounces = YES;
    
    _contentView.showsHorizontalScrollIndicator = NO;
    
    _views = [NSMutableArray array];
    
    for (NSInteger i=0; i<3; i++) {
        
        UITableView *tableView = [[UITableView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, _contentView.height) style:UITableViewStylePlain];
        
        tableView.tag = 201+i;
        
        tableView.backgroundColor = UIColorFromRGB(0xf4f4f4);
        
        tableView.tableFooterView = [UIView new];
        
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        MJRefreshNormalHeader *header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(reloadTableView)];
        
        header.lastUpdatedTimeLabel.hidden = YES;
        
        [header setTitle:@"下拉可以刷新" forState:MJRefreshStateIdle];
        
        [header setTitle:@"松开以刷新" forState:MJRefreshStatePulling];
        
        [header setTitle:@"刷新数据中……" forState:MJRefreshStateRefreshing];
        
        header.stateLabel.textColor = [UIColor blackColor];
        
        tableView.mj_header = header;
        
        [_contentView addSubview:tableView];
        
        [_views addObject:tableView];
        
    }

    [self addSubview:_contentView];
    
    _weekView = [[UIView alloc]initWithFrame:CGRectMake(0,Height320(38), MSW, self.height-Height320(38))];
    
    _weekView.hidden = YES;

    [self addSubview:_weekView];
    
    _weekHeaderView = [[WeekScheduleHeader alloc]initWithFrame:CGRectMake(0, 0, MSW, Height320(49))];
    
    _weekHeaderView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _weekHeaderView.delegate = self;
    
    [_weekView addSubview:_weekHeaderView];
    
    _weekScheduleView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, _weekHeaderView.bottom, MSW, _weekView.height-_weekHeaderView.bottom)];
    
    _weekScheduleView.backgroundColor = UIColorFromRGB(0xffffff);
    
    _weekScheduleView.contentSize = CGSizeMake(MSW*3, 0);
    
    _weekScheduleView.delegate = self;
    
    _weekScheduleView.tag = 103;
    
    _weekScheduleView.pagingEnabled = YES;
    
    _weekScheduleView.bounces = NO;
    
    _weekScheduleView.showsHorizontalScrollIndicator = NO;
    
    [_weekView addSubview:_weekScheduleView];
    
    for (NSInteger i=0; i<3; i++) {
        
        WeekScheduleView *scheduleView = [[WeekScheduleView alloc]initWithFrame:CGRectMake(i*MSW, 0, MSW, _weekScheduleView.height)];
        
        scheduleView.tag = i;
        
        [_weekScheduleView addSubview:scheduleView];
        
    }
    
    BOOL dayView = [[NSUserDefaults standardUserDefaults]boolForKey:@"calendar_open_with_day"];

    if (dayView) {
        
        [self weekButtonClick:_dayButton];
        
    }else{
        
        [self weekButtonClick:_weekButton];
        
    }
    
}

-(void)reloadTableView
{
    
    if ([self.datasource respondsToSelector:@selector(reloadTodayData)]) {
        
        [self.datasource reloadTodayData];
        
    }
    
}

-(void)headerTodayClick
{
    
    [self todayClick];
    
}

-(void)headerDidEndScrollWithType:(TimeType)type
{
    
    _timeType = type;
    
    if (type == TimeTypeFuture) {
        
        [_weekScheduleView setContentOffset:CGPointMake(MSW*2, 0) animated:YES];
        
        self.currentDate = [NSDate dateWithTimeInterval:7*86400 sinceDate:_currentDate];
        
    }else{
        
        [_weekScheduleView setContentOffset:CGPointMake(0, 0) animated:YES];
        
        self.currentDate = [NSDate dateWithTimeInterval:-7*86400 sinceDate:_currentDate];
        
    }
    
}

-(void)todayClick
{
    
    self.currentDate = [NSDate date];
    
}

-(void)labelClick:(UIButton*)btn
{
    
    self.currentDate = _dateArray[btn.tag];
    
}

-(void)setlabelWithDate:(NSDate *)date
{
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"EEE"];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"en_US"];
    
    [df1 setDateFormat:@"dd"];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:date];
    
    NSDate *startDate = [NSDate dateWithTimeInterval:(theComponents.weekday+6)*-86400 sinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:date]]];
    
    [_dateArray removeAllObjects];
    
    NSInteger index = 0;
    
    for (NSInteger i = 0; i<_labelArray.count; i++) {
        
        NSDate *tempDate = [NSDate dateWithTimeInterval:86400*i sinceDate:startDate];
        
        [_dateArray addObject:tempDate];
        
        MOCalendarButton *btn = _labelArray[i];
        
        btn.week = [[df stringFromDate:tempDate]substringFromIndex:1];
        
        btn.date = [df1 stringFromDate:tempDate];
        
        btn.choosed = [[dateFormatter dateFromString:[dateFormatter stringFromDate:date]]timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:tempDate]]] == 0;
        
        if (btn.choosed) {
            
            index = i;
            
        }
        
    }
    
    [_lineView changeLeft:(index%7+1)*MSW/8];
    
    [_labelView setContentOffset:CGPointMake(MSW/8*7,0) animated:NO];
    
}

-(void)reloadAtIndex:(NSInteger)index
{
    
    if (index<_views.count) {
        
        for (UIView *subView in _contentView.subviews) {
            
            if ([subView isKindOfClass:[UITableView class]] && subView.tag == 201+index) {
                
                UITableView *tableView = (UITableView*)subView;
                
                [tableView setContentOffset:CGPointMake(0, 0) animated:NO];
                
                [tableView.mj_header endRefreshing];
                
                [tableView reloadData];
                
            }
            
        }
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.tag == 101) {
        
        NSInteger x = scrollView.contentOffset.x;
        
        if (x == MSW*2) {
            
            self.currentDate = [NSDate dateWithTimeInterval:86400 sinceDate:_currentDate];
            
        }else if(x == 0)
        {
            
            self.currentDate = [NSDate dateWithTimeInterval:-86400 sinceDate:_currentDate];
            
        }

    }
    else if (scrollView.tag == 103){
        
        NSInteger x = scrollView.contentOffset.x;
        
        if (x == MSW*2) {
            
            _timeType = TimeTypeFuture;
            
            self.currentDate = [NSDate dateWithTimeInterval:7*86400 sinceDate:_currentDate];
            
        }else if(x == 0)
        {
            
            _timeType = TimeTypePass;
            
            self.currentDate = [NSDate dateWithTimeInterval:-7*86400 sinceDate:_currentDate];
            
        }

    }else if(scrollView.tag == 102)
    {
        
        if (scrollView.contentOffset.x>(MSW/8*7*3/2)) {
            
            _timeType = TimeTypeNextWeek;
            
            self.currentDate = [NSDate dateWithTimeInterval:7*86400 sinceDate:_currentDate];
            
        }else if(scrollView.contentOffset.x<(MSW/8*7*1/2)){
            
            _timeType = TimeTypeLastWeek;
            
            self.currentDate = [NSDate dateWithTimeInterval:-7*86400 sinceDate:_currentDate];
            
        }
   
    }
    
}

-(void)reloadContent
{
    
    [_contentView setContentOffset:CGPointMake(MSW, 0) animated:NO];
    
    [_weekScheduleView setContentOffset:CGPointMake(MSW, 0) animated:NO];
    
}

-(void)onlySetDate:(NSDate *)date
{
    
    _currentDate = date;
    
    _weekHeaderView.date = _currentDate;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy年MM月";
    
    [_showButton setTitle:[df stringFromDate:date] forState:UIControlStateNormal];
    
    [self setlabelWithDate:_currentDate];
    
}

-(void)setCurrentDate:(NSDate *)currentDate
{
    
    _currentDate = currentDate;
    
    _weekHeaderView.date = _currentDate;
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"yyyy年MM月";
    
    [_showButton setTitle:[df stringFromDate:currentDate] forState:UIControlStateNormal];
    
    [self setlabelWithDate:_currentDate];
    
    if (_timeType == TimeTypeNextWeek || _timeType == TimeTypeLastWeek) {
        
        [_datasource reloadCalendarData];
        
        _timeType = TimeTypeNow;
        
    }else if (_dayButton.choosed) {
        
        [_datasource reloadCalendarData];
        
    }else{
        
        [_datasource getDate];
        
        [_datasource reloadWeekDataWithType:_timeType];
        
        _timeType = TimeTypeNow;
        
    }
    
}

-(void)calendarClick:(ShowButton*)btn
{
    
    [_delegate calendarClick];
    
}

-(void)endRefresh
{
    
    for (UITableView *tableView in _views) {
        
        if (tableView.tag == 202) {
            
            [tableView.mj_header endRefreshing];
            
        }
        
    }
    
}

-(void)weekButtonClick:(MOCalendarWeekButton*)button
{
    
    if (button.tag == 1) {
        
        _isWeek = NO;
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"calendar_open_with_day"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _weekView.hidden = YES;
        
        if (_weekButton.choosed) {
            
            _dayButton.choosed = YES;
            
            _weekButton.choosed = NO;
            
            self.currentDate = [NSDate date];
            
        }
        
    }else{
        
        _isWeek = YES;
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"calendar_open_with_day"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _weekView.hidden = NO;
        
        if (_dayButton.choosed) {
            
            _dayButton.choosed = NO;
            
            _weekButton.choosed = YES;
            
            self.currentDate = [NSDate date];;
            
        }
        
    }
    
}

-(void)setType:(CalendarViewType)type
{
    
    _type = type;
    
    if (_type == CalendarViewTypeDay) {
        
        _isWeek = NO;
        
        [[NSUserDefaults standardUserDefaults]setBool:YES forKey:@"calendar_open_with_day"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _weekView.hidden = YES;
        
        _dayButton.choosed = YES;
        
        _weekButton.choosed = NO;
        
    }else{
        
        _isWeek = YES;
        
        [[NSUserDefaults standardUserDefaults]setBool:NO forKey:@"calendar_open_with_day"];
        
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        _weekView.hidden = NO;
        
        _dayButton.choosed = NO;
        
        _weekButton.choosed = YES;
        
    }
    
}

-(void)reloadWeekViewAtIndex:(NSInteger)index
{
    
    WeekScheduleView *scheduleView = _weekScheduleView.subviews[index];
    
    scheduleView.date = [NSDate dateWithTimeInterval:(index-1)*7*86400 sinceDate:_currentDate];
    
    scheduleView.schedules = [_datasource programmesAtIndex:index];
    
}

-(void)hideAgent
{
    
    for (UIView *subView in _weekScheduleView.subviews) {
        
        if ([subView isKindOfClass:[WeekScheduleView class]]) {
            
            WeekScheduleView *scheduleView = (WeekScheduleView*)subView;
            
            [scheduleView hideAgent];
            
        }
        
    }
    
}

-(void)dealloc
{
    
    for (UIView *subView in _contentView.subviews) {
        
        if ([subView isKindOfClass:[UIScrollView class]]) {
            
            UIScrollView *scorllView = (UIScrollView*)subView;
            
            if (scorllView.mj_header) {
                
                scorllView.mj_header = nil;
                
            }
            
        }
        
    }
    
}

@end
