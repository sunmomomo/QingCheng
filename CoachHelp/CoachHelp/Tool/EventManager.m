//
//  EventManager.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/15.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "EventManager.h"

@interface EventManager ()

{
    
    EKEventStore *_eventStore;
    
}

@property(nonatomic,strong)ProgrammeInfo *programmeInfo;

@property(nonatomic,strong)NSOperationQueue *queue;

@end

@implementation EventManager

+(instancetype)sharedManager
{
    
    static EventManager * manager;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[self alloc] init];
    });
    
    if (!manager.queue) {
        
        manager.queue = [[NSOperationQueue alloc]init];
        
    }
    
    return manager;
    
}

-(instancetype)init
{
    
    if (self = [super init]) {
        
        _eventStore = [[EKEventStore alloc]init];
        
        self.queue = [[NSOperationQueue alloc]init];
        
        [self.queue setMaxConcurrentOperationCount:5];
        
    }
    
    return self;
    
}

-(void)getEvent
{
    
    NSDate *eventDate = [[NSUserDefaults standardUserDefaults]valueForKey:@"eventDate"];
    
    if (eventDate && [[NSDate date]timeIntervalSinceDate:eventDate]<3600) {
        
        return;
        
    }
    
    [[NSUserDefaults standardUserDefaults]setValue:[NSDate date] forKey:@"eventDate"];
    
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    self.programmeInfo = [[ProgrammeInfo alloc]init];
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(saveEventWithInfo:) object:self.programmeInfo];
    
    [self.programmeInfo requestEventInfoResult:^(BOOL success, NSString *error) {
        
        if (success) {
            
            [self.queue addOperation:operation];
            
        }
        
    }];
    
}

-(void)saveInfo:(ProgrammeInfo *)info
{
    
    NSInvocationOperation *operation = [[NSInvocationOperation alloc]initWithTarget:self selector:@selector(saveEventWithInfo:) object:info];
    
    [self.queue addOperation:operation];
    
}

-(void)saveEventWithInfo:(ProgrammeInfo *)info
{
    
    if (info.startDate && info.endDate) {
        
        [self clearEventWithStartDate:info.startDate andEndDate:info.endDate];
        
    }
    
    BOOL noCalendar = [[NSUserDefaults standardUserDefaults]boolForKey:@"noCalendar"];
    
    BOOL noNotification = [[NSUserDefaults standardUserDefaults]boolForKey:@"noNotification"];
    
    if (noCalendar && noNotification) {
        
        return;
        
    }
    
    if (!noCalendar) {
        
        [_eventStore requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            
            if (error) {
                
            }else if (!granted)
            {
                //被用户拒绝，不允许访问日历
                
            }else
            {
                
                BOOL shouldAdd = YES;
                
                EKCalendar *calendar;
                
                if ([_eventStore respondsToSelector:@selector(calendarsForEntityType:)]) {
                    
                    NSArray *array = [_eventStore calendarsForEntityType:EKEntityTypeEvent];
                    
                    for (EKCalendar *ekcalendar in array) {
                        
                        if ([ekcalendar.title isEqualToString:@"青橙科技"]) {
                            
                            if (!shouldAdd) {
                                
                                [_eventStore removeCalendar:ekcalendar commit:YES error:nil];
                                
                            }
                            
                            shouldAdd = NO;
                            
                            calendar = ekcalendar;
                            
                        }
                        
                    }
                    
                    if (shouldAdd) {
                        
                        // Get the calendar source
                        EKSource *localSource = nil;
                        for (EKSource *source in _eventStore.sources)
                        {
                            if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"我的iPhone上"])
                            {
                                localSource = source;
                                break;
                            }
                        }
                        
                        if (localSource == nil) {
                            
                            for (EKSource *source in _eventStore.sources)
                            {
                                if (source.sourceType == EKSourceTypeCalDAV && [source.title isEqualToString:@"iCloud"])
                                {
                                    localSource = source;
                                    break;
                                }
                            }
                            
                        }
                        
                        if (localSource == nil)
                        {
                            for (EKSource *source in _eventStore.sources) {
                                if (source.sourceType == EKSourceTypeLocal)
                                {
                                    localSource = source;
                                    break;
                                }
                            }
                        }
                        
                        calendar = [EKCalendar calendarForEntityType:EKEntityTypeEvent eventStore:_eventStore];
                        
                        calendar.source = localSource;
                        
                        calendar.title = @"青橙科技";
                        
                        calendar.CGColor = kMainColor.CGColor;
                        
                        NSError* error;
                        
                        [_eventStore saveCalendar:calendar commit:YES error:&error];
                        
                    }
                    
                    NSArray *tempArray = [NSArray arrayWithArray:info.programmes];
                    
                    for (Programme *programme in tempArray) {
                        
                        if (programme.style != ProgrammeStyleRest) {
                            
                            NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
                            
                            dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
                            
                            dateFormatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
                            
                            EKEvent *event  = [EKEvent eventWithEventStore:_eventStore];
                            
                            NSDate* ssdate = [NSDate dateWithTimeIntervalSinceNow:-3600*24*90];//事件段，开始时间
                            NSDate* ssend = [NSDate dateWithTimeIntervalSinceNow:3600*24*90];//结束时间，取中间
                            NSPredicate* predicate = [_eventStore predicateForEventsWithStartDate:ssdate
                                                                                         endDate:ssend
                                                                                       calendars:nil];
                            NSArray* events = [_eventStore eventsMatchingPredicate:predicate];
                            
                            for (EKEvent *tempEvent in events) {
                                
                                if ([[dateFormatter stringFromDate:tempEvent.startDate]isEqualToString:programme.startTime]&&[[dateFormatter stringFromDate:tempEvent.endDate]isEqualToString:programme.endTime]) {
                                    
                                    dispatch_async(dispatch_get_main_queue(), ^{
                                        
                                        [_eventStore removeEvent:tempEvent span:EKSpanThisEvent error:nil];
                                        
                                    });
                                    
                                }
                                
                            }
                            
                            event.title = [NSString stringWithFormat:@"%@ - [健身教练助手]", [programme description]];
                            event.location = programme.gym.name;
                            event.notes = [programme ordersDescription];
                            
                            event.calendar = calendar;
                            
                            event.startDate = [dateFormatter dateFromString:programme.startTime];
                            
                            event.endDate = [dateFormatter dateFromString:programme.endTime];
                            
                            NSInteger remindTime = [[NSUserDefaults standardUserDefaults]integerForKey:@"remindTime"];
                            
                            if (remindTime == 0) {
                                
                                [event addAlarm:[EKAlarm alarmWithRelativeOffset:-60.0f *60]];
                                
                            }else if (remindTime !=0 &&remindTime != -1)
                            {
                                
                                [event addAlarm:[EKAlarm alarmWithRelativeOffset:-60.0f *remindTime]];
                                
                            }
                            
                            event.allDay = NO;
                            
                            dispatch_async(dispatch_get_main_queue(), ^{
                                
                                [_eventStore saveEvent:event span:EKSpanThisEvent error:nil];
                                
                            });
                            
                        }
                        
                    }
                    
                }
                
            }
            
        }];
        
    }

}

