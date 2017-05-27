//
//  SellersInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Seller.h"

#import "Gym.h"

@interface SellersInfo : NSObject

@property(nonatomic,strong)NSMutableArray *sellers;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithGym:(Gym*)gym Result:(void(^)(BOOL success,NSString *error))result;


-(void)requestOnlySellerWithGym:(Gym*)gym Result:(void(^)(BOOL success,NSString *error))result;


@end
