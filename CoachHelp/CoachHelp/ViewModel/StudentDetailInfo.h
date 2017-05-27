//
//  StudentDetailInfo.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/11/19.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Card.h"

#import "Record.h"

#import "BodyTest.h"

@interface StudentDetailInfo : NSObject

@property(nonatomic,strong)NSMutableArray *recordArray;

@property(nonatomic,strong)NSMutableArray *cardArray;

@property(nonatomic,strong)NSMutableArray *testArray;

@property(nonatomic,strong)Student *student;

@property(nonatomic,copy)NSURL *privateURL;

@property(nonatomic,copy)NSURL *groupURL;

@property(nonatomic,copy)void(^stuData)(BOOL success);

@property(nonatomic,copy)void(^cardData)(BOOL success);

@property(nonatomic,copy)void(^recordData)(BOOL success);

@property(nonatomic,copy)void(^bodyTestData)(BOOL success);

@property(nonatomic,copy)void(^deleteFinish)(BOOL success);

-(instancetype)initWithStudent:(Student *)student;

-(void)deleteWithStudentId:(NSInteger)stuId;

-(void)reloadTestData;

@end