-(void)clearNotificationWithStartDate:(NSDate*)startDate andEndDate:(NSDate *)endDate
{
    
    NSArray *localArray = [[UIApplication sharedApplication]scheduledLocalNotifications];
    
    if (localArray) {
        
        for (UILocalNotification *notification in localArray) {
            
            NSDate *startTime = notification.userInfo[@"startTime"];
            
            if ([startTime timeIntervalSinceDate:startDate]>0 && [startTime timeIntervalSinceDate:endDate]<0) {
                
                [[UIApplication sharedApplication]cancelLocalNotification:notification];
                
            }
            
        }
        
    }
    
}

-(void)clearEventWithStartDate:(NSDate*)startDate andEndDate:(NSDate *)endDate
{
    
    NSPredicate *pre = [_eventStore predicateForEventsWithStartDate:startDate endDate:endDate calendars:nil];
    
    NSArray *events = [_eventStore eventsMatchingPredicate:pre];
    
    for (EKEvent *event in events) {
        
        if ([event.calendar.title isEqualToString:@"青橙科技"]) {
            
            [_eventStore removeEvent:event span:EKSpanThisEvent commit:YES error:nil];
            
        }
        
    }
    
}

-(NSString*)checkEventWithStart:(NSString *)start andEnd:(NSString *)end
{
    
    if (!start || !end) {
        
        return nil;
        
    }
    
    NSDateFormatter *dateformatter = [[NSDateFormatter alloc]init];
    
    dateformatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    dateformatter.dateFormat = @"yyyy-MM-dd HH:mm:ss";
    
    NSPredicate *pre = [_eventStore predicateForEventsWithStartDate:[NSDate dateWithTimeInterval:1 sinceDate:[dateformatter dateFromString:start]] endDate:[NSDate dateWithTimeInterval:-1 sinceDate:[dateformatter dateFromString:end]] calendars:nil];
    
    NSArray *events = [_eventStore eventsMatchingPredicate:pre];
    
    __block NSString * result = nil;
    
    [events enumerateObjectsUsingBlock:^(EKEvent* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        if (![obj.calendar.title isEqualToString:@"青橙科技"]&&!obj.allDay) {
            
            result = obj.title;
            
            *stop = YES;
            
        }
        
    }];
    
    return result;
    
}

@end
