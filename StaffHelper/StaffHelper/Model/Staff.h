//
//  Staff.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Position.h"

#import "CountryChooseTextField.h"

@interface Staff : NSObject

@property(nonatomic,assign)NSInteger userId;

@property(nonatomic,assign)NSInteger staffId;

@property(nonatomic,assign)NSInteger shipId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *phone;

@property(nonatomic,strong)CountryPhone *country;

@property(nonatomic,copy)NSURL *iconUrl;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,strong)Position *position;

@property(nonatomic,assign)SexType sex;

@property(nonatomic,assign)BOOL admin;

@end
