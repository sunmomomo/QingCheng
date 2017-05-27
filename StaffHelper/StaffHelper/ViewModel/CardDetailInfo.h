//
//  CardDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface CardDetailInfo : NSObject

@property(nonatomic,copy)NSString *totalRecharge;

@property(nonatomic,copy)NSString *totalCost;

@property(nonatomic,strong)Card *card;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCard:(Card*)card Result:(void(^)(BOOL success,NSString *error))result;

-(void)stopWithCardId:(NSInteger)cardId Result:(void(^)(BOOL success,NSString *error))result;

-(void)renewWithCardId:(NSInteger)cardId Result:(void(^)(BOOL success,NSString *error))result;

-(void)changeCard:(Card*)card withGym:(Gym*)gym Result:(void(^)(BOOL success,NSString *error))result;

@end
