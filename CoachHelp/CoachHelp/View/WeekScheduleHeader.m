//
//  WeekScheduleHeader.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "WeekScheduleHeader.h"

@interface WeekCalendarButton : UIButton

{
    
    UILabel *_weekLabel;
    
    UILabel *_dateLabel;
    
    UIView *_lineView;
    
}

@property(nonatomic,copy)NSString *week;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)BOOL choosed;

@end

@implementation WeekCalendarButton

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
        
        _lineView = [[UIView alloc]initWithFrame:CGRectMake(Width320(4), frame.size.height-3, frame.size.width-Width320(8), 3)];
        
        _lineView.backgroundColor = kMainColor;
        
        _lineView.hidden = YES;
        
        [self addSubview:_lineView];
        
    }
    
    return self;
    
}

-(void)setChoosed:(BOOL)choosed
{
    
    _choosed = choosed;
    
    _dateLabel.textColor = _choosed?kMainColor:UIColorFromRGB(0x333333);
    
    _weekLabel.textColor = _choosed?kMainColor:UIColorFromRGB(0x999999);
    
    _lineView.hidden = !_choosed;
    
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

@interface WeekScheduleHeader ()<UIScrollViewDelegate>

{
    
    UIButton *_todayButton;
    
    UIScrollView *_buttonView;
    
}

@end

@implementation WeekScheduleHeader

- (instancetype)initWithFrame:(CGRect)frame
{
    
    self = [super initWithFrame:frame];
    
    if (self) {
        
        _todayButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, MSW/8, Height320(49))];
        
        _todayButton.backgroundColor = UIColorFromRGB(0xffffff);
        
        [self addSubview:_todayButton];
        
        UIImageView *todayImg = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(12), Height320(12), Width320(17), Height320(17))];
        
        todayImg.image = [UIImage imageNamed:@"calendar_today"];
        
        [_todayButton addSubview:todayImg];
        
        [_todayButton addTarget:self action:@selector(todayClick) forControlEvents:UIControlEventTouchUpInside];
        
        UIView *todayLine = [[UIView alloc]initWithFrame:CGRectMake(_todayButton.width-OnePX, Height320(12), OnePX, _todayButton.height-Height320(32))];
        
        todayLine.backgroundColor = UIColorFromRGB(0xdddddd);
        
        [_todayButton addSubview:todayLine];
        
        _buttonView = [[UIScrollView alloc]initWithFrame:CGRectMake(MSW/8, 0, MSW/8*7, Height320(49))];
        
        _buttonView.contentSize = CGSizeMake(_buttonView.width*3, 0);
        
        _buttonView.contentOffset = CGPointMake(_buttonView.width, 0);
        
        _buttonView.pagingEnabled = YES;
        
        _buttonView.delegate = self;
        
        _buttonView.bounces = NO;
        
        _buttonView.showsHorizontalScrollIndicator = NO;
        
        [self addSubview:_buttonView];
        
        for (NSInteger i =0; i<21; i++) {
            
            WeekCalendarButton *button = [[WeekCalendarButton alloc]initWithFrame:CGRectMake(i*MSW/8, 0, MSW/8, Height320(49))];
            
            if (i %7 == 0) {
                
                button.week = @"日";
                
            }else{
                
                NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
                
                formatter.numberStyle = kCFNumberFormatterRoundHalfDown;
                
                button.week = [formatter stringFromNumber:[NSNumber numberWithInteger:i%7]];
                
            }
            
            button.tag = i;
            
            [_buttonView addSubview:button];
            
        }
        
    }
    
    return self;
    
}

-(void)todayClick
{
    
    [self.delegate headerTodayClick];
    
}


-(void)setDate:(NSDate *)date
{
    
    _date = date;
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    
    dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    
    NSDateFormatter *df1 = [[NSDateFormatter alloc]init];
    
    df1.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df1.dateFormat = @"dd";
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSTimeZone *timeZone = [[NSTimeZone alloc] initWithName:@"Asia/Beijing"];
    
    [calendar setTimeZone: timeZone];
    
    NSCalendarUnit calendarUnit = NSWeekdayCalendarUnit;
    
    NSDateComponents *theComponents = [calendar components:calendarUnit fromDate:_date];
    
    NSDate *startDate = [NSDate dateWithTimeInterval:(theComponents.weekday+6)*-86400 sinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:date]]];
    
    for (UIView *subView in _buttonView.subviews) {

        if ([subView isKindOfClass:[WeekCalendarButton class]]) {
            
            WeekCalendarButton *button = (WeekCalendarButton*)subView;
            
            button.date = [df1 stringFromDate:[NSDate dateWithTimeInterval:button.tag*86400 sinceDate:startDate]];
            
            button.choosed = [[dateFormatter stringFromDate:[NSDate dateWithTimeInterval:button.tag*86400 sinceDate:startDate]] isEqualToString:[dateFormatter stringFromDate:[NSDate date]]];
            
        }
        
    }
    
}

-(void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    
    if (scrollView.contentOffset.x>(MSW/8*7*3/2)) {
        
        self.date = [NSDate dateWithTimeInterval:7*86400 sinceDate:_date];
        
        _buttonView.contentOffset = CGPointMake(_buttonView.width, 0);
        
        [self.delegate headerDidEndScrollWithType:TimeTypeFuture];
        
    }else if(scrollView.contentOffset.x<(MSW/8*7*1/2)){
        
        self.date = [NSDate dateWithTimeInterval:-7*86400 sinceDate:_date];
        
        _buttonView.contentOffset = CGPointMake(_buttonView.width, 0);
        
        [self.delegate headerDidEndScrollWithType:TimeTypePass];
        
    }
    
}

@end
