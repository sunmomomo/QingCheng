//
//  AllReportInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/13.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ReportInfo.h"

#import "Gym.h"

#import "ORDetailInfo.h"

@interface AllReportInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)ReportInfo *totalReportInfo;

-(instancetype)initWithType:(ReportInfoType)type;

-(void)requestInfoWithGym:(Gym *)gym result:(void(^)(BOOL success,NSString *error))result;

@end
