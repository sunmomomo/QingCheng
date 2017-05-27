//
//  BodyTestInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/1/12.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "BodyTestType.h"

#import "BodyTest.h"

@interface BodyTestInfo : NSObject

@property(nonatomic,assign)NSInteger infoId;

@property(nonatomic,strong)NSMutableArray *basicTypes;

@property(nonatomic,strong)NSMutableArray *otherTypes;

@property(nonatomic,strong)NSMutableArray *photos;

@property(nonatomic,copy)NSString *date;

@property(nonatomic,copy)void(^request)(BOOL success);

@property(nonatomic,copy)void(^changeFinish)(BOOL success);

@property(nonatomic,copy)void(^deleteFinish)(BOOL success);

@property(nonatomic,strong)BodyTest *bodyTest;

-(void)getAddInfoWithStudent:(Student*)stu;

-(void)deleteInfo;

-(void)getInfoWithTest:(BodyTest*)test;

-(BodyTestType *)getTypeForTypeName:(NSString *)name;

-(void)changeInfoWithIsAdd:(BOOL)isAdd;

@end
