//
//  YFRespoBaseModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFRespoBaseModel : NSObject

@property(nonatomic, strong)Class modelClass;

@property(nonatomic, strong)Class responseDataClass;

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic responseData:(Class)responseDataClass model:(Class)modelClass;


@end
