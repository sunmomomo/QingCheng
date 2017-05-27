//
//  EventManager.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/15.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <EventKit/EventKit.h>

#import "ProgrammeInfo.h"

@interface EventManager : NSObject

+(instancetype)sharedManager;

-(void)getEvent;

-(void)saveInfo:(ProgrammeInfo *)info;

-(NSString*)checkEventWithStart:(NSString *)start andEnd:(NSString*)end;

@end
