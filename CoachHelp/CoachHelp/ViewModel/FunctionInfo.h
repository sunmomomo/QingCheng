//
//  FunctionInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FunctionInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)scanWithString:(NSString *)str andURL:(NSString *)url result:(void (^)(BOOL success, NSString *error))result;

-(void)scanWithString:(NSString *)str andModule:(NSString *)module result:(void (^)(BOOL success, NSString *error))result;

@end
