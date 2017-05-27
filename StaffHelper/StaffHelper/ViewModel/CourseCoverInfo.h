//
//  CourseCoverInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseCoverInfo : NSObject

@property(nonatomic,strong)NSMutableArray *covers;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)requestWithCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)editCovers:(NSArray *)covers withCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

-(void)editCustomCover:(BOOL)customCover withCourse:(Course*)course result:(void(^)(BOOL success,NSString *error))result;

@end
