//
//  Gym.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/9/28.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Brand.h"

#import "Permissions.h"

#import "CourseRate.h"

typedef enum : NSUInteger {
    GymTypeGym = 0,
    GymTypeService = 1,
} GymType;

@interface Gym : NSObject<NSCoding>

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,assign)NSInteger shopId;

@property(nonatomic,assign)NSInteger gymId;

@property(nonatomic,copy)NSString *brandName;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *systemEnd;

@property(nonatomic,copy)NSString *contact;

@property(nonatomic,copy)NSString *summary;

@property(nonatomic,copy)NSString *address;

@property(nonatomic,assign)BOOL ishot;

@property(nonatomic,copy)NSString *city;

@property(nonatomic,copy)NSString *districtCode;

@property(nonatomic,strong)UIColor *color;

@property(nonatomic,copy)NSURL *imgUrl;

@property(nonatomic,copy)NSURL *url;

@property(nonatomic,copy)NSURL *privateUrl;

@property(nonatomic,copy)NSURL *groupUrl;

@property(nonatomic,assign)BOOL isCertificate;

@property(nonatomic,assign)NSInteger courseCount;

@property(nonatomic,assign)NSInteger userCount;

@property(nonatomic,copy)NSString *type;

@property(nonatomic,strong)CourseRate *rate;

@property(nonatomic,strong)Permissions *permissions;

@property(nonatomic,assign)BOOL havePrivate;

@property(nonatomic,assign)BOOL havePermission;

@property(nonatomic,copy)NSString *position;

@property(nonatomic,strong)Staff *superuser;

@property(nonatomic,assign)NSInteger remainDays;

@property(nonatomic,assign)BOOL pro;

@end
