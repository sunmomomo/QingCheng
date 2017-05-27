//
//  GymDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "PayHelp.h"

@interface GymDetailInfo : NSObject

@property(nonatomic,strong)NSArray *banners;

@property(nonatomic,strong)NSArray *stats;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,assign)BOOL haveNew;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error,NSInteger errorCode);

@property(nonatomic,strong)void(^renewCallBack)(BOOL success,NSString *urlStr);

@property(nonatomic,strong)void(^normalCallBack)(BOOL success,NSString *error);

-(void)requestWithGym:(Gym *)gym result:(void(^)(BOOL success,NSString *error,NSInteger errorCode))result;

-(void)renewGym:(Gym*)gym payWay:(PayWay)way result:(void(^)(BOOL success,NSString *urlStr))result;

-(void)quitGymResult:(void(^)(BOOL success,NSString *error,NSInteger errorCode))result;

-(void)requestWechatResult:(void(^)(BOOL success,NSString *error))result;

-(void)uploadWechatImg:(NSURL *)wechatImg andWechatName:(NSString *)wechatName result:(void(^)(BOOL success,NSString *error))result;

-(void)gymTryResult:(void(^)(BOOL success,NSString *error))result;

@end
