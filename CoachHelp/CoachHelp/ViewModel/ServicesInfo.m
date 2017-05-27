//
//  ServicesInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ServicesInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/v1/coaches/%ld/services/"

#import "DistrictInfo.h"

@interface ServicesInfo ()

@property(nonatomic,assign)NSInteger brandId;

@end

@implementation ServicesInfo

+(instancetype)shareInfo
{
    
    static ServicesInfo *info;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        info = [[[self class]alloc]init];
        
    });
    
    return info;
    
}

-(void)requestSuccess:(void (^)())success Failure:(void (^)())failure
{
    
    self.callBackSuccess = success;
    
    self.callBackFailure = failure;
    
    self.services = [NSArray array];
    
    if (!CoachId) {
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackSuccess = nil;
            
            self.callBackFailure = nil;
            
        }
        
        return;
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {

        if ([responseDic[@"status"] integerValue] == 200) {
            
            [self createDataWithArray:responseDic[@"data"][@"services"]];
            
            if (self.callBackSuccess) {
                
                self.callBackSuccess();
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }
            
        }else
        {
            
            if (self.callBackFailure) {
                
                self.callBackFailure();
                
                self.callBackSuccess = nil;
                
                self.callBackFailure = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBackFailure) {
            
            self.callBackFailure();
            
            self.callBackSuccess = nil;
            
            self.callBackFailure = nil;
            
        }
        
    }];
    
}


-(void)createDataWithArray:(NSArray *)array
{
    
    NSMutableArray *gyms = [NSMutableArray array];
    
    [array enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        Gym *gym = [[Gym alloc]init];
        
        gym.name = obj[@"name"];
        
        gym.gymId = [obj[@"id"] integerValue];
        
        gym.url = [NSURL URLWithString:obj[@"url"]];
        
        gym.userCount = [obj[@"users_count"]integerValue];
        
        gym.courseCount = [obj[@"courses_count"]integerValue];
        
        gym.imgUrl = [NSURL URLWithString:obj[@"photo"]];
        
        gym.type = obj[@"model"];
        
        gym.brandName = obj[@"brand_name"];
        
        gym.brand.name = obj[@"brand_name"];
        
        gym.brand.brandId = [obj[@"brand_id"]integerValue];
        
        [gyms addObject:gym];
        
    }];
    
    self.services = [gyms copy];
    
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.services = [NSArray array];
        
    }
    return self;
}


@end
