//
//  GymPayHistory.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GymPayHistory : NSObject

@property(nonatomic,copy)NSString *time;

@property(nonatomic,copy)NSString *fromDate;

@property(nonatomic,copy)NSString *toDate;

@property(nonatomic,assign)NSInteger price;

@property(nonatomic,assign)NSInteger month;

@property(nonatomic,assign)BOOL onlinePay;

@property(nonatomic,assign)BOOL isTried;

@property(nonatomic,strong)Staff *staff;

@property(nonatomic,copy)NSString *remarks;

@property(nonatomic,assign)BOOL success;

@end
