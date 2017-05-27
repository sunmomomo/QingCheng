//
//  GymListInfo.m
//  CoachHelper
//
//  Created by 馍馍帝😈 on 15/10/16.
//  Copyright © 2015年 馍馍帝👿. All rights reserved.
//

#import "GymListInfo.h"

#import "DistrictInfo.h"

#define API @"/api/staffs/%ld/shops/"

#define BrandAPI @"/api/staffs/%ld/brands/%ld/shops/"

@implementation GymListInfo

+(instancetype)shareInfo
{
    
    static GymListInfo *info;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        info = [[[self class]alloc]init];
        
    });
    
    return info;
    
}

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    if (!StaffId) {
        
        self.callBack(NO,nil);
        
        self.callBack = nil;
        
    }else
    {
        
        NSString *api = [NSString stringWithFormat:API,StaffId];
        
        [MOAFHelp AFGetHost:ROOT bindPath:api param:@{@"brand_id":BRANDID} success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"]integerValue] == 200) {
                
                [self createDataWithDict:responseDic[@"data"]];
                
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
    
    
}

-(void)requestWithBrand:(Brand *)brand result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:BrandAPI,StaffId,(long)brand.brandId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"]integerValue] == 200) {
            
            [self createBrandGymWithArray:responseDic[@"data"][@"shops"]];
            
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

-(void)createBrandGymWithArray:(NSArray *)array
{
    
    self.gyms = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *gym = [[Gym alloc]init];
        
        gym.brand.name = obj[@"brand_name"];
        
        gym.position = obj[@"position"];
        
        gym.contact = obj[@"contact"];
        
        gym.ishot = [obj[@"is_hot"] boolValue];
        
        gym.name = obj[@"name"];
        
        gym.gymId = [obj[@"id"] integerValue];
        
        gym.position = obj[@"position"];
        
        gym.superuser = [[Staff alloc]init];
        
        gym.superuser.name = obj[@"superuser"][@"username"];
        
        gym.superuser.staffId = [obj[@"superuser"][@"id"] integerValue];
        
        if ([obj[@"photo"] length]) {
            
            gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
            
        }
        
        if ([obj[@"system_end"] length]) {
            
            gym.systemEnd = [[obj[@"system_end"] componentsSeparatedByString:@"T"] firstObject];
            
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        NSInteger remainDays = [[dateFormatter dateFromString:gym.systemEnd] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]]/86400;
        
        dateFormatter = nil;
        
        gym.pro = remainDays>=0;
        
        [self.gyms addObject:gym];
        
    }];
    
}

-(void)createDataWithDict:(NSDictionary*)dict
{
    
    NSArray *array = dict[@"shops"];
    
    NSDictionary *brandDict = dict[@"brand"];
    
    Brand *brand = [[Brand alloc]init];
    
    brand.brandId = [brandDict[@"id"] integerValue];
    
    brand.name = brandDict[@"name"];
    
    brand.imgURL = [NSURL URLWithString:brandDict[@"photo"]];
    
    self.gyms = [NSMutableArray array];
    
    self.powerGyms = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *gym = [[Gym alloc]init];
        
        gym.name = obj[@"name"];
        
        gym.imgUrl = [NSURL URLWithString:obj[@"photo_url"]];
        
        gym.contact = obj[@"phone"];
        
        gym.brand = brand;
        
        gym.shopId = [obj[@"id"] integerValue];
        
        gym.systemEnd = obj[@"system_end"];
        
        gym.havePower = [obj[@"has_permission"] boolValue];
        
        if(obj[@"gd_district"][@"code"]){
            
            gym.districtCode = obj[@"gd_district"][@"code"];
            
            gym.city = [DistrictInfo cityForDistrictCode:obj[@"gd_district"][@"code"]];
            
        }else{
            
            gym.city = nil;
            
        }
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
        
        dateFormatter.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_CN"];
        
        dateFormatter.dateFormat = @"yyyy-MM-dd";
        
        gym.remainDays = [[dateFormatter dateFromString:gym.systemEnd] timeIntervalSinceDate:[dateFormatter dateFromString:[dateFormatter stringFromDate:[NSDate date]]]]/86400+1;
        
        [self.gyms addObject:gym];
        
        if (gym.havePower) {
            
            [self.powerGyms addObject:gym];
            
        }
        
    }];
    
}

-(NSArray *)getLocalGymsWithGyms:(NSArray *)gyms
{
    
    NSMutableArray *aGyms = [NSMutableArray array];
    
    for (Gym *gym in gyms) {
        
        for (Gym *localGym in self.gyms) {
            
            if (gym.shopId == localGym.shopId && gym.brand.brandId == localGym.brand.brandId) {
                
                [aGyms addObject:localGym];
                
            }
            
        }
        
    }
    
    return aGyms;
    
}

-(NSArray *)getHavePowerGymsWithGyms:(NSArray *)gyms
{
    
    NSMutableArray *aGyms = [NSMutableArray array];
    
    for (Gym *gym in gyms) {
        
        for (Gym *localGym in self.gyms) {
            
            if (gym.shopId == localGym.shopId && gym.brand.brandId == localGym.brand.brandId && gym.havePower) {
                
                [aGyms addObject:localGym];
                
            }
            
        }
        
    }
    
    return aGyms;
    
}

@end
