//
//  SpecListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/24.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Spec.h"

@interface SpecListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *specs;

@property(nonatomic,strong)NSMutableArray *positions;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCardKind:(CardKind *)cardKind result:(void(^)(BOOL success,NSString *error))result;

-(void)createSpec:(Spec*)spec result:(void(^)(BOOL success,NSString *error))result;

-(void)changeSpec:(Spec*)spec result:(void(^)(BOOL success,NSString *error))result;

-(void)deleteSpec:(Spec*)spec result:(void(^)(BOOL success,NSString *error))result;

-(void)requestPositionsResult:(void(^)(BOOL success,NSString *error))result;

@end
