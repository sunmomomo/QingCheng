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

-(instancetype)initWithDate:(NSDate*)date;

@end
