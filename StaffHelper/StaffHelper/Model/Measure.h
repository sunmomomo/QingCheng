//
//  Measure.h
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/26.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Student.h"

@interface Measure : NSObject

@property(nonatomic,copy)NSString *date;

@property(nonatomic,assign)NSInteger measureId;

@property(nonatomic,strong)Student *student;

@end
