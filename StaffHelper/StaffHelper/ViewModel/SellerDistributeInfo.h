//
//  SellerDistributeInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/10/18.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Seller.h"

@interface SellerDistributeInfo : NSObject

@property(nonatomic,strong)NSMutableArray *sellers;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)deleteUser:(Student *)user withSeller:(Seller*)seller withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)deleteUsers:(NSArray *)users withSeller:(Seller*)seller withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)changeUsers:(NSArray *)users withOriginalSeller:(Seller*)originalSeller withSellers:(NSArray*)sellers withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

-(void)addUsers:(NSArray*)users withSeller:(Seller*)seller withGym:(Gym *)gym result:(void (^)(BOOL success, NSString *error))result;

@end
