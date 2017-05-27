//
//  CoursePlanInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/4.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoursePlanBatch.h"

@interface CoursePlanInfo : NSObject

@property(nonatomic,strong)NSArray *batches;

@property(nonatomic,strong)Coach *coach;

@property(nonatomic,strong)Course *course;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requestPrivateData;

-(void)requestGroupData;

@end
