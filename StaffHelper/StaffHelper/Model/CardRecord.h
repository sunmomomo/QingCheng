//
//  CardRecord.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

@interface CardRecord : NSObject

@property(nonatomic,copy)NSString *createTime;

@property(nonatomic,copy)NSString *month;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)NSString *cost;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,assign)BOOL first;

@property(nonatomic,copy)NSString *typeName;

@property(nonatomic,assign)NSInteger type;

@property(nonatomic,strong)Course *course;

@property(nonatomic,copy)NSString *courseUser;

@property(nonatomic,assign)NSInteger courseUserCount;

@property(nonatomic,copy)NSString *courseTime;

@property(nonatomic,copy)NSString *seller;

@end
