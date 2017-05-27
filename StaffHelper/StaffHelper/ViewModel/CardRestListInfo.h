//
//  CardRestListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

#import "CardRest.h"

@interface CardRestListInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString*result);

@property(nonatomic,strong)NSMutableArray *rests;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

-(void)requestWithCard:(Card*)card;

-(void)addRest:(CardRest*)rest result:(void(^)(BOOL success,NSString*result))result;

-(void)cancelRest:(CardRest*)rest result:(void(^)(BOOL success,NSString*result))result;

@end
