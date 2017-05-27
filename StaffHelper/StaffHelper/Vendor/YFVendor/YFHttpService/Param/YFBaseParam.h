//
//  YFBaseParam.h
//  OCTBLogical
//
//  Created by FYWCQ on 16/12/17.
//  Copyright © 2016年 YFWCQ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YFBaseParam : NSObject

@property(nonatomic,copy)NSString *urlString;

@property(nonatomic,strong)NSMutableDictionary *paramDic;

-(id)buildParamFY;

-(void)setObjectFY:(NSObject *)object toKey:(NSString *)key;

-(NSString *)buildUrlString;

@end
