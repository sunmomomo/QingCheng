//
//  CalendarInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/21.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalendarInfo : NSObject

@property(nonatomic,strong)NSMutableArray *dates;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requsetWithDate:(NSDate *)date result:(void(^)(BOOL success,NSString*error))result;

-(instancetype)initWithDate:(NSDate*)date;

@end
