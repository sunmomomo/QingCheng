//
//  CoursePlanDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoursePlanBatch.h"

@interface CoursePlanDetailInfo : NSObject

@property(nonatomic,strong)CoursePlanBatch *batch;

@property(nonatomic,strong)CoursePlan *plan;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requestWithBatchId:(NSInteger)batchId;

-(void)createBatch:(CoursePlanBatch*)batch result:(void(^)(BOOL success,NSString *error))result;

-(void)changeBatch:(CoursePlanBatch*)batch result:(void(^)(BOOL success,NSString *error))result;

-(void)checkBatch:(CoursePlanBatch*)batch result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteBatch:(CoursePlanBatch*)batch result:(void(^)(BOOL success,NSString *error))result;

-(void)requestAutoFillInfoWithBatch:(CoursePlanBatch*)batch result:(void(^)(BOOL success,NSString *error))result;

-(void)requestWithPlan:(CoursePlan*)plan result:(void(^)(BOOL success,NSString *error))result;

-(void)changePlan:(CoursePlan*)plan result:(void(^)(BOOL success,NSString *error))result;

@end
