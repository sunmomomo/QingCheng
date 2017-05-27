//
//  MeasureDetailInfo.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Measure.h"

#import "MeasureType.h"

@interface MeasureDetailInfo : NSObject

@property(nonatomic,assign)NSInteger infoId;

@property(nonatomic,strong)NSMutableArray *basicTypes;

@property(nonatomic,strong)NSMutableArray *otherTypes;

@property(nonatomic,strong)NSMutableArray *photos;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,copy)void(^changeFinish)(BOOL success);

@property(nonatomic,copy)void(^deleteFinish)(BOOL success);

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

@property(nonatomic,strong)Measure *measure;

-(void)getAddInfoWithStudent:(Student*)stu andGym:(Gym*)gym;

-(void)deleteInfo;

-(void)getInfoWithMeasure:(Measure*)measure;

-(MeasureType *)getTypeForTypeName:(NSString *)name;

-(void)changeInfoResult:(void (^)(BOOL, NSString *))result;

-(void)createaInfoWithGym:(Gym*)gym result:(void(^)(BOOL success,NSString *error))result;


@end
