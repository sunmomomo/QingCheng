//
//  CardRecordInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/13.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CardRecord.h"

#import "Card.h"

@interface CardRecordInfo : NSObject

@property(nonatomic,copy)NSString *totalCharge;

@property(nonatomic,copy)NSString *totalCost;

@property(nonatomic,assign)NSInteger month;

@property(nonatomic,copy)void(^requestFinish)(BOOL success);

@property(nonatomic,strong)NSMutableArray *records;

-(void)requestWithCard:(Card*)card withMonth:(NSInteger)month andYear:(NSInteger)year;

-(void)update;

@end
