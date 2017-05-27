//
//  CoursePicturesInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/19.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "CoursePlanBatch.h"

@interface CoursePicturesInfo : NSObject

@property(nonatomic,strong)NSMutableArray *batches;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCourse:(Course *)course result:(void(^)(BOOL success,NSString *error))result;

@end
