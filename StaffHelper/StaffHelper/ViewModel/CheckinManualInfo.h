//
//  CheckinManualInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

#import "CoursePlanBatch.h"

@interface CheckinManualInfo : NSObject

@property(nonatomic,strong)NSMutableArray *cards;

@property(nonatomic,strong)NSMutableArray *courses;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requsetCardsWithStudent:(Student*)stu result:(void(^)(BOOL success,NSString *error))result;

-(void)requestCoursesWithStudent:(Student *)stu result:(void(^)(BOOL success,NSString *error))result;

@end
