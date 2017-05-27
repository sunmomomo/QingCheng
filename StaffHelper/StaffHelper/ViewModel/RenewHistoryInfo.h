//
//  RenewHistoryInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/20.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "RenewHistory.h"

@interface RenewHistoryInfo : NSObject

@property(nonatomic,strong)NSMutableArray *histories;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
