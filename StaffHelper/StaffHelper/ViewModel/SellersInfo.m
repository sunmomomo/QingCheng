//
//  SellersInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/27.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "SellersInfo.h"

#import "YFRequestHeader.h"

@implementation SellersInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.sellers = [NSMutableArray array];
        
    }
    return self;
}

- (void)requestOnlySellerWithGym:(Gym *)gym Result:(void (^)(BOOL, NSString *))result
{
    self.callBack = result;
    
    Parameters *para = [self paramForSellerAndCoachWithGym:gym];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kSellersWithoutCoachListRequestYF,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            
            [self resultDic:responseDic];
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
            
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];

}

-(void)requestWithGym:(Gym *)gym Result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [self paramForSellerAndCoachWithGym:gym];
    
   
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:kSellersListRequestYF,StaffId] param:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            
            [self resultDic:responseDic];
            
            self.callBack(YES,nil);
            
            self.callBack = nil;
            
        }else
        {
            
            self.callBack(NO,responseDic[@"msg"]);
                
            self.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        self.callBack(NO,error);
        
        self.callBack = nil;
        
    }];
    
}

- (Parameters *)paramForSellerAndCoachWithGym:(Gym *)gym
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

- (void)resultDic:(NSDictionary *)responseDic
{
    NSArray *array = responseDic[@"data"][@"users"];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Seller *seller = [[Seller alloc]init];
        
        seller.sellerId = [obj[@"id"] integerValue];
        
        seller.name = obj[@"username"];
        
        seller.iconURL = [NSURL URLWithString:obj[@"avatar"]];
        
        [self.sellers addObject:seller];
        
    }];
}


@end
