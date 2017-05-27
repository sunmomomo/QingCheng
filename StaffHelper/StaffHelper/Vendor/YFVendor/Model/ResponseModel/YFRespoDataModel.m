//
//  YFRespoDataModel.m
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFRespoDataModel.h"

@implementation YFRespoDataModel

-(instancetype)initWithDictionary:(NSDictionary *)jsonDic modelClass:(Class)modelClass
{
    self = [super initWithDictionary:jsonDic];
    if (self)
    {
        self.modelClass = modelClass;
        self.dic = jsonDic;
    }
    return self;
}

@end
