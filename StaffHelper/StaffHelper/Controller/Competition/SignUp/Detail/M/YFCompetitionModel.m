//
//  YFCompetitionModel.m
//  StaffHelper
//
//  Created by FYWCQ on 17/3/30.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "YFCompetitionModel.h"

#import "YFDateService.h"

@implementation YFCompetitionModel


- (NSInteger)beginDays
{

    if (!self.start)
    {
        return -1;
    }
    return [YFDateService calcDaysCurrentToDateString:self.start];
    
}

#pragma mark Data
+ (NSDictionary<NSString *,id> *)modelCustomPropertyMapper
{
    return @{@"c_id":@"id"
             };
}


@end
