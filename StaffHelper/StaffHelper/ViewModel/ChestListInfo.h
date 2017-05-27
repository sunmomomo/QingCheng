//
//  ChestListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChestArea.h"

#import "Chest.h"

@interface ChestListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *areas;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestDataResult:(void(^)(BOOL success,NSString *error))result;

-(void)createChest:(Chest *)chest result:(void(^)(BOOL success,NSString *error))result;

-(void)editChest:(Chest*)chest result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteChest:(Chest *)chest result:(void(^)(BOOL success,NSString *error))result;

@end
