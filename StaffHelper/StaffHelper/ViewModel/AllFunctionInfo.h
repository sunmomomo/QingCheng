//
//  AllFunctionInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/12.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Function : NSObject

@property(nonatomic,copy)NSString *key;

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *imagePath;

@property(nonatomic,copy)NSString *module;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,assign)BOOL pro;

@end

@interface FunctionGroup : NSObject

@property(nonatomic,strong)NSArray *functions;

@property(nonatomic,copy)NSString *title;

@end

@interface AllFunctionInfo : NSObject

@property(nonatomic,strong)NSArray *allFunctions;

@property(nonatomic,strong)NSMutableArray *myFunctions;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

+(AllFunctionInfo*)defaultInfo;

+(Function*)functionWithKey:(NSString *)key;

+(NSArray*)defaultFunctions;

-(void)requestMyFunctionResult:(void(^)(BOOL success,NSString *error))result;

-(void)uploadMyFunctions:(NSArray *)functions result:(void(^)(BOOL success,NSString *error))result;

@end
