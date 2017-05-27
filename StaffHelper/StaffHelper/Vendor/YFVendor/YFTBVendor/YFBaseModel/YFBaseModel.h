//
//  YFBaseModel.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/14.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBaseModel : NSObject

- (instancetype)initWithDictionary:(NSDictionary *)jsonDic;
- (instancetype)initWithYYModelDictionary:(NSDictionary*)jsonDic;

- (void)failRequest:(NSError *)error;

+ (instancetype)defaultWithDic:(NSDictionary *)dic;
+ (instancetype)defaultWithYYModelDic:(NSDictionary *)dic;

- (void)cellSettingYF;

@end
