//
//  GuideInfo.m
//  StaffHelper
//
//  Created by 馍馍帝😈 on 16/3/31.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideInfo.h"

#import "UIColor+Hex.h"

#define API @"/api/systems/initial/"

@implementation GuideInfo

+(GuideInfo *)uploadCourse:(Course *)course result:(void (^)(BOOL, NSString *,Gym *))result
{
    
    GuideInfo *info = [[GuideInfo alloc]init];
    
    info.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    [para setParameter:[NSNumber numberWithBool:NO] forKey:@"auto_trial"];
    
    NSMutableDictionary *shopDict = [NSMutableDictionary dictionary];
    
    [shopDict setValue:course.gym.name forKey:@"name"];
    
    [shopDict setValue:course.gym.contact forKey:@"phone"];
    
    [shopDict setValue:course.gym.summary forKey:@"description"];
    
    [shopDict setValue:course.gym.address forKey:@"address"];
    
    [shopDict setValue:course.gym.districtCode forKey:@"gd_district_id"];
    
    [shopDict setValue:course.gym.imgUrl.absoluteString forKey:@"photo"];
    
    [para setParameter:shopDict forKey:@"shop"];
    
    [para setParameter:[NSNumber numberWithInteger:course.gym.brand.brandId] forKey:@"brand_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            NSDictionary *gymDict = responseDic[@"data"];
            
            Gym *tempGym = [[Gym alloc]init];
            
            tempGym.gymId = [gymDict[@"id"] integerValue];
            
            tempGym.type = gymDict[@"model"];
            
            tempGym.name = gymDict[@"name"];
            
            tempGym.brand.name = gymDict[@"brand_name"];
            
            tempGym.brand.brandId = [gymDict[@"brand_id"] integerValue];
            
            tempGym.imgUrl = [NSURL URLWithString:gymDict[@"photo"]];
            
            tempGym.color = [UIColor colorWithHexString:gymDict[@"color"]];
            
            tempGym.contact = gymDict[@"phone"];
            
            tempGym.systemEnd = gymDict[@"system_end"];
            
            tempGym.shopId = [gymDict[@"shop_id"] integerValue];
            
            tempGym.address = gymDict[@"address"];
            
            info.callBack(YES,nil,tempGym);
            
            info.callBack = nil;
            
        }else
        {
            
            info.callBack(NO,responseDic[@"msg"],nil);
            
            info.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        info.callBack(NO,error,nil);
        
        info.callBack = nil;
        
    }];
    
    return info;
    
}

@end
