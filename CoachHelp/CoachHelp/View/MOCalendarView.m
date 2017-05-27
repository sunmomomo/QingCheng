//
//  MOCalendarView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOCalendarView.h"

#import "CalendarInfo.h"

@interface CalendarButton ()

{
    
    UIView *_nodeView;
    
    UIView *_circle;
    
    UILabel *_title;
    
}


@end

@implementation CalendarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _circle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, Width320(24), Height320(24))];
        
        _circle.backgroundColor = kMainColor;
        
        _circle.layer.cornerRadius = _circle.width/2;
        
        _circle.layer.masksToBounds = YES;
        
        _circle.center = CGPointMake(self.width/2, self.height/2);
        
        [self addSubview:_circle];
        
        _nodeView = [[UIView alloc]initWithFrame:CGRectMake(0,_circle.bottom-Height320(4.5), Width320(3.5), Height320(3.5))];
        
        _nodeView.layer.cornerRadius = _nodeView.width/2;
        
        _nodeView.layer.masksToBounds = YES;
        
        _nodeView.center = CGPointMake(self.width/2, _nodeView.center.y);
        
        [self addSubview:_nodeView];
        
        _title = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, self.width, self.height)];
        
        _title.font = AllFont(14);
        
        _title.textColor = UIColorFromRGB(0x333333);
        
        _title.textAlignment = NSTextAlignmentCenter;
        
        [self addSubview:_title];
        
        _circle.userInteractionEnabled = NO;
        
        _nodeView.userInteractionEnabled = NO;
        
        _title.userInteractionEnabled = NO;
        
    }
    
    return self;
    
}

-(void)setDate:(NSDate *)date
{
    
    _date = date;
    
    if (!date) {
        
        _title.text = @"";
        
        return;
        
    }
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [df setDateFormat:@"dd"];
    
    NSString *title = [df stringFromDate:_date];
    
    _title.text = title;
    
}

-(void)setType:(CalendarButtonType)type
{
    
    _type = type;
    
    switch (type) {
        case CalendarButtonTypeToday:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = kMainColor;
            
            break;
        case CalendarButtonTypeTodayPro:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = kMainColor;
            
            _title.textColor = kMainColor;
            
            break;
            
        case CalendarButtonTypeSelectDay:
            
            _circle.hidden = NO;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0xffffff);
            
            break;
        case CalendarButtonTypeSelectPro:
            
            _circle.hidden = NO;
            
            _nodeView.backgroundColor = UIColorFromRGB(0xffffff);
            
            _title.textColor = UIColorFromRGB(0xffffff);
            
            break;
        
        case CalendarButtonTypeNoProgramme:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0x333333);
            
            break;
        case CalendarButtonTypeNormal:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = kMainColor;
            
            _title.textColor = UIColorFromRGB(0x333333);
            break;
            
        case CalendarButtonTypeNotThisMonth:
            
            _circle.hidden = YES;
            
            _nodeView.backgroundColor = [UIColor clearColor];
            
            _title.textColor = UIColorFromRGB(0xcccccc);
            break;
            
        default:
            break;
    }
    
}

@end

@interface MonthCalendarButton : UIButton

{
    
    UIImageView *_imgView;
    
    UILabel *_titleLabel;
    
}

@property(nonatomic,assign)BOOL choosed;

@end

@implementation MonthCalendarButton

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        _titleLabel = [[UILabel alloc]initWithFrame:CGRectMake(Width320(14), 0, frame.size.width-Width320(31), frame.size.height)];
        
        _titleLabel.font = AllFont(12);
        
        _titleLabel.textColor = UIColorFromRGB(0x333333);
        
        [self addSubview:_titleLabel];
        
        _imgView = [[UIImageView alloc]initWithFrame:CGRectMake(frame.size.width-Width320(17), Height320(17), Width320(10), Height320(5))];
        
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        
        _imgView.image = [UIImage imageNamed:@"up_arrow"];
        
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

@interface MOCalendarView ()

{
    
    UILabel *_monthLabel;
    
    NSMutableArray *_buttonArray;
    
    MonthCalendarButton *_showButton;
    
}

@property(nonatomic,strong)NSMutableArray *buttonArray;

@property(nonatomic,strong)CalendarInfo *calendarInfo;

