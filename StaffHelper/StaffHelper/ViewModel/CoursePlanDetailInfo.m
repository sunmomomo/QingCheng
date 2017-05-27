//
//  CoursePlanDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "CoursePlanDetailInfo.h"

#define API @"/api/staffs/%ld/batches/%ld/"

#define CreateAPI @"/api/staffs/%ld/arrange/batches/"

#define CheckAPI @"/api/staffs/%ld/%@/arrange/check/"

#define ChangeAPI @"/api/staffs/%ld/batches/%ld/"

#define TemplateAPI @"/api/staffs/%ld/%@/arrange/template/"

#define SingleAPI @"/api/staffs/%ld/%@/%ld/"

@implementation CoursePlanDetailInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.batch = [[CoursePlanBatch alloc]init];
        
    }
    return self;
}

-(void)requestWithBatchId:(NSInteger)batchId
{
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)batchId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *cardKinds = [NSMutableArray array];
            
            NSMutableArray *onlinePays = [NSMutableArray array];
            
            for (NSDictionary *dict in responseDic[@"data"][@"batch"][@"rule"]) {
                
                if ([dict[@"channel"] isEqualToString:@"CARD"]) {
                    
                    CardCost *cost = [[CardCost alloc]init];
                    
                    cost.fromNumber = [dict[@"from_number"] integerValue];
                    
                    cost.toNumber = [dict[@"to_number"] integerValue];
                    
                    cost.perCost = [dict[@"cost"] integerValue];
                    
                    cost.costString = [NSString stringWithFormat:@"%ld",(long)cost.perCost];
                    
                    BOOL contains = NO;
                    
                    for (CardKind *cardKind in cardKinds) {
                        
                        if (cardKind.cardKindId == [dict[@"card_tpl_id"] integerValue]) {
                            
                            [cardKind.costs addObject:cost];
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        CardKind *cardKind = [[CardKind alloc]init];
                        
                        [cardKind.costs addObject:cost];
                        
                        cardKind.cardKindId = [dict[@"card_tpl_id"] integerValue];
                        
                        cardKind.isUsed = YES;
                        
                        for (NSDictionary *card_tpl_dict in responseDic[@"data"][@"batch"][@"card_tpls"]) {
                            
                            if (cardKind.cardKindId == [card_tpl_dict[@"id"] integerValue]) {
                                
                                cardKind.canCancel = [card_tpl_dict[@"status"] integerValue] == 1;
                                
                            }
                            
                        }
                        
                        [cardKinds addObject:cardKind];
                        
                    }
                    
                }else{
                    
                    OnlinePay *pay = [[OnlinePay alloc]init];
                    
                    pay.name = @"在线支付";
                    
                    pay.cost = [dict[@"cost"] floatValue];
                    
                    pay.costStr = [NSString formatStringWithFloat:pay.cost];
                    
                    pay.isUsed = YES;
                    
                    pay.astrict = dict[@"limits"][@"user_count"] || dict[@"limits"][@"user_status"];
                    
                    if (pay.astrict) {
                        
                        pay.astrictNumber = [dict[@"limits"][@"user_count"] integerValue];
                        
                        NSArray *astricts = dict[@"limits"][@"user_status"];
                        
                        pay.astrictNewLogin = [astricts containsObject:[NSNumber numberWithInteger:0]];
                        
                        pay.astrictFollowing = [astricts containsObject:[NSNumber numberWithInteger:1]];
                        
                        pay.astrictNormal = [astricts containsObject:[NSNumber numberWithInteger:2]];
                        
                    }
                    
                    [onlinePays addObject:pay];
                    
                }
                
            }
            
            self.batch.onlinePays = [onlinePays copy];
            
            self.batch.cardKinds = [cardKinds copy];
            
            NSDictionary *coachDict = responseDic[@"data"][@"batch"][@"teacher"];
            
            self.batch.coach.name = coachDict[@"username"];
            
            self.batch.coach.coachId = [coachDict[@"id"] integerValue];
            
            self.batch.coach.iconUrl = [NSURL URLWithString:coachDict[@"avatar"]];
            
            NSDictionary *courseDict = responseDic[@"data"][@"batch"][@"course"];
            
            self.batch.course.name = courseDict[@"name"];
            
            self.batch.course.during = [courseDict[@"length"] integerValue]/60;
            
            self.batch.course.courseId = [courseDict[@"id"] integerValue];
            
            self.batch.course.imgUrl = [NSURL URLWithString:courseDict[@"photo"]];
            
            self.batch.course.capacity = [responseDic[@"data"][@"batch"][@"max_users"] integerValue];
            
            NSMutableArray *yards = [NSMutableArray array];
            
            [responseDic[@"data"][@"batch"][@"spaces"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = obj[@"name"];
                
                yard.yardId = [obj[@"id"] integerValue];
                
                [yards addObject:yard];
                
            }];
            
            self.batch.yards = [yards copy];
            
            self.batch.start = responseDic[@"data"][@"batch"][@"from_date"];
            
            self.batch.end = responseDic[@"data"][@"batch"][@"to_date"];
            
            if ([[responseDic[@"data"][@"batch"] allKeys]containsObject:@"is_free"]) {
                
                self.batch.isFree = [responseDic[@"data"][@"batch"][@"is_free"] boolValue];
                
            }else{
                
                self.batch.isFree = YES;
                
            }
            
            if ([[responseDic[@"data"][@"batch"] allKeys]containsObject:@"has_order"]) {
                
                self.batch.hasOrder = [responseDic[@"data"][@"batch"][@"has_order"] boolValue];
                
            }else{
                
                self.batch.hasOrder = NO;
                
            }
            
            self.batch.batchId = [responseDic[@"data"][@"batch"][@"id"] integerValue];
            
            self.batch.course.coursePlans = [NSMutableArray array];
            
            for (NSDictionary *dict in responseDic[@"data"][@"batch"][@"time_repeats"]) {
                
                CoursePlan *plan = [[CoursePlan alloc]init];
                
                plan.startTime = dict[@"start"];
                
                plan.endTime = dict[@"end"];
                
                plan.planId = [dict[@"id"] integerValue];
                
                NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
                
                plan.week = weekArray[[dict[@"weekday"] integerValue]-1];
                
                [self.batch.course.coursePlans addObject:plan];
                
            }
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

-(void)createBatch:(CoursePlanBatch *)batch result:(void (^)(BOOL,NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithBool:batch.isFree] forKey:@"is_free"];
    
    NSMutableArray *rules = [NSMutableArray array];
    
    for (CardKind *cardKind in batch.cardKinds) {
        
        if (batch.course.type == CourseTypeGroup) {
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else{
                
                CardCost *cost = [cardKind.costs firstObject];
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"channel":@"CARD"}];
                
            }
            
        }else{
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else
            {
                
                for (CardCost *cost in cardKind.costs) {
                    
                    [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:cost.fromNumber],@"to_number":[NSNumber numberWithInteger:cost.toNumber],@"channel":@"CARD"}];
                    
                }
                
            }
            
        }
        
    }
    
    for (OnlinePay *pay in batch.onlinePays) {
        
        if (pay.astrict) {
            
            NSMutableArray *astrictArray = [NSMutableArray array];
            
            if (pay.astrictNewLogin) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:0]];
                
            }
            
            if (pay.astrictFollowing) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:1]];
                
            }
            
            if (pay.astrictNormal) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:2]];
                
            }
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE",@"limits":@{@"user_count":[NSNumber numberWithInteger:pay.astrictNumber],@"user_status":astrictArray}}];
            
        }else{
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE"}];
            
        }
        
    }
    
    [para setParameter:batch.start forKey:@"from_date"];
    
    [para setParameter:batch.end forKey:@"to_date"];
    
    [para setParameter:rules forKey:@"rules"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.courseId] forKey:@"course_id"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.capacity] forKey:@"max_users"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }

    NSMutableArray *yards = [NSMutableArray array];
    
    for (Yard *yard in batch.yards) {
        
        [yards addObject:[NSNumber numberWithInteger:yard.yardId]];
        
    }
    
    [para setParameter:yards forKey:@"spaces"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.coach.coachId] forKey:@"teacher_id"];
    
    NSMutableArray *timeRepeats = [NSMutableArray array];
    
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"HH:mm";
    
    for (CoursePlan *plan in batch.course.coursePlans) {
        
        for (NSString *weekStr in plan.weeks) {
            
            if (batch.course.type == CourseTypeGroup) {
                
                [timeRepeats addObject:@{@"start":plan.startTime,@"end":[df stringFromDate:[NSDate dateWithTimeInterval:60*batch.course.during sinceDate:[df dateFromString:plan.startTime]]],@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:weekStr]+1]}];
                
            }else
            {
                
                [timeRepeats addObject:@{@"start":plan.startTime,@"end":plan.endTime,@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:weekStr]+1]}];
                
            }
            
        }
        
    }
    
    [para setParameter:timeRepeats forKey:@"time_repeats"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreateAPI,StaffId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)checkBatch:(CoursePlanBatch *)batch result:(void (^)(BOOL,NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:batch.start forKey:@"from_date"];
    
    [para setParameter:batch.end forKey:@"to_date"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.courseId] forKey:@"course_id"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.capacity] forKey:@"max_users"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    NSMutableArray *rules = [NSMutableArray array];
    
    for (CardKind *cardKind in batch.cardKinds) {
        
        if (batch.course.type == CourseTypeGroup) {
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else{
                
                CardCost *cost = [cardKind.costs firstObject];
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"channel":@"CARD"}];
                
            }
            
        }else{
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else
            {
                
                for (CardCost *cost in cardKind.costs) {
                    
                    [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:cost.fromNumber],@"to_number":[NSNumber numberWithInteger:cost.toNumber],@"channel":@"CARD"}];
                    
                }
                
            }
            
        }
        
    }
    
    for (OnlinePay *pay in batch.onlinePays) {
        
        if (pay.astrict) {
            
            NSMutableArray *astrictArray = [NSMutableArray array];
            
            if (pay.astrictNewLogin) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:0]];
                
            }
            
            if (pay.astrictFollowing) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:1]];
                
            }
            
            if (pay.astrictNormal) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:2]];
                
            }
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE",@"limits":@{@"user_count":[NSNumber numberWithInteger:pay.astrictNumber],@"user_status":astrictArray}}];
            
        }else{
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE"}];
            
        }
        
    }
    
    [para setParameter:[rules copy] forKey:@"rules"];
    
    NSMutableArray *yards = [NSMutableArray array];
    
    for (Yard *yard in batch.yards) {
        
        [yards addObject:[NSNumber numberWithInteger:yard.yardId]];
        
    }
    
    [para setParameter:yards forKey:@"spaces"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.coach.coachId] forKey:@"teacher_id"];
    
    NSMutableArray *timeRepeats = [NSMutableArray array];
    
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"HH:mm";
    
    for (CoursePlan *plan in batch.course.coursePlans) {
        
        for (NSString *weekStr in plan.weeks) {
            
            if (batch.course.type == CourseTypeGroup) {
                
                [timeRepeats addObject:@{@"start":plan.startTime,@"end":[df stringFromDate:[NSDate dateWithTimeInterval:60*batch.course.during sinceDate:[df dateFromString:plan.startTime]]],@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:weekStr]+1]}];
                
            }else
            {
                
                [timeRepeats addObject:@{@"start":plan.startTime,@"end":plan.endTime,@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:weekStr]+1]}];
                
            }
            
        }
        
    }
    
    [para setParameter:[timeRepeats copy] forKey:@"time_repeats"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CheckAPI,StaffId,batch.course.type == CourseTypeGroup?@"group":@"private"] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)changeBatch:(CoursePlanBatch *)batch result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithBool:batch.isFree] forKey:@"is_free"];
    
    NSMutableArray *rules = [NSMutableArray array];
    
    for (CardKind *cardKind in batch.cardKinds) {
        
        if (batch.course.type == CourseTypeGroup) {
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else{
                
                CardCost *cost = [cardKind.costs firstObject];
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"channel":@"CARD"}];
                
            }
            
        }else{
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1]}];
                
            }else
            {
                
                for (CardCost *cost in cardKind.costs) {
                    
                    [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:cost.fromNumber],@"to_number":[NSNumber numberWithInteger:cost.toNumber],@"channel":@"CARD"}];
                    
                }
                
            }
            
        }
        
    }
    
    for (OnlinePay *pay in batch.onlinePays) {
        
        if (pay.isUsed) {
            
            if (pay.astrict) {
                
                NSMutableArray *astrictArray = [NSMutableArray array];
                
                if (pay.astrictNewLogin) {
                    
                    [astrictArray addObject:[NSNumber numberWithInteger:0]];
                    
                }
                
                if (pay.astrictFollowing) {
                    
                    [astrictArray addObject:[NSNumber numberWithInteger:1]];
                    
                }
                
                if (pay.astrictNormal) {
                    
                    [astrictArray addObject:[NSNumber numberWithInteger:2]];
                    
                }
                
                [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE",@"limits":@{@"user_count":[NSNumber numberWithInteger:pay.astrictNumber],@"user_status":astrictArray}}];
                
            }else{
                
                [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:batch.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE"}];
                
            }
            
        }
        
    }
    
    [para setParameter:batch.start forKey:@"from_date"];
    
    [para setParameter:batch.end forKey:@"to_date"];
    
    [para setParameter:rules forKey:@"rules"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.courseId] forKey:@"course_id"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.course.capacity] forKey:@"max_users"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (batch.gym.gymId && batch.gym.type.length){
        
        [para setParameter:batch.gym.type forKey:@"model"];
        
        [para setInteger:batch.gym.gymId forKey:@"id"];
        
    }else if(batch.gym.shopId && batch.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:batch.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:batch.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    NSMutableArray *yards = [NSMutableArray array];
    
    for (Yard *yard in batch.yards) {
        
        [yards addObject:[NSNumber numberWithInteger:yard.yardId]];
        
    }
    
    [para setParameter:yards forKey:@"spaces"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.coach.coachId] forKey:@"teacher_id"];
    
    NSMutableArray *timeRepeats = [NSMutableArray array];
    
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"HH:mm";
    
    for (CoursePlan *plan in batch.course.coursePlans) {
        
        if (batch.course.type == CourseTypeGroup) {
            
            [timeRepeats addObject:@{@"start":plan.startTime,@"end":[df stringFromDate:[NSDate dateWithTimeInterval:60*batch.course.during sinceDate:[df dateFromString:plan.startTime]]],@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:plan.week]+1],@"id":[NSNumber numberWithInteger:plan.planId]}];
            
        }else
        {
            
            [timeRepeats addObject:@{@"start":plan.startTime,@"end":plan.endTime,@"weekday":[NSNumber numberWithInteger:[weekArray indexOfObject:plan.week]+1],@"id":[NSNumber numberWithInteger:plan.planId]}];
            
        }
        
    }
    
    [para setParameter:timeRepeats forKey:@"time_repeats"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)batch.batchId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)deleteBatch:(CoursePlanBatch *)batch result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFDeleteHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,StaffId,(long)batch.batchId] deleteParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)requestAutoFillInfoWithBatch:(CoursePlanBatch *)batch result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (batch.gym.gymId && batch.gym.type.length){
        
        [para setParameter:batch.gym.type forKey:@"model"];
        
        [para setInteger:batch.gym.gymId forKey:@"id"];
        
    }else if(batch.gym.shopId && batch.gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:batch.gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:batch.gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }

    [para setParameter:[NSNumber numberWithInteger:batch.course.courseId] forKey:@"course_id"];
    
    [para setParameter:[NSNumber numberWithInteger:batch.coach.coachId] forKey:@"teacher_id"];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:TemplateAPI,StaffId,batch.course.type == CourseTypeGroup?@"group":@"private"] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSMutableArray *cardKinds = [NSMutableArray array];
            
            NSMutableArray *onlinePays = [NSMutableArray array];
            
            for (NSDictionary *dict in responseDic[@"data"][@"rule"]) {
                
                if ([dict[@"channel"] isEqualToString:@"CARD"]) {
                    
                    CardCost *cost = [[CardCost alloc]init];
                    
                    cost.fromNumber = [dict[@"from_number"] integerValue];
                    
                    cost.toNumber = [dict[@"to_number"] integerValue];
                    
                    cost.perCost = [dict[@"cost"] integerValue];
                    
                    cost.costString = [NSString stringWithFormat:@"%ld",(long)cost.perCost];
                    
                    BOOL contains = NO;
                    
                    for (CardKind *cardKind in cardKinds) {
                        
                        if (cardKind.cardKindId == [dict[@"card_tpl_id"] integerValue]) {
                            
                            [cardKind.costs addObject:cost];
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        CardKind *cardKind = [[CardKind alloc]init];
                        
                        [cardKind.costs addObject:cost];
                        
                        cardKind.cardKindId = [dict[@"card_tpl_id"] integerValue];
                        
                        cardKind.isUsed = YES;
                        
                        cardKind.canCancel = YES;
                        
                        [cardKinds addObject:cardKind];
                        
                    }
                    
                }else{
                    
                    OnlinePay *pay = [[OnlinePay alloc]init];
                    
                    pay.name = @"在线支付";
                    
                    pay.cost = [dict[@"cost"] floatValue];
                    
                    pay.costStr = [NSString formatStringWithFloat:pay.cost];
                    
                    pay.isUsed = YES;
                    
                    pay.astrict = dict[@"limits"][@"user_count"] || dict[@"limits"][@"user_status"];
                    
                    if (pay.astrict) {
                        
                        pay.astrictNumber = [dict[@"limits"][@"user_count"] integerValue];
                        
                        NSArray *astricts = dict[@"limits"][@"user_status"];
                        
                        pay.astrictNewLogin = [astricts containsObject:[NSNumber numberWithInteger:0]];
                        
                        pay.astrictFollowing = [astricts containsObject:[NSNumber numberWithInteger:1]];
                        
                        pay.astrictNormal = [astricts containsObject:[NSNumber numberWithInteger:2]];
                        
                    }
                    
                    [onlinePays addObject:pay];
                    
                }
                
            }
            
            self.batch.cardKinds = [cardKinds copy];
            
            NSMutableArray *timeRepeats = [NSMutableArray array];
            
            for (NSDictionary *dict in responseDic[@"data"][@"time_repeats"]) {
                
                CoursePlan *plan = [[CoursePlan alloc]init];
                
                plan.startTime = dict[@"start"];
                
                plan.endTime = dict[@"end"];
                
                plan.autoFill = YES;
                
                NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
                
                plan.weeks = [@[weekArray[[dict[@"weekday"] integerValue]-1]] mutableCopy];
                
                BOOL contains = NO;
                
                for (CoursePlan *tempPlan in timeRepeats) {
                    
                    if ([plan.startTime isEqualToString:tempPlan.startTime] && [plan.endTime isEqualToString:tempPlan.endTime]) {
                        
                        [tempPlan.weeks addObject:[plan.weeks firstObject]];
                        
                        contains = YES;
                        
                        break;
                        
                    }
                    
                }
                
                if (!contains) {
                    
                    [timeRepeats addObject:plan];
                    
                }
                
            }
            
            self.batch.course.coursePlans = [timeRepeats mutableCopy];
            
            if ([[responseDic[@"data"] allKeys]containsObject:@"is_free"]) {
                
                self.batch.isFree = [responseDic[@"data"][@"is_free"] boolValue];
                
            }else{
                
                self.batch.isFree = YES;
                
            }
            
            self.batch.course.capacity = [responseDic[@"data"][@"max_users"] integerValue];
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

-(void)requestWithPlan:(CoursePlan *)plan result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:SingleAPI,StaffId,plan.course.type == CourseTypeGroup?@"schedules":@"timetables",(long)plan.planId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue]== 200) {
            
            NSDictionary *planDict = plan.course.type == CourseTypeGroup?responseDic[@"data"][@"schedule"]:responseDic[@"data"][@"timetable"];
            
            self.plan = plan;
            
            NSMutableArray *cardKinds = [NSMutableArray array];
            
            NSMutableArray *onlinePays = [NSMutableArray array];
            
            plan.date = [[planDict[@"start"] componentsSeparatedByString:@"T"]firstObject];
            
            if (plan.date.length>=7) {
                
                plan.month = [plan.date substringToIndex:7];
                
            }
            
            if ([[[planDict[@"start"] componentsSeparatedByString:@"T"]lastObject] length]>=5) {
                
                plan.startTime = [[[planDict[@"start"] componentsSeparatedByString:@"T"]lastObject] substringToIndex:5];
                
            }
            
            if ([[[planDict[@"end"] componentsSeparatedByString:@"T"]lastObject] length]>=5) {
                
                plan.endTime = [[[planDict[@"end"] componentsSeparatedByString:@"T"]lastObject] substringToIndex:5];
                
            }
            
            NSArray *rules = plan.course.type == CourseTypeGroup?planDict[@"rules"]:planDict[@"rule"];
            
            for (NSDictionary *dict in rules) {
                
                if ([dict[@"channel"] isEqualToString:@"CARD"]) {
                    
                    CardCost *cost = [[CardCost alloc]init];
                    
                    cost.fromNumber = [dict[@"from_number"] integerValue];
                    
                    cost.toNumber = [dict[@"to_number"] integerValue];
                    
                    cost.perCost = [dict[@"cost"] integerValue];
                    
                    cost.costString = [NSString stringWithFormat:@"%ld",(long)cost.perCost];
                    
                    BOOL contains = NO;
                    
                    for (CardKind *cardKind in cardKinds) {
                        
                        if (cardKind.cardKindId == [dict[@"card_tpl_id"] integerValue]) {
                            
                            [cardKind.costs addObject:cost];
                            
                            contains = YES;
                            
                            break;
                            
                        }
                        
                    }
                    
                    if (!contains) {
                        
                        CardKind *cardKind = [[CardKind alloc]init];
                        
                        [cardKind.costs addObject:cost];
                        
                        cardKind.cardKindId = [dict[@"card_tpl_id"] integerValue];
                        
                        cardKind.isUsed = YES;
                        
                        for (NSDictionary *card_tpl_dict in planDict[@"card_tpls"]) {
                            
                            if (cardKind.cardKindId == [card_tpl_dict[@"id"] integerValue]) {
                                
                                cardKind.canCancel = [card_tpl_dict[@"status"] integerValue] == 1;
                                
                            }
                            
                        }
                        
                        [cardKinds addObject:cardKind];
                        
                    }
                    
                }else{
                    
                    OnlinePay *pay = [[OnlinePay alloc]init];
                    
                    pay.name = @"在线支付";
                    
                    pay.cost = [dict[@"cost"] floatValue];
                    
                    pay.costStr = [NSString formatStringWithFloat:pay.cost];
                    
                    pay.isUsed = YES;
                    
                    pay.astrict = dict[@"limits"][@"user_count"] || dict[@"limits"][@"user_status"];
                    
                    if (pay.astrict) {
                        
                        pay.astrictNumber = [dict[@"limits"][@"user_count"] integerValue];
                        
                        NSArray *astricts = dict[@"limits"][@"user_status"];
                        
                        pay.astrictNewLogin = [astricts containsObject:[NSNumber numberWithInteger:0]];
                        
                        pay.astrictFollowing = [astricts containsObject:[NSNumber numberWithInteger:1]];
                        
                        pay.astrictNormal = [astricts containsObject:[NSNumber numberWithInteger:2]];
                        
                    }
                    
                    [onlinePays addObject:pay];
                    
                }
                
            }
            
            self.plan.onlinePays = [onlinePays copy];
            
            self.plan.cardKinds = [cardKinds copy];
            
            NSDictionary *coachDict = planDict[@"teacher"];
            
            self.plan.coach.name = coachDict[@"username"];
            
            self.plan.coach.coachId = [coachDict[@"id"] integerValue];
            
            self.plan.coach.iconUrl = [NSURL URLWithString:coachDict[@"avatar"]];
            
            NSDictionary *courseDict = planDict[@"course"];
            
            self.plan.course.name = courseDict[@"name"];
            
            self.plan.course.during = [courseDict[@"length"] integerValue]/60;
            
            self.plan.course.courseId = [courseDict[@"id"] integerValue];
            
            self.plan.course.imgUrl = [NSURL URLWithString:courseDict[@"photo"]];
            
            self.plan.course.capacity = [planDict[@"max_users"] integerValue];
            
            NSMutableArray *yards = [NSMutableArray array];
            
            if (plan.course.type == CourseTypeGroup) {
                
                NSDictionary *space = planDict[@"space"];
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = space[@"name"];
                
                yard.yardId = [space[@"id"] integerValue];
                
                [yards addObject:yard];
                
            }else{
                
                NSArray *spaces = planDict[@"spaces"];
                
                [spaces enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Yard *yard = [[Yard alloc]init];
                    
                    yard.name = obj[@"name"];
                    
                    yard.yardId = [obj[@"id"] integerValue];
                    
                    [yards addObject:yard];
                    
                }];
                
            }
            
            self.plan.yards = [yards copy];
            
            if ([[planDict allKeys]containsObject:@"is_free"]) {
                
                self.plan.isFree = [planDict[@"is_free"] boolValue];
                
            }else{
                
                self.plan.isFree = YES;
                
            }
            
            if ([[planDict allKeys]containsObject:@"has_order"]) {
                
                self.plan.hasOrder = [planDict[@"has_order"] boolValue];
                
            }else{
                
                self.plan.hasOrder = NO;
                
            }
            
            self.plan.planId = [planDict[@"id"] integerValue];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];

}

