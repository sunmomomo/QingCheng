//
//  CoursePlansInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/8.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoursePlan.h"

#import "Course.h"

@interface CoursePlansInfo : NSObject

@property(nonatomic,strong)NSMutableArray *data;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,copy)void(^deleteFinish)(BOOL success);

@property(nonatomic,copy)void(^changeFinish)(BOOL success);

-(instancetype)initWithCourse:(Course*)course andBatchId:(NSInteger)batchId;

-(void)changeWithPlan:(CoursePlan *)plan andCourse:(Course *)course;

-(void)deleteWithPara:(Parameters *)para andCourse:(Course *)course;

@end
