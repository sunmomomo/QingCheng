//
//  Parameters+YFExtension.h
//  StaffHelper
//
//  Created by FYWCQ on 17/4/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "Parameters.h"

@class Gym;
@interface Parameters (YFExtension)

+ (instancetype)instanceYF;

+ (instancetype)instanceYFWithGym:(Gym *)gym;

- (void)setParamWithGym:(Gym *)gym;

@end
