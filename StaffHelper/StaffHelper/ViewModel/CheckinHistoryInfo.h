//
//  CheckinHistory.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/29.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Checkin.h"

@interface CheckinHistoryInfo : NSObject

@property(nonatomic,strong)NSMutableArray *checkins;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
