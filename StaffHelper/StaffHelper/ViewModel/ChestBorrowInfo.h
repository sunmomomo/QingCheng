//
//  ChestBorrowInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/23.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Chest.h"

@interface ChestBorrowInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)borrowTempChest:(Chest*)chest withUser:(Student*)user result:(void(^)(BOOL success,NSString *error))result;

-(void)borrowLongUseChest:(Chest*)chest withUser:(Student*)user andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void(^)(BOOL success,NSString *error))result;

-(void)returnTempChest:(Chest*)chest result:(void(^)(BOOL success,NSString *error))result;

-(void)returnLongUseChest:(Chest*)chest result:(void(^)(BOOL success,NSString *error))result;

-(void)returnLongUseChest:(Chest*)chest andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void(^)(BOOL success,NSString *error))result;

-(void)continueChest:(Chest*)chest andCard:(Card *)card orPayWay:(PayWay)payWay andCost:(NSInteger)cost result:(void(^)(BOOL success,NSString *error))result;

@end
