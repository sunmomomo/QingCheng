//
//  BrandListInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/4/25.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandListInfo.h"

#define API @"/api/users/%ld/brands/"

#define CreateAPI @"/api/brands/"

#define ChangeAPI @"/api/brands/%ld/"

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
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,UserId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
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
                
                if ([obj[@"owner"] count]) {
                    
                    NSDictionary *ownerDict = [obj[@"owner"]firstObject];
                    
                    Staff *owner = [[Staff alloc]init];
                    
                    owner.name = ownerDict[@"username"];
                    
                    owner.phone = ownerDict[@"phone"];
                    
                    owner.staffId = [ownerDict[@"id"] integerValue];
                    
                    brand.owner = owner;
                    
                }
                
                brand.cname = obj[@"cname"];
                
                [self.brands addObject:brand];
                
            }];
            
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
    
}

-(void)createBrand:(Brand *)brand result:(void (^)(BOOL, NSString *))result
{
    
    self.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:brand.imgURL.absoluteString forKey:@"photo"];
    
    [para setParameter:brand.name forKey:@"name"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:CreateAPI postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            brand.brandId = [responseDic[@"data"][@"brand"][@"id"] integerValue];
            
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


@end
