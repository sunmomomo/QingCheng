//
//  CalendarView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/6.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "MOTableView.h"

@protocol CalendarViewDatasource <MOTableViewDatasource>

-(void)setSliderable:(BOOL)able;

-(void)reloadCalendarData;

-(void)reloadTodayData;

-(void)getDate;

@end

@protocol CalendarViewDelegate <UITableViewDelegate>

-(void)calendarClick;

@end

@interface CalendarView : UIView

@property(nonatomic,assign,setter=setDatasource:)id<CalendarViewDatasource>datasource;

@property(nonatomic,assign,setter=setDelegate:)id<CalendarViewDelegate>delegate;

@property(nonatomic,strong,setter=setCurrentDate:)NSDate *currentDate;

-(void)reload;

-(void)endRefresh;

-(void)reloadContent;

@end
