//
//  Parameters.h
//  馍馍帝
//
//  Created by 馍馍帝😈 on 15/7/24.
//  Copyright (c) 2015年 馍馍帝. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Parameters : NSObject

@property(nonatomic,strong)NSMutableDictionary *data;

-(void)setParameter:(id)parameter forKey:(NSString *)key;

-(void)setInteger:(NSInteger)integer forKey:(NSString *)key;

-(void)removeParameterWithKey:(NSString *)key;

@end
