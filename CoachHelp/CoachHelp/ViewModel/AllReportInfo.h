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

@property(nonatomic,strong)NSMutableArray *reportInfos;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)ReportInfo *totalReportInfo;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,copy)RequestCallBack callBack;

-(instancetype)initWithType:(ReportInfoType)type;

-(ReportInfo*)getShowInfoWithGym:(Gym *)gym;

-(void)requestInfoWithGym:(Gym *)gym result:(void(^)(BOOL success,NSString *error))result;

@end
