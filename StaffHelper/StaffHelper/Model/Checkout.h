//
//  Checkout.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "Card.h"

#import "Chest.h"

@interface Checkout : NSObject

@property(nonatomic,strong)Student *student;

@property(nonatomic,strong)Card *card;

@property(nonatomic,strong)Chest *chest;

@property(nonatomic,assign)NSInteger checkoutId;

@property(nonatomic,copy)NSString *createdTime;

@property(nonatomic,copy)NSString *modifyAt;

@end