@property(nonatomic,strong)NSArray *dates;

@end

@implementation MOCalendarView

-(instancetype)initWithFrame:(CGRect)frame
{
    
    if (self = [super initWithFrame:frame]) {
        
        [self load];
        
    }
    
    
    return self;
    
}

-(void)load
{
    
    _currentDate = [NSDate date];
    
    _buttonArray = [NSMutableArray array];
    
    self.backgroundColor = UIColorFromRGB(0xffffff);
    
    _showButton = [[MonthCalendarButton alloc]initWithFrame:CGRectMake(0, 0, Width320(97), Height320(38))];
    
    [_showButton addTarget:self action:@selector(monthClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_showButton];
    
    for (NSInteger i = 0; i<7; i++) {
        
        CGFloat width = (MSW-Width320(30))/7;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(15)+i*width, _showButton.bottom+Height320(13.3), width, Height320(15.1))];
        
        label.textColor = UIColorFromRGB(0x666666);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = AllFont(12);
        
        label.text = i==0?@"日":i==1?@"一":i==2?@"二":i==3?@"三":i==4?@"四":i==5?@"五":@"六";
        
        [self addSubview:label];
        
    }
    
    for(NSInteger i = 0;i<6;i++)
    {
        
        for (NSInteger j = 0; j<7; j++) {
            
            CalendarButton *btn = [[CalendarButton alloc]initWithFrame:CGRectMake(Width320(25)+j*Width320(40.8), _showButton.bottom+Height320(40.3)+i*Height320(28.4), Width320(28.4), Height320(32.4))];
            
            [self addSubview:btn];
            
            btn.tag = i*7+j;
        
            [btn addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonArray addObject:btn];
            
        }
        
    }
    
    [self reload];
    
}

-(void)setCurrentDate:(NSDate *)currentDate
{
    
    _currentDate = currentDate;
    
    [self reload];
    
}

