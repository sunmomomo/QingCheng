//
//  GymBrandInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 2017/3/8.
//  Copyright © 2017年 馍馍帝👿. All rights reserved.
//

#import "GymBrandInfo.h"

#import "ServicesInfo.h"

#define API @"/api/v1/coaches/%ld/brands/"

@implementation GymBrandInfo

-(void)requestResult:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    [[ServicesInfo shareInfo]requestSuccess:^{
        
        [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,CoachId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
            
            if ([responseDic[@"status"] integerValue] == 200) {
                
                self.brands = [NSMutableArray array];
                
                NSArray *brands = responseDic[@"data"][@"brands"];
                
                NSMutableArray *gymBrands = [NSMutableArray array];
                
                [brands enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                    
                    Brand *brand = [[Brand alloc]init];
                    
                    brand.name = obj[@"name"];
                    
                    brand.brandId = [obj[@"id"] integerValue];
                    
                    brand.imgURL = [NSURL URLWithString:obj[@"photo"]];
                    
                    brand.havePower = [obj[@"has_permission"] boolValue];
                    
                    brand.gymCount = [obj[@"gym_count"] integerValue];
                    
                    if ([obj[@"created_at"] length]) {
                        
                        brand.createTime = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                        
                    }
                    
                    if ([obj[@"owner"] count]) {
                        
                        NSDictionary *ownerDict = [obj[@"owner"]firstObject];
                        
                        Staff *owner = [[Staff alloc]init];
                        
                        owner.name = ownerDict[@"username"];
                        
                        owner.phone = ownerDict[@"phone"];
                        
                        owner.staffId = [ownerDict[@"id"] integerValue];
                        
                        brand.owner = owner;
                        
                    }
                    
                    brand.cname = obj[@"cname"];
                    
                    NSMutableArray *gyms = [NSMutableArray array];
                    
                    for (Gym *gym in [ServicesInfo shareInfo].services) {
                        
                        if (gym.brand.brandId == brand.brandId) {
                            
                            [gyms addObject:gym];
                            
                        }
                        
                    }
                    
                    brand.gyms = gyms;
                    
                    [gymBrands addObject:brand];
                    
                }];
                
                self.brands = gymBrands;
                
                NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"gymCount" ascending:NO];
                
                NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
                
                self.brands = [[self.brands sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
                
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
                
                if (self.callBack) {
                    
                    self.callBack(NO,error);
                    
                    self.callBack = nil;
                    
                }
                
            }
            
        }];
        
    } Failure:^{
        
        if (self.callBack) {
            
            if (self.callBack) {
                
                self.callBack(NO,@"服务器连接失败");
                
                self.callBack = nil;
                
            }
            
        }
        
    }];
    
}

@end
