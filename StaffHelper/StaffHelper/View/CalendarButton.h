//
//  CalendarButton.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum : NSUInteger {
    CalendarButtonTypeNoDate = 0,
    CalendarButtonTypeTodayPro = 1,
    CalendarButtonTypeNoProgramme = 2,
    CalendarButtonTypePast = 3,
    CalendarButtonTypeFuture = 4,
    CalendarButtonTypeToday = 5,
} CalendarButtonType;

@interface CalendarButton : UIButton

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,assign)CalendarButtonType type;

@end
