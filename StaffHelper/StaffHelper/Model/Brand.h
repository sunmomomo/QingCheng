//
//  Brand.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Staff.h"

@interface Brand : NSObject<NSCoding>

@property(nonatomic,assign)NSInteger brandId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSURL *imgURL;

@property(nonatomic,strong)UIImage *image;

@property(nonatomic,assign)BOOL havePower;

@property(nonatomic,strong)Staff *owner;

@property(nonatomic,copy)NSString *cname;

@property(nonatomic,assign)NSInteger gymCount;

@property(nonatomic,copy)NSString *createTime;

@end
