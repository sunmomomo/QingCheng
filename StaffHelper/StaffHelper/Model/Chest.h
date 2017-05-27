//
//  Chest.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "ChestArea.h"

@interface Chest : NSObject

@property(nonatomic,copy)NSString *name;

@property(nonatomic,assign)NSInteger chestId;

@property(nonatomic,assign)BOOL isUsed;

@property(nonatomic,strong)ChestArea *area;

@property(nonatomic,assign)BOOL longTermUse;

@property(nonatomic,copy)NSString *start;

@property(nonatomic,copy)NSString *end;

@property(nonatomic,assign)NSInteger remain;

@property(nonatomic,strong)Student *borrowUser;

@end
