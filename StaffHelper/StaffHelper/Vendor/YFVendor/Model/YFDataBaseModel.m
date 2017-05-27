//
//  YFDataBaseModel.m
//  StaffHelper
//
//  Created by FYWCQ on 16/12/22.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YFDataBaseModel.h"
#import "YFAppService.h"

@implementation YFDataBaseModel


+ (instancetype)dataModel
{
    return [[[self class] alloc] init];
}

- (void)showAlertMessage:(NSString *)message
{
    [YFAppService showAlertMessage:message];
}


- (void)getResponseDatashowLoadingOn:(UIView *)superView successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
}
- (void)getResponseDatashowLoadingOn:(UIView *)superView gym:(Gym *)gym successBlock:(void (^)())successBlock failBlock:(void (^)())failBlock
{
    
}

-(Parameters *)parameteYF
{
    Parameters *para = [[Parameters alloc]init];

    return para;
}

-(Parameters *)paraWithGym:(Gym *)gym
{
    Parameters *para = [[Parameters alloc]init];
    
    if (AppGym.type.length &&AppGym.gymId) {
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.gymId] forKey:@"id"];
        
        [para setParameter:AppGym.type forKey:@"model"];
        
    }else if(AppGym.shopId && AppGym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:AppGym.shopId] forKey:@"shop_id"];
        
        [para setInteger:AppGym.brand.brandId forKey:@"brand_id"];
        
    }else if (gym.gymId && gym.type.length){
        
        [para setParameter:gym.type forKey:@"model"];
        
        [para setInteger:gym.gymId forKey:@"id"];
        
    }else if(gym.shopId && gym.brand.brandId){
        
        [para setParameter:[NSNumber numberWithInteger:gym.shopId] forKey:@"shop_id"];
        
        [para setInteger:gym.brand.brandId forKey:@"brand_id"];
        
    }else{
        
        [para setParameter:BRANDID forKey:@"brand_id"];
        
    }
    return para;
}



@end
