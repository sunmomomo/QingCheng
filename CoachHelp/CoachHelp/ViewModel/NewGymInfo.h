//
//  NewGymInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Course.h"

#import "Brand.h"

@interface NewGymInfo : NSObject

@property(nonatomic,strong)NSMutableArray *brands;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestBrandsResult:(void(^)(BOOL success,NSString *error))result;

-(void)createBrand:(Brand*)brand Result:(void(^)(BOOL success,NSString *error))result;

-(void)createGymWithGym:(Gym*)gym Result:(void(^)(BOOL success,NSString *error))result;

@end
