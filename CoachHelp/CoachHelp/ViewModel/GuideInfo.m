//
//  GuideInfo.m
//  CoachHelp
//
//  Created by 馍馍帝😈 on 16/11/16.
//  Copyright © 2016年 馍馍帝👿. All rights reserved.
//

#import "GuideInfo.h"

#define  API @"/api/coach/systems/initial/"

@implementation GuideInfo

+(void)uploadResult:(void (^)(BOOL, NSString *))result
{
    
    GuideInfo *info = [[GuideInfo alloc]init];
    
    info.callBack = result;
    
    Parameters *para = [[Parameters alloc]init];
    
    Guide *guide = MOAppDelegate.guide;
    
    NSMutableDictionary *shopDict = [NSMutableDictionary dictionary];
    
    [shopDict setValue:guide.gym.name forKey:@"name"];
    
    [shopDict setValue:guide.gym.contact forKey:@"phone"];
    
    [shopDict setValue:guide.gym.imgUrl.absoluteString forKey:@"photo"];
    
    [shopDict setValue:guide.gym.address forKey:@"address"];
    
    [shopDict setValue:guide.gym.districtCode forKey:@"gd_district_id"];
    
    [para setParameter:shopDict forKey:@"shop"];
    
    [para setParameter:[NSNumber numberWithInteger:guide.brand.brandId] forKey:@"brand_id"];
    
    [MOAFHelp AFPostHost:ROOT bindPath:API postParam:para.data success:^(AFHTTPSessionManager *operation, NSDictionary *responseDic) {
        
        if ([responseDic[@"status"] integerValue] == 200) {
            
            info.callBack(YES,nil);
            
            info.callBack = nil;
            
        }else
        {
            
            info.callBack(NO,responseDic[@"msg"]);
            
            info.callBack = nil;
            
        }
        
    } failure:^(AFHTTPSessionManager *operation, NSString *error) {
        
        info.callBack(NO,error);
        
        info.callBack = nil;
        
    }];
    
}

@end
