//
//  GymPay.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymPay : NSObject

@property(nonatomic,assign)NSInteger month;

@property(nonatomic,assign)NSInteger price;

@property(nonatomic,assign)NSInteger discardedPrice;

@property(nonatomic,assign)BOOL privilege;

@property(nonatomic,assign)BOOL canUsed;

@property(nonatomic,assign)BOOL choosed;

@end
