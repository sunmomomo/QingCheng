//
//  YFRespoBaseModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFRespoBaseModel.h"
#import "YFAppConfig.h"


@implementation YFRespoBaseModel

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic responseData:(Class)responseDataClass model:(Class)modelClass
{
    if ((self = [super init]))
    {
        self.modelClass  = modelClass;
        self.responseDataClass = responseDataClass;
        
        if ([jsonDic isKindOfClass:[NSDictionary class]] == NO)
        {
            DebugLogYF(@"%@ %@",jsonDic,[self class]);
        }else
        {
            [self setValuesForKeysWithDictionary:jsonDic];
        }
    }
    return self;
}


@end
