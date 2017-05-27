//
//  NewGymInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/1.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "NewGymInfo.h"

#import "NSString+Category.h"

#define BrandListAPI @"/api/users/%ld/brands/"

#define BrandAPI @"/api/brands/"

#define GymAPI @"/api/coach/systems/initial/"

@implementation NewGymInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestBrandsResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    self.brands = [NSMutableArray array];
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:BrandListAPI,UserId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSArray *array = responseDic[@"data"][@"brands"];
            
            [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Brand *brand = [[Brand alloc]init];
                
                brand.brandId = [obj[@"id"] integerValue];
                
                brand.name = obj[@"name"];
                
                [self.brands addObject:brand];
                
            }];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)createGymWithGym:(Gym *)gym Result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithInteger:gym.brand.brandId] forKey:@"brand_id"];
    
    NSMutableDictionary *shopDict = [NSMutableDictionary dictionary];
    
    [shopDict setValue:gym.name forKey:@"name"];
    
    [shopDict setValue:gym.address forKey:@"address"];
    
    [shopDict setValue:gym.districtCode forKey:@"gd_district_id"];
    
    [shopDict setValue:gym.imgUrl.absoluteString forKey:@"photo"];
    
    [para setParameter:shopDict forKey:@"shop"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:GymAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            gym.gymId = [responseDic[@"data"][@"gym_id"] integerValue];
            
            gym.type = responseDic[@"data"][@"model"];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

-(void)createBrand:(Brand *)brand Result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:brand.name forKey:@"name"];
    
    [para setParameter:brand.imgURL.absoluteString forKey:@"photo"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:BrandAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            brand.brandId = [responseDic[@"data"][@"brand"][@"id"] integerValue];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
                self.callBack = nil;
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end
