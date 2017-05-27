//
//  CalendarView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "WeekScheduleView.h"

typedef enum : NSUInteger {
    CalendarViewTypeWeek,
    CalendarViewTypeDay,
} CalendarViewType;

@protocol CalendarViewDatasource <UITableViewDataSource,DZNEmptyDataSetSource,WeekScheduleViewDelegate>

-(NSArray*)programmesAtIndex:(NSInteger)index;

-(void)reloadCalendarData;

-(void)reloadWeekDataWithType:(TimeType)timeType;

-(void)reloadTodayData;

-(void)getDate;

@end

@protocol CalendarViewDelegate <UITableViewDelegate,DZNEmptyDataSetDelegate>

-(void)calendarClick;

@end

@interface CalendarView : UIView

@property(nonatomic,assign,setter=setDatasource:)id<CalendarViewDatasource>datasource;

@property(nonatomic,assign,setter=setDelegate:)id<CalendarViewDelegate>delegate;

@property(nonatomic,strong,setter=setCurrentDate:)NSDate *currentDate;

@property(nonatomic,assign)CalendarViewType type;

@property(nonatomic,assign)BOOL isWeek;

-(void)reloadAtIndex:(NSInteger)index;

-(void)reloadWeekViewAtIndex:(NSInteger)index;

-(void)endRefresh;

-(void)reloadContent;

-(void)hideAgent;

-(void)onlySetDate:(NSDate *)date;

@end
