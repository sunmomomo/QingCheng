//
//  BrandDetailInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/7/14.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "BrandDetailInfo.h"

#define API @"/api/brands/%ld/"

@implementation BrandDetailInfo

-(void)requestWithBrand:(Brand *)brand result:(void (^)(BOOL, NSString *, Brand *))result
{
    
    self.callBack = result;
    
    [MOAFHelp AFGetHost:ROOT bindPath:[NSString stringWithFormat:API,(long)brand.brandId] param:nil success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            Brand *brand = [[Brand alloc]init];
            
            NSDictionary *brandDict = responseDic[@"data"][@"brand"];
            
            brand.name = brandDict[@"name"];
            
            brand.brandId = [brandDict[@"id"] integerValue];
            
            brand.imgURL = [NSURL URLWithString:brandDict[@"photo"]];
            
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
