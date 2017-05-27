//
//  Report.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Report : NSObject

@property(nonatomic,assign)NSInteger checkinNum;

@property(nonatomic,assign)NSInteger appointmentNum;

@property(nonatomic,assign)NSInteger serviceNum;

@property(nonatomic,assign)NSInteger courseNum;

@property(nonatomic,assign)BOOL isToday;

@property(nonatomic,copy)NSString *fromDate;

@property(nonatomic,copy)NSString *toDate;

@property(nonatomic,assign)float cost;

@end
