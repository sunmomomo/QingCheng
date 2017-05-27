//
//  CardKindInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardKind.h"

@interface CardKindInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL result,NSString *error);

-(void)requestDataWithCardKind:(CardKind*)cardKind result:(void(^)(BOOL success,NSString *error))result;

-(void)createCardKind:(CardKind*)cardKind result:(void(^)(BOOL success,NSString *error))result;

-(void)updateCardKind:(CardKind *)cardKind result:(void (^)(BOOL success, NSString *error))result;

-(void)updateCardKindGyms:(CardKind *)cardKind result:(void (^)(BOOL success, NSString *error))result;

-(void)deleteCardKind:(CardKind *)cardKind result:(void (^)(BOOL success, NSString *error))result;

-(void)renewCardKind:(CardKind *)cardKind result:(void (^)(BOOL success, NSString *error))result;

@end
