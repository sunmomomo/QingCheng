//
//  PositionInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/5/10.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "PositionInfo.h"

#define API @"/api/staffs/%ld/positions/"

@implementation PositionInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.positions = [NSArray array];
        
    }
    return self;
}

-(void)requestWithGym:(Gym *)gym
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

    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] ==200) {
            
            NSMutableArray *positions = [NSMutableArray array];
            
            [responseDic[@"data"][@"positions"] enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Position *position = [[Position alloc]init];
                
                position.name = obj[@"name"];
                
                position.positionId = [obj[@"id"] integerValue];
                
                [positions addObject:position];
                
            }];
            
            self.positions = [positions copy];
            
            if (self.requestFinish) {
                self.requestFinish(YES);
            }
            
        }else
        {
            
            if (self.requestFinish) {
                self.requestFinish(NO);
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.requestFinish) {
            self.requestFinish(NO);
        }
        
    }];
    
}

@end
