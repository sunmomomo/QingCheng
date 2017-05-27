//
//  WeekScheduleView.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2016/11/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "Programme.h"

@protocol WeekScheduleViewDelegate <NSObject>

-(void)weekViewChooseProgrammesWithDate:(NSDate *)date;

-(void)weekViewChooseProgramme:(Programme*)programme;

-(void)agentClickWithType:(AgentType)agentType andDate:(NSString *)date;

@end

@interface WeekScheduleView : UIScrollView

@property(nonatomic,weak)id<WeekScheduleViewDelegate> datasource;

@property(nonatomic,strong)NSDate *date;

@property(nonatomic,strong)NSArray *schedules;

-(void)hideAgent;

@end
