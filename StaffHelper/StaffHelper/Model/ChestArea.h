//
//  ChestArea.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/9/5.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    ChestAreaFilterTypeAll = 0,
    ChestAreaFilterTypeTemp = 1,
    ChestAreaFilterTypeLong = 2,
    ChestAreaFilterTypeEmpty = 3,
} ChestAreaFilterType;

@interface ChestArea : NSObject

@property(nonatomic,copy)NSString *areaName;

@property(nonatomic,assign)NSInteger areaId;

@property(nonatomic,assign)BOOL choosed;

@property(nonatomic,strong)NSMutableArray *chests;

@property(nonatomic,assign)ChestAreaFilterType filterType;

@end