-(void)reload
{
    
    for (CalendarButton *btn in self.buttonArray) {
        
        btn.date = nil;
        
        btn.type = CalendarButtonTypeNoProgramme;
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps = [calendar components:unitFlags fromDate:_currentDate];
    
    _monthLabel.text = [NSString stringWithFormat:[comps month]<10?@"%ld年0%ld月":@"%ld年%ld月",(long)[comps year],(long)[comps month]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.dateFormat = @"yyyy年MM月";
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    [_showButton setTitle:[df1 stringFromDate:_currentDate] forState:UIControlStateNormal];
    
    NSDate *firstDate = [df dateFromString:[[[df stringFromDate:_currentDate] substringToIndex:8] stringByAppendingString:@"01"]];
    
    NSDateComponents *comps1 = [[NSDateComponents alloc]init];
    
    comps1 = [calendar components:unitFlags fromDate:firstDate];
    
    NSInteger numberOfDays = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:_currentDate].length;
    
    NSInteger week = [comps1 weekday];
    
    NSDate *finalDate = [df dateFromString:[[[df stringFromDate:_currentDate] substringToIndex:8] stringByAppendingString:[NSString stringWithFormat:@"%ld",(long)numberOfDays]]];
    
    NSDateComponents *comps2 = [[NSDateComponents alloc]init];
    
    comps2 = [calendar components:unitFlags fromDate:finalDate];
    
    NSInteger finalWeek = [comps2 weekday];
    
    NSInteger excessDays = finalWeek ==0?0:(6-finalWeek);
    
    for (NSInteger i = 0; i<week+numberOfDays+excessDays; i++) {
        
        NSDate *date = [NSDate dateWithTimeInterval:86400*(i-week+1) sinceDate:firstDate];
        
        for (CalendarButton *btn in _buttonArray) {
            
            if (btn.tag == i) {
                
                btn.date = date;
                
                if ([[df dateFromString:[df stringFromDate:btn.date]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:self.selectDate]]]==0) {
                    
                    btn.type = CalendarButtonTypeSelectDay;
                    
                }else if (i<week-1){
                    
                    btn.type = CalendarButtonTypeNotThisMonth;
                    
                }else if (i>=week+numberOfDays-1){
                    
                    btn.type = CalendarButtonTypeNotThisMonth;
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)setDates:(NSArray *)dates
{
    
    _dates = dates;
    
    for (CalendarButton *btn in self.buttonArray) {
        
        if (btn.date && btn.type != CalendarButtonTypeNotThisMonth) {
            
            NSDateFormatter *df = [[NSDateFormatter alloc]init];
            
            df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
            
            [df setDateFormat:@"yyyy-MM-dd"];
            
            NSTimeInterval timeInterval = [[df dateFromString:[df stringFromDate:btn.date]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]];
            
            if ([_dates containsObject:btn.date]) {
                
                if ([[df dateFromString:[df stringFromDate:btn.date]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:self.selectDate]]] == 0) {
                    
                    btn.type = CalendarButtonTypeSelectPro;
                    
                }else if (timeInterval==0) {
                    
                    btn.type = CalendarButtonTypeTodayPro;
                    
                }else{
                    
                    btn.type = CalendarButtonTypeNormal;
                    
                }
                
            }else
            {
                
                if ([[df dateFromString:[df stringFromDate:btn.date]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:self.selectDate]]] == 0) {
                    
                    btn.type = CalendarButtonTypeSelectDay;
                    
                }else if (timeInterval==0) {
                    
                    btn.type = CalendarButtonTypeToday;
                    
                }else
                {
                    
                    btn.type = CalendarButtonTypeNoProgramme;
                    
                }
                
            }
            
        }
        
    }
    
}

-(void)monthClick:(MonthCalendarButton*)button
{
    
    [self.delegate closeCalendarInput];
    
}

-(void)calendarClick:(CalendarButton*)btn
{
    
    [self.delegate dateSelected:btn];
    
    self.selectDate = btn.date;
    
}

@end

@interface MOMonthView ()<UIScrollViewDelegate,MOCalendarViewDelegate>

{
    
    UIScrollView *_scrollView;
    
    NSArray *_lastMonthDates;
    
    NSArray *_thisMonthDates;
    
    NSArray *_nextMonthDates;
    
}

@end

@implementation MOMonthView

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        
        _scrollView.delegate = self;
        
        _scrollView.contentSize = CGSizeMake(frame.size.width*3, 0);
        
        _scrollView.pagingEnabled = YES;
        
        _scrollView.bounces = NO;
        
        _scrollView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_scrollView];
        
        for (NSInteger i = 0; i<3; i++) {
            
            MOCalendarView *calendarView = [[MOCalendarView alloc]initWithFrame:CGRectMake(i*frame.size.width, 0, frame.size.width, frame.size.height)];
            
            calendarView.tag = i;
            
            calendarView.delegate = self;
            
            [_scrollView addSubview:calendarView];
            
        }
        
        _scrollView.contentOffset = CGPointMake(MSW, 0);
        
    }
    
    return self;
    
}

-(void)setSelectDate:(NSDate *)selectDate
{
    
    _selectDate = selectDate;
    
    for (UIView *subView in _scrollView.subviews) {
        
        if ([subView isKindOfClass:[MOCalendarView class]]) {
            
            MOCalendarView *calendarView = (MOCalendarView *)subView;
            
            calendarView.selectDate = _selectDate;
            
        }
        
    }
    
}

-(void)setDate:(NSDate *)date
{
    
    _date = date;
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps = [calendar components:unitFlags fromDate:_date];
    
    NSInteger days = [comps day];
    
    NSInteger numberOfDays = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:_date].length;
    
    NSInteger numberOfDays1 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate dateWithTimeInterval:days*-86400 sinceDate:_date]].length;
    
    NSDate *lastMonthDate = [NSDate dateWithTimeInterval:numberOfDays1*-86400 sinceDate:_date];
    
    NSDate *nextMonthDate = [NSDate dateWithTimeInterval:numberOfDays*86400 sinceDate:_date];
    
    MOCalendarView *lastMonthView = _scrollView.subviews[0];
    
    MOCalendarView *thisMonthView = _scrollView.subviews[1];
    
    MOCalendarView *nextMonthView = _scrollView.subviews[2];
    
    lastMonthView.currentDate = lastMonthDate;
    
    thisMonthView.currentDate = _date;
    
    nextMonthView.currentDate = nextMonthDate;
    
    if (!_lastMonthDates) {
        
        CalendarInfo *lastInfo = [[CalendarInfo alloc]init];
        
        [lastInfo requsetWithDate:lastMonthDate result:^(BOOL success, NSString *error) {
            
            _lastMonthDates = lastInfo.dates;
            
            lastMonthView.dates = _lastMonthDates;
            
        }];
        
    }
    
    if (!_thisMonthDates) {
        
        CalendarInfo *thisInfo = [[CalendarInfo alloc]init];
        
        [thisInfo requsetWithDate:_date result:^(BOOL success, NSString *error) {
            
            _thisMonthDates = thisInfo.dates;
            
            thisMonthView.dates = _thisMonthDates;
            
        }];
        
    }
    
    if (!_nextMonthDates) {
        
        CalendarInfo *nextInfo = [[CalendarInfo alloc]init];
        
        [nextInfo requsetWithDate:nextMonthDate result:^(BOOL success, NSString *error) {
            
            _nextMonthDates = nextInfo.dates;
            
            nextMonthView.dates = _nextMonthDates;
            
        }];
        
    }
    
}

