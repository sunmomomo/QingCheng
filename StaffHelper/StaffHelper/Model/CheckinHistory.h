//
//  CheckinHistory.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

@interface CheckinHistory : NSObject

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)Card *card;

@property(nonatomic,copy)NSString *checkinTime;

@property(nonatomic,copy)NSString *checkoutTime;

@property(nonatomic,assign)BOOL haveCanceled;

@property(nonatomic,copy)NSString *checkinStaffName;

@property(nonatomic,copy)NSString *checkoutStaffName;

@end
