//
//  PayHelp.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

#import "Spec.h"

#import "PayActionSheet.h"

@interface PayHelp : NSObject

@property(nonatomic,assign)float integral;

@property(nonatomic,assign)BOOL haveIntegral;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error,NSURL *url);

-(void)createWithCard:(Card*)card andSpec:(Spec*)spec andGym:(Gym*)gym andSellerId:(NSInteger)sellerId andRemarks:(NSString *)remarks andPayWay:(PayWay)way result:(void(^)(BOOL success,NSString *error,NSURL *url))result;

-(void)rechargeWithCard:(Card*)card andSpec:(Spec*)spec andGym:(Gym*)gym andSellerId:(NSInteger)sellerId andRemarks:(NSString *)remarks andPayWay:(PayWay)way result:(void(^)(BOOL success,NSString *error,NSURL *url))result;

-(void)calculateWithSpec:(Spec*)spec andGym:(Gym*)gym andPayWay:(PayType)type result:(void(^)(BOOL success,NSString *error,NSURL *url))result;

@end
