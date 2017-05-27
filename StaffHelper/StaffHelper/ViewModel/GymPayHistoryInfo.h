//
//  GymPayHistoryInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2017/1/17.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "GymPayHistory.h"

@interface GymPayHistoryInfo : NSObject

@property(nonatomic,strong)NSMutableArray *histories;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
