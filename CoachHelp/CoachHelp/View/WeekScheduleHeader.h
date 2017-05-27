//
//  WeekScheduleHeader.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeekScheduleHeaderDelegate <NSObject>

-(void)headerDidEndScrollWithType:(TimeType)type;

-(void)headerTodayClick;

@end

@interface WeekScheduleHeader : UIView

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,weak)id<WeekScheduleHeaderDelegate>delegate;

@end
 
