//
//  YFFilterOtherModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFFilterOtherModel.h"
#import "NSObject+YFExtension.h"

#import "NSMutableDictionary+YFExtension.h"

@implementation YFFilterOtherModel

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.status = @"";
        self.startTime = @"";
        self.endTime = @"";
        self.recoPeopleStrs = @"";
        self.originStrs = @"";
        
        self.isCopyParam = NO;
        
        self.isCanFilterSeller = NO;
        
        self.isCanFilterBirthday = NO;
        
        self.isShouldChooseTodayWhenClear = NO;
    }
    return self;
}


- (instancetype)modelCopy
{
    YFFilterOtherModel *modelCopy = [[YFFilterOtherModel alloc] init];
    
    modelCopy.status  = self.status;
    modelCopy.startTime  = self.startTime;
    modelCopy.endTime  = self.endTime;
    modelCopy.startBirthDayTime = self.startBirthDayTime;
    modelCopy.endBirthDayTime = self.endBirthDayTime;
    modelCopy.recoPeopleStrs  = self.recoPeopleStrs;
    modelCopy.originStrs  = self.originStrs;
    modelCopy.gender  = self.gender;
    modelCopy.seller_id  = self.seller_id;
    modelCopy.timeType = self.timeType;
    
    modelCopy.isCopyParam = self.isCopyParam;
    self.isCopyParam = NO;
    
    
    return modelCopy;
}

- (instancetype)modelCopyAllConditon
{
    YFFilterOtherModel *modelCopy = [self modelCopy];
    
    modelCopy.allOrigDic = self.allOrigDic.mutableCopy;
    modelCopy.allRecoDic = self.allRecoDic.mutableCopy;
    
    return modelCopy;
}

- (BOOL)isEmptyYF
{
    if (self.status.length == 0 && self.startTime.length == 0 && self.endTime.length == 0 && self.recoPeopleStrs.length == 0 && self.originStrs.length == 0) {
        return YES;
    }
    return NO;
}



-(void)setAllRecoDic:(NSMutableDictionary *)allRecoDic
{
    _allRecoDic = allRecoDic;
    
    NSArray *allKeys = [_allRecoDic allKeys];
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *str in allKeys) {
        [string appendString:str];
        [string appendString:@","];
    }
    self.recoPeopleStrs = string;
}

- (void)setAllOrigDic:(NSMutableDictionary *)allOrigDic
{
    _allOrigDic = allOrigDic;
    
    NSArray *allKeys = [_allOrigDic allKeys];
    
    NSMutableString *string = [NSMutableString string];
    
    for (NSString *str in allKeys) {
        [string appendString:str];
        [string appendString:@","];
    }
    self.originStrs = string;
}

- (NSMutableDictionary *)paramWithDictionary:(NSMutableDictionary *)para
{
    if (para == nil ||  [para isKindOfClass:[NSMutableDictionary class]] == NO) {
        para = [NSMutableDictionary dictionary];
    }
    
    [para addEntriesFromDictionary:[self paramDicYF]];
    return para;
}

- (NSMutableDictionary *)paramWithSingleDictionary:(NSMutableDictionary *)para
{
    if (para == nil ||  [para isKindOfClass:[NSMutableDictionary class]] == NO) {
        para = [NSMutableDictionary dictionary];
    }
    
    [para addEntriesFromDictionary:[self paramDicSingleChooseYF]];
    return para;
}


// 单选时
- (NSMutableDictionary *)paramDicSingleChooseYF
{
    NSMutableDictionary * para = [self paramBaseDicYF];
    
    [para setStringLengthNotZero_FY:[self.recoPeopleStrs stringByReplacingOccurrencesOfString:@"," withString:@""] toKey:@"recommend_user_id"];
//    [para setStringLengthNotZero_FY:self.originName toKey:@"origin"];
    [para setStringLengthNotZero_FY:[self.originStrs stringByReplacingOccurrencesOfString:@"," withString:@""] toKey:@"origin_ids"];

    
    return para;
}


// 单选时 ,有额外的非 请求param 的接口
- (NSMutableDictionary *)paramExtionDicSingleChooseYF
{
    NSMutableDictionary * para = [self paramBaseDicYF];
    
    [para setStringLengthNotZero_FY:[self.recoPeopleStrs stringByReplacingOccurrencesOfString:@"," withString:@""] toKey:@"recommend_user_id"];
//    [para setStringLengthNotZero_FY:self.originName toKey:@"origin"];
    [para setStringLengthNotZero_FY:self.originStrs toKey:@"origin_ids"];

    
    [para setNotNilObje_FY:@(self.timeType) toKey:YFIsRegisterTimeKey];

    return para;
}



// 单选时
- (NSMutableDictionary *)paramDicYF
{
    NSMutableDictionary * para = [self paramBaseDicYF];
    
   
    [para setStringLengthNotZero_FY:self.recoPeopleStrs toKey:@"recommend_user_ids"];
    [para setStringLengthNotZero_FY:self.originStrs toKey:@"origin_ids"];
    
    return para;
}

- (NSMutableDictionary *)paramBaseDicYF
{
    NSMutableDictionary * para = [NSMutableDictionary dictionary];
    
    [para setStringLengthNotZero_FY:self.startTime toKey:@"start"];
    [para setStringLengthNotZero_FY:self.endTime toKey:@"end"];
    [para setStringLengthNotZero_FY:self.status toKey:@"status_ids"];
    
    [para setStringLengthNotZero_FY:self.startBirthDayTime toKey:@"from_date"];
    [para setStringLengthNotZero_FY:self.endBirthDayTime toKey:@"to_date"];
    
    [para setStringLengthNotZero_FY:self.seller_id toKey:@"seller_id"];
    
//#warning 销售分配 不管用
    [para setStringLengthNotZero_FY:self.gender toKey:YFGenderKeyForParam];
    
    return para;
}

- (void)getParamWithDic:(NSDictionary *)paramDic
{
    self.isCopyParam = YES;
    
    NSDictionary *dateParam = paramDic[@"DataParam"];
    
    if ([dateParam isKindOfClass:[NSDictionary class]])
    {
        self.startTime = dateParam[@"start"];
        
        self.endTime = dateParam[@"end"];
    }else
    {
        self.startTime = paramDic[@"start"];
        
        self.endTime = paramDic[@"end"];
    }
    
    
    NSNumber *timeNum = paramDic[YFIsRegisterTimeKey];
    
    if (timeNum)
    {
        self.timeType = timeNum.integerValue;
    }else
    {
        self.timeType = YFIsRegisterTimeTypeNone;
    }
    
    self.seller_id = paramDic[@"seller_id"];
    
    self.status = paramDic[@"status"];
    
//    NSString *origin = paramDic[@"origin"];
    
//    self.originName = origin;
//    self.originStrs = @"";
    
//    NSString *recommend_user_id = paramDic[@"recommend_user_id"];
    
//    self.recoPeopleStrs = [recommend_user_id stringByReplacingOccurrencesOfString:@"," withString:@""];
//
//    self.allRecoDic = [NSMutableDictionary dictionaryWithDictionary:@{@"222":self.recoPeopleStrs}];
}

@end
