//
//  YFRespoDataModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import "YFBaseModel.h"

@interface YFRespoDataModel : YFBaseModel


@property(nonatomic, strong)NSDictionary *dic;

@property(nonatomic, strong)Class modelClass;

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic modelClass:(Class)modelClass;


@end
