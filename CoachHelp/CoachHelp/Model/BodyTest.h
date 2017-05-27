//
//  BodyTest.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 15/12/3.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

@interface BodyTest : NSObject

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)NSInteger testId;

@property(nonatomic,strong)Student *student;

@end
