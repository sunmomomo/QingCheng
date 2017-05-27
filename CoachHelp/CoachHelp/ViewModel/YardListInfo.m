//
//  YardListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "YardListInfo.h"

#define API @"/api/v1/coaches/%ld/spaces/"

@implementation YardListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.allYards = [NSArray array];
        
        self.privateYards = [NSArray array];
        
        self.groupYards = [NSArray array];
        
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
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"spaces"];
            
            NSMutableArray *yards = [NSMutableArray array];
            
            NSMutableArray *groups = [NSMutableArray array];
            
            NSMutableArray *privates = [NSMutableArray array];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Yard *yard = [[Yard alloc]init];
                
                yard.name = obj[@"name"];
                
                yard.yardId = [obj[@"id"] integerValue];
                
                yard.capacity = [obj[@"capacity"] integerValue];
                
                BOOL supportPrivate = [obj[@"is_support_private"] boolValue];
                
                BOOL supportGroup = [obj[@"is_support_team"]boolValue];

                yard.type = supportPrivate && supportGroup?YardTypeUnlimited: supportPrivate && !supportGroup?YardTypePrivate:YardTypeGroup;
                
                if (supportGroup) {
                    
                    [groups addObject:yard];
                    
                }
                
                if (supportPrivate) {
                    
                    [privates addObject:yard];
                    
                }
                
                [yards addObject:yard];
                
            }];
            
            self.allYards = [yards copy];
            
            self.groupYards = [groups copy];
            
            self.privateYards = [privates copy];
            
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