-(void)reloadContent
{
    
    [_scrollView setContentOffset:CGPointMake(MSW, 0) animated:NO];
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    NSInteger x = scrollView.contentOffset.x;
    
    if (x == MSW*2) {
        
        [self reloadWithTimeType:TimeTypeFuture];
        
        [self reloadContent];
        
    }else if(x == 0)
    {
        
        [self reloadWithTimeType:TimeTypePass];
        
        [self reloadContent];
        
    }

}

-(void)reloadWithTimeType:(TimeType)timeType
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps = [calendar components:unitFlags fromDate:_date];
    
    NSInteger days = [comps day];
    
    MOCalendarView *lastMonthView = _scrollView.subviews[0];
    
    MOCalendarView *thisMonthView = _scrollView.subviews[1];
    
    MOCalendarView *nextMonthView = _scrollView.subviews[2];
    
    if (timeType == TimeTypeFuture) {
        
        NSInteger numberOfDays = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:_date].length;
        
        NSDate *nextMonthDate = [NSDate dateWithTimeInterval:numberOfDays*86400 sinceDate:_date];
        
        self.date = nextMonthDate;
        
        _lastMonthDates = [_thisMonthDates copy];
        
        _thisMonthDates = [_nextMonthDates copy];
        
        lastMonthView.dates = _lastMonthDates;
        
        thisMonthView.dates = _thisMonthDates;
        
        CalendarInfo *nextInfo = [[CalendarInfo alloc]init];
        
        [nextInfo requsetWithDate:nextMonthDate result:^(BOOL success, NSString *error) {
            
            _nextMonthDates = nextInfo.dates;
            
            nextMonthView.dates = _nextMonthDates;
            
        }];
        
    }else{
        
        NSInteger numberOfDays1 = [calendar rangeOfUnit:NSDayCalendarUnit inUnit:NSMonthCalendarUnit forDate:[NSDate dateWithTimeInterval:days*-86400 sinceDate:_date]].length;
        
        NSDate *lastMonthDate = [NSDate dateWithTimeInterval:numberOfDays1*-86400 sinceDate:_date];
        
        self.date = lastMonthDate;
        
        _nextMonthDates = [_thisMonthDates copy];
        
        _thisMonthDates = [_lastMonthDates copy];
        
        nextMonthView.dates = _nextMonthDates;
        
        thisMonthView.dates = _thisMonthDates;
        
        CalendarInfo *lastInfo = [[CalendarInfo alloc]init];
        
        [lastInfo requsetWithDate:lastMonthDate result:^(BOOL success, NSString *error) {
            
            _lastMonthDates = lastInfo.dates;
            
            lastMonthView.dates = _lastMonthDates;
            
        }];
        
    }
    
}

-(void)dateSelected:(CalendarButton *)btn
{
    
    if ([self.delegate respondsToSelector:@selector(monthViewSelectDate:)]) {
        
        [self.delegate monthViewSelectDate:btn.date];
        
    }
    
}

-(void)closeCalendarInput
{
    
    if ([self.delegate respondsToSelector:@selector(closeMonthView)]) {
        
        [self.delegate closeMonthView];
        
    }
    
}

@end
