//
//  MyStudentInfo.h
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

#import "Gym.h"

@interface MyStudentInfo : NSObject

@property(nonatomic,strong)NSMutableArray *students;

@property(nonatomic,strong)NSMutableArray *gyms;

@property(nonatomic,strong)NSMutableArray *showArray;

@property(nonatomic,strong)NSMutableArray *headArray;

@property(nonatomic,strong)void(^callBack)(BOOL success,NSString *error);

-(void)getShowArraySearchText:(NSString *)searchText;

-(void)requestResult:(void(^)(BOOL success,NSString *error))result;

@end
