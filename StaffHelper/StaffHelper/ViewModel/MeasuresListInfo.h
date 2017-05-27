//
//  MeasuresListInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Measure.h"

@interface MeasuresListInfo : NSObject

@property(nonatomic,strong)NSMutableArray *measures;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithStuId:(NSInteger)stuId result:(void(^)(BOOL success,NSString *error))result;

@end
