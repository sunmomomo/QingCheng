//
//  ProgrammeInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/8.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Programme.h"

@interface ProgrammeInfo : NSObject

@property(nonatomic,strong)NSDate *startDate;

@property(nonatomic,strong)NSDate *endDate;

@property(nonatomic,strong)NSMutableArray *programmes;

@property(nonatomic,copy)void(^request)(BOOL success);

-(instancetype)initWithDate:(NSDate*)date;

-(void)requestDataWithGym:(Gym*)gym;

-(void)requestEventInfo;

@end