-(void)changePlan:(CoursePlan *)plan result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithBool:plan.isFree] forKey:@"is_free"];
    
    NSMutableArray *rules = [NSMutableArray array];
    
    for (CardKind *cardKind in plan.cardKinds) {
        
        if (plan.course.type == CourseTypeGroup) {
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:plan.course.capacity+1]}];
                
            }else{
                
                CardCost *cost = [cardKind.costs firstObject];
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:plan.course.capacity+1],@"channel":@"CARD"}];
                
            }
            
        }else{
            
            if (cardKind.type == CardKindTypeTime) {
                
                [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"channel":@"CARD",@"from_number":[NSNumber numberWithInteger:1],@"to_number":[NSNumber numberWithInteger:plan.course.capacity+1]}];
                
            }else
            {
                
                for (CardCost *cost in cardKind.costs) {
                    
                    [rules addObject:@{@"card_tpl_id":[NSNumber numberWithInteger:cardKind.cardKindId],@"cost":[NSNumber numberWithInteger:cost.perCost],@"from_number":[NSNumber numberWithInteger:cost.fromNumber],@"to_number":[NSNumber numberWithInteger:cost.toNumber],@"channel":@"CARD"}];
                    
                }
                
            }
            
        }
        
    }
    
    for (OnlinePay *pay in plan.onlinePays) {
        
        if (pay.astrict) {
            
            NSMutableArray *astrictArray = [NSMutableArray array];
            
            if (pay.astrictNewLogin) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:0]];
                
            }
            
            if (pay.astrictFollowing) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:1]];
                
            }
            
            if (pay.astrictNormal) {
                
                [astrictArray addObject:[NSNumber numberWithInteger:2]];
                
            }
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:plan.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE",@"limits":@{@"user_count":[NSNumber numberWithInteger:pay.astrictNumber],@"user_status":astrictArray}}];
            
        }else{
            
            [rules addObject:@{@"card_tpl_id":@"0",@"from_number":@"1",@"to_number":[NSNumber numberWithInteger:plan.course.capacity+1],@"cost":[NSNumber numberWithFloat:pay.cost],@"channel":@"ONLINE"}];
            
        }
        
    }
    
    [para setParameter:rules forKey:@"rule"];
    
    [para setParameter:[NSNumber numberWithInteger:plan.course.courseId] forKey:@"course_id"];
    
    [para setParameter:[NSNumber numberWithInteger:plan.course.capacity] forKey:@"max_users"];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }
    
    NSMutableArray *yards = [NSMutableArray array];
    
    for (Yard *yard in plan.yards) {
        
        [yards addObject:[NSNumber numberWithInteger:yard.yardId]];
        
    }
    
    [para setParameter:yards forKey:@"spaces"];
    
    [para setParameter:[NSNumber numberWithInteger:plan.coach.coachId] forKey:@"teacher_id"];
    
    NSArray *weekArray = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    
    NSDateFormatter *df = [[NSDateFormatter alloc]init];
    
    df.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
    
    df.dateFormat = @"HH:mm";
    
    if (plan.course.type == CourseTypeGroup) {
        
        [para setParameter:[NSString stringWithFormat:@"%@T%@:00",plan.date,plan.startTime] forKey:@"start"];
        
        [para setParameter:[NSString stringWithFormat:@"%@T%@:00",plan.date,[df stringFromDate:[NSDate dateWithTimeInterval:60*plan.course.during sinceDate:[df dateFromString:plan.startTime]]]] forKey:@"end"];
        
        [para setParameter:[NSNumber numberWithInteger:[weekArray indexOfObject:plan.week]+1] forKey:@"weekday"];
        
    }else
    {
        
        [para setParameter:[NSString stringWithFormat:@"%@T%@:00",plan.date,plan.startTime] forKey:@"start"];
        
        [para setParameter:[NSString stringWithFormat:@"%@T%@:00",plan.date,plan.endTime] forKey:@"end"];
        
        [para setParameter:[NSNumber numberWithInteger:[weekArray indexOfObject:plan.week]+1] forKey:@"weekday"];
        
    }
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:SingleAPI,StaffId,plan.course.type == CourseTypeGroup?@"schedules":@"timetables",(long)plan.planId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

@end
