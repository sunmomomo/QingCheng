//
//  MOCalendarView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CalendarButtonTypeNormal = 0,
    CalendarButtonTypeSelectDay = 1,
    CalendarButtonTypeSelectPro = 2,
    CalendarButtonTypeNoProgramme = 3,
    CalendarButtonTypeToday = 4,
    CalendarButtonTypeTodayPro = 5,
    CalendarButtonTypeNotThisMonth =6,
} CalendarButtonType;

@interface CalendarButton : UIButton

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,assign)CalendarButtonType type;

@end

@protocol MOCalendarViewDelegate;

@interface MOCalendarView : UIView

@property(nonatomic,assign)id<MOCalendarViewDelegate> delegate;

@property(nonatomic,strong)NSDate *currentDate;

@property(nonatomic,strong)NSDate *selectDate;

-(void)reload;

@end

@protocol MOCalendarViewDelegate <NSObject>

@required

-(void)dateSelected:(CalendarButton*)btn;

-(void)closeCalendarInput;

@end

@protocol MOMonthViewDelegate <NSObject>

-(void)monthViewSelectDate:(NSDate *)date;

-(void)closeMonthView;

@end

@interface MOMonthView : UIView

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,strong)NSDate *selectDate;

@property(nonatomic,weak)id<MOMonthViewDelegate> delegate;

@end
