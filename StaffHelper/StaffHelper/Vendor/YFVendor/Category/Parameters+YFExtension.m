//
//  Parameters+YFExtension.m
//  StaffHelper
//
//  Created by FYWCQ on 17/4/7.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "Parameters+YFExtension.h"

@implementation Parameters (YFExtension)

+ (instancetype)instanceYF
{
    return [[[self class] alloc] init];
}
+ (instancetype)instanceYFWithGym:(Gym *)gym
{
    Parameters *pa = [Parameters instanceYF];
    
    [pa setParamWithGym:gym];
    
    return pa;
}

- (void)setParamWithGym:(Gym *)gym
{
    if (gym.type.length &&gym.gymId) {
        
        [self setParameter:[NSNumber numberWithInteger:gym.gymId] forKey:@"id"];
        
        [self setParameter:gym.type forKey:@"model"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [self setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [self setInteger:gym.brand.brandId forKey:@"brand_id"];
    }

}

@end
