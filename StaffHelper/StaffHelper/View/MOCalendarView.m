//
//  MOCalendarView.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "MOCalendarView.h"

@interface MOCalendarView ()

{
    
    UILabel *_monthLabel;
    
    NSMutableArray *_buttonArray;
    
}

@property(nonatomic,strong)NSMutableArray *buttonArray;

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
    
    UIButton *leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    leftBtn.frame = CGRectMake(0, 0, Width320(32), Height320(39.1));
    
    leftBtn.tag = 101;
    
    [leftBtn addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *leftArrow = [[UIImageView alloc]initWithFrame:CGRectMake(Width320(21.3), Height320(14.2), Width320(6.7), Height320(10.7))];
    
    leftArrow.image = [UIImage imageNamed:@"cellarrowleft"];
    
    leftArrow.userInteractionEnabled = NO;
    
    [leftBtn addSubview:leftArrow];
    
    [self addSubview:leftBtn];
    
    UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    rightBtn.frame = CGRectMake(MSW-leftBtn.width, 0, leftBtn.width, leftBtn.height);
    
    rightBtn.tag = 102;
    
    [rightBtn addTarget:self action:@selector(arrowClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIImageView *rightArrow = [[UIImageView alloc]initWithFrame:CGRectMake(rightBtn.width-leftArrow.left, leftArrow.top, leftArrow.width, leftArrow.height)];
    
    rightArrow.image = [UIImage imageNamed:@"cellarrow"];
    
    [rightBtn addSubview:rightArrow];
    
    [self addSubview:rightBtn];
    
    _monthLabel = [[UILabel alloc]initWithFrame:CGRectMake(leftBtn.right, 0, MSW-leftBtn.width*2, leftBtn.height)];
    
    _monthLabel.font = AllFont(15);
    
    _monthLabel.textColor = UIColorFromRGB(0x666666);
    
    _monthLabel.textAlignment = NSTextAlignmentCenter;
    
    [self addSubview:_monthLabel];
    
    UIView *sep = [[UIView alloc]initWithFrame:CGRectMake(0, leftBtn.bottom, MSW, 1)];
    
    sep.backgroundColor = UIColorFromRGB(0xdddddd);
    
    [self addSubview:sep];
    
    for (NSInteger i = 0; i<7; i++) {
        
        CGFloat width = (MSW-Width320(30))/7;
        
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(Width320(15)+i*width, leftBtn.bottom+Height320(13.3), width, Height320(15.1))];
        
        label.textColor = UIColorFromRGB(0x666666);
        
        label.textAlignment = NSTextAlignmentCenter;
        
        label.font = AllFont(12);
        
        label.text = i==0?@"日":i==1?@"一":i==2?@"二":i==3?@"三":i==4?@"四":i==5?@"五":@"六";
        
        [self addSubview:label];
        
    }
    
    for(NSInteger i = 0;i<6;i++)
    {
        
        for (NSInteger j = 0; j<7; j++) {
            
            CalendarButton *btn = [[CalendarButton alloc]initWithFrame:CGRectMake(Width320(28)+j*Width320(40.8), leftBtn.bottom+Height320(40.3)+i*Height320(28.4), Width320(28.4), Height320(32.4))];
            
            [self addSubview:btn];
            
            btn.tag = i*7+j+1;
        
            [btn addTarget:self action:@selector(calendarClick:) forControlEvents:UIControlEventTouchUpInside];
            
            [_buttonArray addObject:btn];
            
        }
        
    }
    
    [self reload];
    
}


-(void)arrowClick:(UIButton*)btn
{
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSRange range = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_currentDate];
    
    NSInteger numberOfDaysInMonth = range.length;
    
    if (btn.tag == 101) {
        
        self.currentDate = [NSDate dateWithTimeInterval:-24*60*60*numberOfDaysInMonth sinceDate:_currentDate];
        
    }else
    {
        
        self.currentDate = [NSDate dateWithTimeInterval:86400*numberOfDaysInMonth sinceDate:_currentDate];
        
    }
    
    [self reload];
    
}

-(void)reload
{
    
    for (CalendarButton *btn in self.buttonArray) {
        
        btn.date = nil;
        
        btn.type = CalendarButtonTypeNoDate;
        
    }
    
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSCalendarIdentifierGregorian];
    
    NSDateComponents *comps;
    
    NSInteger unitFlags = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitWeekday;
    
    comps = [calendar components:unitFlags fromDate:_currentDate];
    
    _monthLabel.text = [NSString stringWithFormat:[comps month]<10?@"%ld年0%ld月":@"%ld年%ld月",(long)[comps year],(long)[comps month]];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    [df setDateFormat:@"yyyy-MM-dd"];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    NSDate *firstDate = [df dateFromString:[[[df stringFromDate:_currentDate] substringToIndex:8] stringByAppendingString:@"01"]];
    
    NSDateComponents *comps1;
    
    comps1 = [calendar components:unitFlags fromDate:firstDate];
    
    NSInteger numberOfDays = [calendar rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:_currentDate].length;
    
    NSInteger week = [comps1 weekday];
    
    for (NSInteger i = week; i<week+numberOfDays; i++) {
        
        NSDate *date = [NSDate dateWithTimeInterval:86400*(i-week) sinceDate:firstDate];
        
        for (CalendarButton *btn in _buttonArray) {
            
            if (btn.tag == i) {
                
                btn.date = date;
                
            }
            
        }
        
    }
    
    for (CalendarButton *btn in self.buttonArray) {
        
        if (btn.date) {
            
            if ([[df dateFromString:[df stringFromDate:btn.date]] timeIntervalSinceDate:[df dateFromString:[df stringFromDate:[NSDate date]]]]==0) {
                
                btn.type = CalendarButtonTypeToday;
                
            }
            
        }
        
    }

}

-(void)calendarClick:(CalendarButton*)btn
{
    
    [self.delegate dateSelected:btn];
    
}

@end
