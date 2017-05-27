//
//  YFBaseModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseModel.h"
#import "YFAppConfig.h"
#import "YFAppService.h"

#import "YYModel.h"

@implementation YFBaseModel

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self cellSettingYF];
    }
    return self;
}


- (instancetype)initWithDictionary:(NSDictionary*)jsonDic
{
    if ((self = [super init]))
    {
        [self cellSettingYF];
        if ([jsonDic isKindOfClass:[NSDictionary class]] == NO)
        {
            DebugLogYF(@"%@ %@",jsonDic,[self class]);
            return self;
        }else
            
            [self setValuesForKeysWithDictionary:jsonDic];
    }
    return self;
}

- (void)cellSettingYF
{
    
}
- (instancetype)initWithYYModelDictionary:(NSDictionary*)jsonDic
{
    if ((self = [super init]))
    {
        [self cellSettingYF];
        if ([jsonDic isKindOfClass:[NSDictionary class]] == NO)
        {
            DebugLogYF(@"%@ %@",jsonDic,[self class]);
            return self;
        }else
            
            [self yy_modelSetWithDictionary:jsonDic];
    }
    return self;
}


+ (instancetype)defaultWithDic:(NSDictionary *)dic
{
    return [[[self class] alloc] initWithDictionary:dic];
}

+ (instancetype)defaultWithYYModelDic:(NSDictionary *)dic
{
    return [[[self class] alloc] initWithYYModelDictionary:dic];
}

- (void)setValue:(id)value forKey:(NSString *)key
{
    [super setValue:value forKey:key];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    DebugLogYF(@"Undefined Key:%@ in %@",key,[self class]);
}

//   ing 失败掉的 方法
- (void)failRequest:(NSError *)error
{
    [YFAppService showAlertMessageWithError:error];
}

@end
