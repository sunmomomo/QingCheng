//
//  Guide.h
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/11.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "Brand.h"

#import "Course.h"

@interface Guide : NSObject<NSCoding>

@property(nonatomic,strong)Brand *brand;

@property(nonatomic,strong)Gym *gym;

@property(nonatomic,strong)Course *course;

@end
