//
//  BrandDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandDetailInfo.h"

#define API @"/api/staffs/%ld/brands/%ld/"

@implementation BrandDetailInfo

-(void)requestWithBrand:(Brand *)brand result:(void (^)(BOOL, NSString *, Brand *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,StaffId,(long)brand.brandId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            Brand *brand = [[Brand alloc]init];
            
            NSDictionary *brandDict = responseDic[@"data"][@"brand"];
            
            brand.name = brandDict[@"name"];
            
            brand.brandId = [brandDict[@"id"] integerValue];
            
            brand.imgURL = [NSURL URLWithString:brandDict[@"photo"]];
            
            brand.havePower = [brandDict[@"has_add_permission"] boolValue];
            
            brand.gymCount = [brandDict[@"gym_count"] integerValue];
            
            if ([brandDict[@"created_at"] length]) {
                
                brand.createTime = [brandDict[@"created_at"] stringByReplacingOccurrencesOfString:@"T" withString:@" "];
                
            }
            
            NSDictionary *ownerDict = brandDict[@"created_by"];
            
            Staff *owner = [[Staff alloc]init];
            
            owner.name = ownerDict[@"username"];
            
            owner.phone = ownerDict[@"phone"];
            
            if (ownerDict[@"area_code"]) {
                
                owner.country = [[CountryPhoneInfo sharedInfo]getCountryWithCode:ownerDict[@"area_code"]];
                
            }
            
            owner.staffId = [ownerDict[@"id"] integerValue];
            
            brand.owner = owner;
            
            brand.cname = brandDict[@"cname"];
            
            if (self.callBack) {
                
                self.callBack(YES,nil,brand);
                
                self.callBack = nil;
                
            }
            
        }else{
            
            if (self.callBack) {
                
                self.callBack(NO,responseDic[@"msg"],nil);
                
                self.callBack = nil;
                
            }
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        if (self.callBack) {
            
            self.callBack(NO,error,nil);
            
            self.callBack = nil;
            
        }
        
    }];
    
}

@end
