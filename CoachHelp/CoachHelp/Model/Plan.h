//
//  Plan.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    PlanTypePersonal = 1,
    PlanTypeGroup = 2,
    PlanTypeOrganization = 3,
} PlanType;

@interface Plan : NSObject

@property(nonatomic,copy)NSString *planName;

@property(nonatomic,strong)NSArray *tags;

@property(nonatomic,assign)NSInteger planId;

@property(nonatomic,assign)PlanType type;

@property(nonatomic,copy)NSString *brandName;

@property(nonatomic,copy)NSURL *url;

@end
