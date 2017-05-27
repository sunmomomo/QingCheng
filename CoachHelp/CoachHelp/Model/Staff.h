//
//  Staff.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Position.h"

@interface Staff : NSObject

@property(nonatomic,assign)NSInteger staffId;

@property(nonatomic,assign)NSInteger shipId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,copy)NSURL *iconUrl;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,strong)Position *position;

@property(nonatomic,assign)SexType sex;

@end
