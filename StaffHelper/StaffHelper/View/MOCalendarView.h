//
//  MOCalendarView.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CalendarButton.h"

@protocol MOCalendarViewDelegate;

@interface MOCalendarView : UIView

@property(nonatomic,strong)NSDate *selectDate;

@property(nonatomic,assign)id<MOCalendarViewDelegate> delegate;

@property(nonatomic,strong)NSDate *currentDate;

-(void)reload;

@end

@protocol MOCalendarViewDelegate <NSObject>

@required

-(void)dateSelected:(CalendarButton*)btn;

@end
