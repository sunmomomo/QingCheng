//
//  CourseMeassure.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/8/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CourseMeassure : NSObject

@property(nonatomic,assign)NSInteger meassureId;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,strong)NSArray *tags;

-(NSString *)tagsDescription;

@end
