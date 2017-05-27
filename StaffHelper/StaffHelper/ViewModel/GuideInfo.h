//
//  GuideInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

@interface GuideInfo : NSObject

@property(nonatomic,strong)void(^callBack)(BOOL result,NSString *error,Gym *gym);

+(GuideInfo*)uploadCourse:(Course*)course result:(void(^)(BOOL success,NSString *error,Gym *gym))result;

@end
