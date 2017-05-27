//
//  HomeInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface HomeInfo : NSObject

@property(nonatomic,strong)void (^callBackSuccess)();

@property(nonatomic,strong)void (^callBackFailure)();

@property(nonatomic,assign)NSInteger totalServices;

@property(nonatomic,strong)NSArray *banners;

@property(nonatomic,strong)NSArray *stats;

@property(nonatomic,assign)BOOL haveNew;

-(void)requestSuccess:(void(^)(NSInteger total))success failure:(void(^)(NSInteger errorCode))failure;

@end
