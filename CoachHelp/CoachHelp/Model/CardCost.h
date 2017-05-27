//
//  CardCost.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/2/2.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CardCost : NSObject<NSCoding>

@property(nonatomic,assign)NSInteger fromNumber;

@property(nonatomic,assign)NSInteger toNumber;

@property(nonatomic,assign)NSInteger perCost;

@property(nonatomic,copy)NSString *costString;

@end
