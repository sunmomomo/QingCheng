//
//  BrandListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandListInfo.h"

#define API @"/api/staffs/%ld/brands/"

#define ChangeAPI @"/api/brands/%ld/"

#define CreaterAPI @"/api/brands/%ld/change_user/"

@implementation BrandListInfo

- (instancetype)init
{
    self = [super init];
    if (self) {
        
    }
    return self;
}

-(void)requestResult:(void(^)(BOOL success,NSString *error))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            self.brands = [NSMutableArray array];
            
            NSArray *brands = responseDic[@"data"][@"brands"];
            
            [brands enumerateObjectsUsingBlock:^(id  _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
                
                Brand *brand = [[Brand alloc]init];
                
                brand.name = obj[@"name"];
                
                brand.brandId = [obj[@"id"] integerValue];
                
                brand.imgURL = [NSURL URLWithString:obj[@"photo"]];
                
                brand.havePower = [obj[@"has_add_permission"] boolValue];
                
                brand.gymCount = [obj[@"gym_count"] integerValue];
                
                if ([obj[@"created_at"] length]) {
                    
                    brand.createTime = [obj[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                    
                }
                
                NSDictionary *ownerDict = obj[@"created_by"];
                
                Staff *owner = [[Staff alloc]init];
                
                owner.name = ownerDict[@"username"];
                
                owner.phone = ownerDict[@"phone"];
                
                owner.staffId = [ownerDict[@"id"] integerValue];
                
                brand.owner = owner;
                
                brand.cname = obj[@"cname"];
                
                [self.brands addObject:brand];
                
            }];
            
            NSSortDescriptor *descriptor = [[NSSortDescriptor alloc] initWithKey:@"gymCount" ascending:NO];
            
            NSArray *sortDescriptors = [NSArray arrayWithObjects:descriptor, nil];
            
            self.brands = [[self.brands sortedArrayUsingDescriptors:sortDescriptors] mutableCopy];
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else
        {
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            if (self.callBack) {
                
                self.callBack(NO,error);
                
            }
            
        }
        
    }];
    
}

-(void)changeBrand:(Brand *)brand result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:brand.imgURL.absoluteString forKey:@"photo"];
    
    [para setParameter:brand.name forKey:@"name"];
    
    [MOAFHelp AFPutHost:ROOT bindPath:[NSString stringWithFormat:ChangeAPI,(long)brand.brandId] putParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

-(void)changeCreaterOfBrand:(Brand *)brand withCode:(NSString *)code result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:brand.owner.phone forKey:@"phone"];
    
    [para setParameter:brand.owner.country.countryNo forKey:@"area_code"];
    
    [para setParameter:code forKey:@"code"];
    
    [para setParameter:brand.owner.name forKey:@"username"];
    
    [para setParameter:[NSNumber numberWithInteger:brand.owner.sex] forKey:@"gender"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:[NSString stringWithFormat:CreaterAPI,(long)brand.brandId] postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            if (self.callBack) {
                
                self.callBack(YES,nil);
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"]);
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error);
            
        }
        
    }];
    
}

@end
