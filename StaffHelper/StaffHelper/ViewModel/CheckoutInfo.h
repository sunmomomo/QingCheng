//
//  CheckoutInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Checkout.h"

@interface CheckoutInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)NSArray *checkouts;

-(void)requestWithStudent:(Student *)stu result:(void(^)(BOOL success,NSString *error))result;

-(void)checkoutWithCheckout:(Checkout*)checkout result:(void(^)(BOOL success,NSString *error))result;

-(void)manualCheckoutWithCheckout:(Checkout*)checkout result:(void(^)(BOOL success,NSString *error))result;

-(void)ignoreWithCheckout:(Checkout*)checkout result:(void(^)(BOOL success,NSString *error))result;

@end
