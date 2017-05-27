//
//  ServicesInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "ServicesInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/staffs/%ld/services/"

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
    
    if (!StaffId) {
        
        self.services = [NSArray array];
        
        if (self.callBackSuccess) {
            
            self.callBackSuccess();
            
            self.callBackSuccess = nil;
            
            self.callBackFailure = nil;
            
        }
        
        return;
        
    }
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {

        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.brandId = [BRANDID integerValue];
            
            NSMutableArray *array = [NSMutableArray array];
            
            NSArray *services = responseDic[@"data"][@"services"];
            
            [services enumerateObjectsUsingBlock:^(NSDictionary* obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Gym *gym = [[Gym alloc]init];
                
                [gym resultJson:obj];
                
                [array addObject:gym];
                
            }];
            
            self.services = [array copy];
            
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

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        self.services = [NSArray array];
        
    }
    return self;
}


@end
