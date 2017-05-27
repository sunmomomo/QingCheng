//
//  YFBaseParam.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseParam.h"
#import "YYModel.h"



@implementation YFBaseParam

- (instancetype)init
{
    self = [super init];
    if (self) {
    }
    return self;
}

- (id)buildParamFY
{
    return [self yy_modelToJSONObject];
}

- (void)setObjectFY:(NSObject *)object toKey:(NSString *)key
{
    if (object)
    {
        [self.paramDic setObject:object forKey:key];
    }
}

- (NSString *)buildUrlString
{
    return @"";
}

-(NSMutableDictionary *)paramDic
{
    if (_paramDic == nil)
    {
        _paramDic = [NSMutableDictionary dictionary];
    }
    return _paramDic;
}

@end
