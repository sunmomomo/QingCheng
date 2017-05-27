//
//  IntegralInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 2016/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "IntegralSetting.h"

@interface IntegralInfo : NSObject

@property(nonatomic,strong)NSMutableArray *users;

@property(nonatomic,strong)IntegralSetting *setting;

@property(nonatomic,assign)NSInteger page;

@property(nonatomic,assign)NSInteger totalPages;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestListResult:(void(^)(BOOL success,NSString *error))result;

@end
