//
//  CourseMeassureInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CourseMeassure.h"

@interface CourseMeassureInfo : NSObject

@property(nonatomic,strong)NSMutableArray *meassures;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
