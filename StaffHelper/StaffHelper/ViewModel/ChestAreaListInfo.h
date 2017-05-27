//
//  ChestAreaListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChestArea.h"

@interface ChestAreaListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *areas;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestDataResult:(void(^)(BOOL success,NSString *error))result;

-(void)createArea:(ChestArea *)area result:(void(^)(BOOL success,NSString *error))result;

-(void)editArea:(ChestArea*)area result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteArea:(ChestArea *)area result:(void(^)(BOOL success,NSString *error))result;

@end
